(function () {
  'use strict';

  var index = window.SEARCH_INDEX || [];
  var root = document.body.getAttribute('data-search-root') || '';
  var overlay = document.getElementById('searchOverlay');
  var searchInput = document.getElementById('searchInput');
  var searchResults = document.getElementById('searchResults');
  var homeInput = document.getElementById('q');
  var homeHits = document.getElementById('searchHits');
  var noResults = document.getElementById('noResults');

  function escapeHtml(value) {
    return String(value).replace(/[&<>"']/g, function (char) {
      return { '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#39;' }[char];
    });
  }

  function search(query) {
    var terms = query.toLowerCase().split(/\s+/).filter(Boolean);
    if (!terms.length) return [];
    var results = [];
    index.forEach(function (entry) {
      var title = (entry.t || '').toLowerCase();
      var heading = (entry.h || '').toLowerCase();
      var text = (entry.x || '').toLowerCase();
      var score = 0;
      var position = -1;
      var found = terms.every(function (term) {
        var titleAt = title.indexOf(term);
        var headingAt = heading.indexOf(term);
        var textAt = text.indexOf(term);
        if (titleAt < 0 && headingAt < 0 && textAt < 0) return false;
        if (titleAt >= 0) score += 8;
        if (headingAt >= 0) score += 5;
        if (textAt >= 0) {
          score += 1;
          if (position < 0) position = textAt;
        }
        return true;
      });
      if (found) results.push({ entry: entry, score: score, position: position });
    });
    results.sort(function (a, b) { return b.score - a.score; });
    return results.slice(0, 30);
  }

  function renderResults(container, results, query) {
    container.innerHTML = '';
    results.forEach(function (result) {
      var entry = result.entry;
      var start = Math.max(0, result.position - 55);
      var end = Math.min(entry.x.length, result.position + 150);
      var snippet = entry.x.slice(start, end);
      var item = document.createElement('a');
      item.className = 'search-result';
      item.href = root + entry.u + (entry.i ? '#' + entry.i : '');
      item.innerHTML = '<span class="search-result-meta">' +
        escapeHtml(entry.g + (entry.h ? ' · ' + entry.h : '')) +
        '</span><strong>' + escapeHtml(entry.t) + '</strong><span>' +
        escapeHtml((start ? '…' : '') + snippet + (end < entry.x.length ? '…' : '')) +
        '</span>';
      container.appendChild(item);
    });
    if (!results.length) {
      container.innerHTML = '<p class="search-empty">No matches found. Try a shorter or different term.</p>';
    }
  }

  function openSearch(initialValue) {
    if (!overlay || !searchInput) return;
    overlay.hidden = false;
    searchInput.value = initialValue || '';
    searchInput.dispatchEvent(new Event('input'));
    searchInput.focus();
  }

  function closeSearch() {
    if (overlay) overlay.hidden = true;
  }

  function updateSearch(input, container, query) {
    var results = search(query);
    container.hidden = !query.trim();
    if (query.trim()) renderResults(container, results, query);
    return results.length;
  }

  if (searchInput && searchResults) {
    searchInput.addEventListener('input', function () {
      updateSearch(searchInput, searchResults, searchInput.value);
    });
    var searchButton = document.getElementById('searchBtn');
    var searchClose = document.getElementById('searchClose');
    if (searchButton) searchButton.addEventListener('click', function () { openSearch(''); });
    if (searchClose) searchClose.addEventListener('click', closeSearch);
    overlay.addEventListener('click', function (event) {
      if (event.target === overlay) closeSearch();
    });
  }

  if (homeInput && homeHits && noResults) {
    homeInput.addEventListener('input', function () {
      var query = homeInput.value.trim();
      if (!query) {
        homeHits.hidden = true;
        noResults.hidden = true;
        return;
      }
      var count = updateSearch(homeInput, homeHits, query);
      noResults.hidden = count > 0;
    });
  }

  var findBar = document.getElementById('findBar');
  var findInput = document.getElementById('findInput');
  var findCount = document.getElementById('findCount');
  var marks = [];
  var currentMark = -1;

  function clearMarks() {
    marks.forEach(function (mark) {
      if (mark.parentNode) mark.parentNode.replaceChild(document.createTextNode(mark.textContent), mark);
    });
    marks = [];
    var content = document.querySelector('.content');
    if (content) content.normalize();
  }

  function findOnPage(query) {
    clearMarks();
    currentMark = -1;
    if (!query || !document.querySelector('.content')) {
      findCount.textContent = '';
      return;
    }
    var lowerQuery = query.toLowerCase();
    var walker = document.createTreeWalker(document.querySelector('.content'), NodeFilter.SHOW_TEXT, {
      acceptNode: function (node) {
        if (!node.nodeValue || !node.nodeValue.trim()) return NodeFilter.FILTER_REJECT;
        if (node.parentNode.closest('script,style,mark.find-match,input,textarea')) return NodeFilter.FILTER_REJECT;
        return NodeFilter.FILTER_ACCEPT;
      }
    });
    var nodes = [];
    while (walker.nextNode()) nodes.push(walker.currentNode);
    nodes.forEach(function (node) {
      var text = node.nodeValue;
      var lower = text.toLowerCase();
      var offset = 0;
      var at = lower.indexOf(lowerQuery);
      if (at < 0) return;
      var fragment = document.createDocumentFragment();
      while (at >= 0) {
        fragment.appendChild(document.createTextNode(text.slice(offset, at)));
        var mark = document.createElement('mark');
        mark.className = 'find-match';
        mark.textContent = text.slice(at, at + query.length);
        fragment.appendChild(mark);
        marks.push(mark);
        offset = at + query.length;
        at = lower.indexOf(lowerQuery, offset);
      }
      fragment.appendChild(document.createTextNode(text.slice(offset)));
      node.parentNode.replaceChild(fragment, node);
    });
    findCount.textContent = marks.length ? '0 / ' + marks.length : 'No matches';
    if (marks.length) selectMark(0);
  }

  function selectMark(index) {
    if (!marks.length) return;
    currentMark = (index + marks.length) % marks.length;
    marks.forEach(function (mark, i) { mark.classList.toggle('current', i === currentMark); });
    marks[currentMark].scrollIntoView({ block: 'center', behavior: 'smooth' });
    findCount.textContent = (currentMark + 1) + ' / ' + marks.length;
  }

  function openFind() {
    if (!findBar || !findInput) return;
    closeSearch();
    findBar.hidden = false;
    findInput.focus();
    findInput.select();
  }

  function closeFind() {
    if (!findBar) return;
    findBar.hidden = true;
    clearMarks();
    if (findCount) findCount.textContent = '';
  }

  if (findInput) {
    findInput.addEventListener('input', function () { findOnPage(findInput.value.trim()); });
    var findButton = document.getElementById('findBtn');
    var findNext = document.getElementById('findNext');
    var findPrev = document.getElementById('findPrev');
    var findClose = document.getElementById('findClose');
    if (findButton) findButton.addEventListener('click', openFind);
    if (findNext) findNext.addEventListener('click', function () { selectMark(currentMark + 1); });
    if (findPrev) findPrev.addEventListener('click', function () { selectMark(currentMark - 1); });
    if (findClose) findClose.addEventListener('click', closeFind);
  }

  document.addEventListener('keydown', function (event) {
    var target = event.target;
    var inField = target && /INPUT|TEXTAREA|SELECT/.test(target.tagName);
    if ((event.ctrlKey || event.metaKey) && event.key.toLowerCase() === 'k') {
      event.preventDefault();
      openSearch('');
    } else if ((event.ctrlKey || event.metaKey) && event.altKey && event.key.toLowerCase() === 'f') {
      event.preventDefault();
      openFind();
    } else if (event.key === 'Escape') {
      closeSearch();
      closeFind();
    } else if (event.key === '/' && !inField) {
      event.preventDefault();
      openSearch('');
    }
  });
})();
