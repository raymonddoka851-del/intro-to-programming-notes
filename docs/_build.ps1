# ============================================================================
#  build.ps1 - turns the Markdown study notes into a styled HTML site.
#
#  Usage (from the Revision Pack folder):
#      powershell -ExecutionPolicy Bypass -File ".\docs\_build.ps1"
#
#  It reads  ../*.md, ../notes/*.md, ../practice/*.md, ../code/README.md
#  and writes ../docs/**/*.html + ../docs/index.html
# ============================================================================

$ErrorActionPreference = 'Stop'

$PackRoot = Split-Path -Parent $PSScriptRoot
$OutRoot  = $PSScriptRoot

# ---------------------------------------------------------------- helpers ---

function HtmlEscape([string]$s) {
    if ([string]::IsNullOrEmpty($s)) { return '' }
    $s = $s.Replace('&', '&amp;')
    $s = $s.Replace('<', '&lt;')
    $s = $s.Replace('>', '&gt;')
    $s = $s.Replace('"', '&quot;')
    return $s
}

function Slug([string]$s) {
    $s = $s.ToLowerInvariant()
    $s = [regex]::Replace($s, '[^a-z0-9\s\-]', '')
    $s = [regex]::Replace($s, '\s+', '-')
    $s = $s.Trim('-')
    if ($s.Length -gt 60) { $s = $s.Substring(0, 60).Trim('-') }
    if (-not $s) { $s = 'section' }
    return $s
}

# ------------------------------------------------------- links and blanks ---

$script:RepoUrl   = 'https://github.com/raymonddoka851-del/intro-to-programming-notes/blob/main/'
$script:DocMap    = @{}     # source path (lowercase) and leaf name -> output path
$script:CurrentOut = ''
$script:TaskNo    = 0
$script:BlankNo   = 0

# Relative link from the page being built to another generated page.
function Get-RelHref([string]$targetOut) {
    $cur = $script:CurrentOut
    if (-not $cur -or -not $targetOut) { return $targetOut }
    $curDir = ''
    if ($cur.Contains('/')) { $curDir = $cur.Substring(0, $cur.LastIndexOf('/')) }
    if (-not $curDir) { return $targetOut }
    $tgtLeaf = $targetOut
    $tgtDir  = ''
    if ($targetOut.Contains('/')) {
        $tgtDir  = $targetOut.Substring(0, $targetOut.LastIndexOf('/'))
        $tgtLeaf = $targetOut.Substring($targetOut.LastIndexOf('/') + 1)
    }
    if ($tgtDir -eq $curDir) { return $tgtLeaf }
    return '../' + $targetOut
}

# Turn a Markdown reference into a working href: .md -> generated .html,
# repository files -> GitHub blob, everything else left alone.
function MapRef([string]$href) {
    if ([string]::IsNullOrEmpty($href)) { return $href }
    if ($href -match '^(https?:|mailto:|tel:|javascript:|data:|#)') { return $href }

    $hash = ''
    $path = $href
    $h = $href.IndexOf('#')
    if ($h -ge 0) { $hash = $href.Substring($h); $path = $href.Substring(0, $h) }
    if ([string]::IsNullOrEmpty($path)) { return $href }

    $p = $path -replace '\\', '/'
    while ($p.StartsWith('./')) { $p = $p.Substring(2) }
    $p = [uri]::UnescapeDataString($p)

    $out = $null
    if ($script:DocMap.ContainsKey($p.ToLowerInvariant())) {
        $out = $script:DocMap[$p.ToLowerInvariant()]
    } else {
        $leaf = $p.Substring($p.LastIndexOf('/') + 1).ToLowerInvariant()
        if ($script:DocMap.ContainsKey($leaf)) { $out = $script:DocMap[$leaf] }
    }
    if ($out) { return (Get-RelHref $out) + $hash }

    $disk = Join-Path $PackRoot $p
    if (Test-Path -LiteralPath $disk -PathType Leaf) {
        return $script:RepoUrl + ($p -replace ' ', '%20')
    }
    return $href
}

function NewBlankHtml([string]$kind, [string]$label) {
    $script:BlankNo++
    $id  = 'b' + $script:BlankNo
    $tag = 'text'
    $extra = ''
    if ($kind -eq 'date')   { $tag = 'date' }
    if ($kind -eq 'number') { $tag = 'number'; $extra = ' min="0" max="70" inputmode="numeric"' }
    if ($kind -eq 'days')   { $tag = 'text';   $extra = ' readonly' }
    if (-not $label) { $label = 'Your answer' }
    return '<input class="blank" type="' + $tag + '" id="' + $id + '" data-blank="' + $id +
           '" data-kind="' + $kind + '" aria-label="' + (HtmlEscape $label) +
           '" placeholder="' + (HtmlEscape $label) + '"' + $extra + '>'
}

# Replace runs of underscores with real inputs (used outside tables).
function ReplaceBlanks([string]$text, [string]$kind, [string]$label) {
    return [regex]::Replace($text, '_{3,}', {
        param($m)
        NewBlankHtml $kind $label
    })
}

# Inline markdown -> HTML (code spans, bold, italic, links)
function Inline([string]$text) {
    if ([string]::IsNullOrEmpty($text)) { return '' }

    $esc = HtmlEscape $text

    # 1. protect `code spans` with control-character tokens
    $codes = New-Object 'System.Collections.Generic.List[string]'
    $sb = New-Object System.Text.StringBuilder
    $pos = 0
    foreach ($m in [regex]::Matches($esc, '`([^`]+)`')) {
        [void]$sb.Append($esc.Substring($pos, $m.Index - $pos))
        $codes.Add($m.Groups[1].Value)
        [void]$sb.Append([string][char]1 + ($codes.Count - 1) + [string][char]2)
        $pos = $m.Index + $m.Length
    }
    [void]$sb.Append($esc.Substring($pos))
    $t = $sb.ToString()

    # 2. bold, then italic, then links
    $t = [regex]::Replace($t, '\*\*([^*]+?)\*\*', '<strong>$1</strong>')
    $t = [regex]::Replace($t, '(?<![\w*])\*(?!\s)([^*\n]{1,160}?)(?<!\s)\*(?![\w*])', '<em>$1</em>')
    $t = [regex]::Replace($t, '\[([^\]]+)\]\(([^)\s]+)\)', {
        param($m)
        $label = $m.Groups[1].Value
        $raw   = [System.Net.WebUtility]::HtmlDecode($m.Groups[2].Value)
        $href  = MapRef $raw
        '<a href="' + (HtmlEscape $href) + '">' + $label + '</a>'
    })

    # 2b. underscores in running text become real inputs
    $t = ReplaceBlanks $t 'text' 'Your answer'

    # 3. restore code spans (file names inside `code` become links)
    for ($i = $codes.Count - 1; $i -ge 0; $i--) {
        $tok = [string][char]1 + $i + [string][char]2
        $disp = $codes[$i]
        $raw  = [System.Net.WebUtility]::HtmlDecode($disp)
        $link = $raw
        if ($raw -match '\.(md|bat|cmd|c|h|ps1|html|txt)$' -or $raw -match '^(code|notes|practice)/') {
            $link = MapRef $raw
        }
        if ($link -ne $raw) {
            $t = $t.Replace($tok, '<a class="file-ref" href="' + (HtmlEscape $link) + '"><code>' + $disp + '</code></a>')
        } else {
            $t = $t.Replace($tok, '<code>' + $disp + '</code>')
        }
    }

    # 4. bare URLs -> links (Markdown angle links <https://...> lose the brackets)
    $t = [regex]::Replace($t, '&lt;(https?://[^\s&]+)&gt;', '$1')
    $t = [regex]::Replace($t, "(?<![=<>\`"'])(https?://[^\s<>\`"']+)", {
        param($m)
        $u = $m.Value
        $tail = ''
        while ($u -match '^(.*?)([.,;:)]+)$') {
            $tail = $Matches[2] + $tail
            $u = $Matches[1]
        }
        '<a href="' + $u + '">' + $u + '</a>' + $tail
    })

    # 5. external links open in a new tab (including file links to GitHub)
    $t = [regex]::Replace($t, '(<a\b[^>]*?href="(https?://[^"]+)")(?![^>]*\btarget=)',
             '$1 target="_blank" rel="noopener noreferrer"')
    return $t
}

# ------------------------------------------------------- C syntax colours ---

$script:CKeywords = @(
    'auto','break','case','char','const','continue','default','do','double',
    'else','enum','extern','float','for','goto','if','inline','int','long',
    'register','restrict','return','short','signed','sizeof','static','struct',
    'switch','typedef','union','unsigned','void','volatile','while',
    'bool','true','false','NULL','size_t','FILE','EOF'
)

$script:CPattern = @'
(?<com>//[^\n]*|/\*[\s\S]*?\*/)|(?<str>"(?:[^"\\]|\\.)*")|(?<chr>'(?:[^'\\]|\\.)*')|(?<pre>^[ \t]*#[ \t]*[A-Za-z_]+[^\n]*)|(?<num>\b(?:0[xX][0-9a-fA-F]+|\d+(?:\.\d+)?(?:[eE][-+]?\d+)?)[fFlLuU]*\b)|(?<kw>\b(?:auto|break|case|char|const|continue|default|do|double|else|enum|extern|float|for|goto|if|inline|int|long|register|restrict|return|short|signed|sizeof|static|struct|switch|typedef|union|unsigned|void|volatile|while|bool|true|false|NULL|size_t|FILE|EOF)\b)|(?<fn>\b[A-Za-z_]\w*(?=\s*\())
'@

function HighlightC([string]$code) {
    $sb  = New-Object System.Text.StringBuilder
    $pos = 0
    $ms  = [regex]::Matches($code, $script:CPattern,
            [System.Text.RegularExpressions.RegexOptions]::Multiline)

    foreach ($m in $ms) {
        if ($m.Index -gt $pos) {
            [void]$sb.Append((HtmlEscape $code.Substring($pos, $m.Index - $pos)))
        }
        $cls = 'txt'
        if ($m.Groups['com'].Success)     { $cls = 'com' }
        elseif ($m.Groups['str'].Success) { $cls = 'str' }
        elseif ($m.Groups['chr'].Success) { $cls = 'chr' }
        elseif ($m.Groups['pre'].Success) { $cls = 'pre' }
        elseif ($m.Groups['num'].Success) { $cls = 'num' }
        elseif ($m.Groups['kw'].Success)  { $cls = 'kw'  }
        elseif ($m.Groups['fn'].Success)  { $cls = 'fn'  }

        if ($cls -eq 'txt') {
            [void]$sb.Append((HtmlEscape $m.Value))
        } else {
            [void]$sb.Append('<span class="tok-' + $cls + '">' + (HtmlEscape $m.Value) + '</span>')
        }
        $pos = $m.Index + $m.Length
    }
    if ($pos -lt $code.Length) {
        [void]$sb.Append((HtmlEscape $code.Substring($pos)))
    }
    return $sb.ToString()
}

function RenderCode([string]$code, [string]$lang) {
    $l = $lang.ToLowerInvariant()
    if ($l -eq 'c' -or $l -eq 'cpp' -or $l -eq 'c++') {
        $body = HighlightC $code
    } else {
        $body = HtmlEscape $code
    }
    $attr = ''
    if ($lang) { $attr = ' data-lang="' + (HtmlEscape $lang) + '"' }
    return '<pre class="code"' + $attr + '><code>' + $body + '</code></pre>' + "`n"
}

# ------------------------------------------------------------ table rows ---

function SplitRow([string]$row) {
    $s = $row.Trim()
    if ($s.StartsWith('|')) { $s = $s.Substring(1) }
    if ($s.EndsWith('|'))   { $s = $s.Substring(0, $s.Length - 1) }

    $cells  = New-Object 'System.Collections.Generic.List[string]'
    $cur    = New-Object System.Text.StringBuilder
    $inCode = $false

    for ($k = 0; $k -lt $s.Length; $k++) {
        $ch = $s[$k]
        if ($ch -eq '\' -and ($k + 1) -lt $s.Length -and $s[$k + 1] -eq '|') {
            [void]$cur.Append('|'); $k++; continue
        }
        if ($ch -eq '`') { $inCode = -not $inCode; [void]$cur.Append($ch); continue }
        if ($ch -eq '|' -and -not $inCode) {
            $cells.Add($cur.ToString()); [void]$cur.Clear(); continue
        }
        [void]$cur.Append($ch)
    }
    $cells.Add($cur.ToString())
    return ,$cells.ToArray()
}

function RenderCell([string]$v, [string]$head, [string]$rowLabel) {
    if ($v -notmatch '_{3,}') { return Inline $v }

    $h = (($head + ' ' + $rowLabel) -replace '\*\*|`', '').ToLowerInvariant()
    $kind  = 'text'
    $label = $head.Trim()
    if ($h -match 'exam date')                { $kind = 'date';   $label = 'Exam date' }
    elseif ($h -match 'days left')            { $kind = 'days';   $label = 'Days left' }
    elseif ($h -match 'target score|score')   { $kind = 'number'; $label = 'Target score' }
    elseif ($rowLabel.Trim())                 { $label = $rowLabel.Trim() }
    elseif (-not $label)                      { $label = 'Your answer' }

    $parts = [regex]::Split($v, '_{3,}')
    $sb = New-Object System.Text.StringBuilder
    for ($i = 0; $i -lt $parts.Count; $i++) {
        if ($i -gt 0) { [void]$sb.Append((NewBlankHtml $kind $label)) }
        [void]$sb.Append((Inline $parts[$i]))
    }
    return $sb.ToString()
}

function RenderTable([string]$headLine, [string]$sepLine, [string[]]$rowLines) {
    $heads = SplitRow $headLine
    $seps  = SplitRow $sepLine

    $align = @()
    for ($c = 0; $c -lt $heads.Count; $c++) {
        $sp = if ($c -lt $seps.Count) { $seps[$c].Trim() } else { '---' }
        if ($sp.StartsWith(':') -and $sp.EndsWith(':')) { $align += 'center' }
        elseif ($sp.EndsWith(':'))                      { $align += 'right' }
        else                                            { $align += 'left' }
    }

    $sb = New-Object System.Text.StringBuilder
    [void]$sb.Append('<div class="table-wrap"><table>' + "`n" + '<thead><tr>')
    for ($c = 0; $c -lt $heads.Count; $c++) {
        [void]$sb.Append('<th style="text-align:' + $align[$c] + '">' + (Inline $heads[$c].Trim()) + '</th>')
    }
    [void]$sb.Append('</tr></thead>' + "`n" + '<tbody>' + "`n")

    foreach ($rl in $rowLines) {
        $cells = SplitRow $rl
        $rowLabel = if ($cells.Count -gt 0) { $cells[0].Trim() } else { '' }
        [void]$sb.Append('<tr>')
        for ($c = 0; $c -lt $heads.Count; $c++) {
            $v = if ($c -lt $cells.Count) { $cells[$c].Trim() } else { '' }
            [void]$sb.Append('<td style="text-align:' + $align[$c] + '">' + (RenderCell $v $heads[$c] $rowLabel) + '</td>')
        }
        [void]$sb.Append('</tr>' + "`n")
    }
    [void]$sb.Append('</tbody></table></div>' + "`n")
    return $sb.ToString()
}

# ---------------------------------------------------------------- lists ----

function RenderList($items, [int]$start, [int]$end) {
    $ordered = $items[$start].Ordered
    $tag = if ($ordered) { 'ol' } else { 'ul' }
    $startAttr = ''
    if ($ordered -and $items[$start].Number -gt 1) {
        $startAttr = ' start="' + $items[$start].Number + '"'
    }
    $sb  = New-Object System.Text.StringBuilder
    [void]$sb.Append("<$tag$startAttr>`n")

    $k = $start
    while ($k -lt $end) {
        $it  = $items[$k]
        $txt = [string]$it.Text
        $cb  = ''
        $cbEnd = ''

        if ($txt -match '^\[( |x|X)\]\s+(.*)$') {
            $checked = $Matches[1] -ne ' '
            $txt     = $Matches[2]
            $script:TaskNo++
            $taskId  = 'task' + $script:TaskNo
            $chk     = if ($checked) { ' checked' } else { '' }
            $cb = '<label class="task"><input type="checkbox" class="task-check" id="' + $taskId +
                  '" data-task="' + $taskId + '"' + $chk + '> <span class="task-text">'
            $cbEnd = '</span></label> '
        } else {
            $cbEnd = ''
        }

        [void]$sb.Append('<li>' + $cb + (Inline $txt) + $cbEnd)

        $j = $k + 1
        while ($j -lt $end -and $items[$j].Indent -gt $it.Indent) { $j++ }

        if ($j -gt ($k + 1)) {
            [void]$sb.Append("`n" + (RenderList $items ($k + 1) $j))
        }
        foreach ($block in $it.Blocks) {
            [void]$sb.Append("`n" + $block)
        }
        [void]$sb.Append("</li>`n")
        $k = $j
    }
    [void]$sb.Append("</$tag>`n")
    return $sb.ToString()
}

# ------------------------------------------------------- markdown parser ---

function ConvertMarkdown([string]$md) {
    $lines = $md -split "\r?\n"
    $n     = $lines.Count
    $out   = New-Object System.Text.StringBuilder
    $toc   = New-Object 'System.Collections.Generic.List[object]'
    $usedIds = @{}
    $title = $null
    $i     = 0

    while ($i -lt $n) {
        $line = $lines[$i]

        # blank
        if ($line -match '^\s*$') { $i++; continue }

        # :::trace col1, col2, ... -> blank variable-trace table
        if ($line -match '^:::trace\s*(.*)$') {
            $cols = @($Matches[1] -split '\s*,\s*' | Where-Object { $_ })
            if ($cols.Count -eq 0) { $cols = @('Line / iteration','Variable 1','Variable 2','Output') }
            [void]$out.Append('<div class="trace-card"><div class="trace-title">Variable trace — fill this in</div>' +
                              '<div class="table-wrap"><table class="trace"><thead><tr>')
            foreach ($c in $cols) { [void]$out.Append('<th>' + (HtmlEscape $c.Trim()) + '</th>') }
            [void]$out.Append('</tr></thead><tbody>')
            for ($r = 0; $r -lt 6; $r++) {
                [void]$out.Append('<tr>')
                foreach ($c in $cols) { [void]$out.Append('<td><span class="trace-cell">&nbsp;</span></td>') }
                [void]$out.Append('</tr>')
            }
            [void]$out.Append('</tbody></table></div>' +
                              '<p class="trace-hint">Copy this table into your answer book: one row per iteration, update every variable, and write the output as it appears.</p></div>' + "`n")
            $i++
            continue
        }

        # :::mistakes ... ::: -> styled common-mistakes box
        if ($line -match '^:::mistakes\s*(.*)$') {
            $boxTitle = if ($Matches[1].Trim()) { $Matches[1].Trim() } else { 'Common mistakes' }
            $i++
            $inner = New-Object 'System.Collections.Generic.List[string]'
            while ($i -lt $n -and $lines[$i] -notmatch '^:::\s*$') {
                $inner.Add($lines[$i]); $i++
            }
            if ($i -lt $n) { $i++ }
            $boxHtml = (ConvertMarkdown ($inner -join "`n")).Html
            [void]$out.Append('<div class="mistakes"><div class="box-title">' +
                              (HtmlEscape $boxTitle) + '</div>' + $boxHtml + '</div>' + "`n")
            continue
        }

        # :::progress -> panel filled from localStorage by the page script
        if ($line -match '^:::progress\s*$') {
            [void]$out.Append('<div id="donePanel" class="done-panel"><p class="muted">Mark pages as done and they will appear here.</p></div>' + "`n")
            $i++
            continue
        }

        # Q> question / A> answer -> click-to-reveal practice
        if ($line -match '^Q>\s?(.*)$') {
            $q = $Matches[1]
            $i++
            $a = ''
            if ($i -lt $n -and $lines[$i] -match '^A>\s?(.*)$') { $a = $Matches[1]; $i++ }
            [void]$out.Append('<div class="predict"><div class="predict-q"><span class="tag">Predict</span> ' +
                              (Inline $q) + '</div><details class="reveal"><summary>Show answer</summary>' +
                              '<div class="reveal-body">' + (Inline $a) + '</div></details></div>' + "`n")
            continue
        }

        # fenced code
        if ($line -match '^\s*```(.*)$') {
            $lang = $Matches[1].Trim()
            $i++
            $buf = New-Object 'System.Collections.Generic.List[string]'
            while ($i -lt $n -and $lines[$i] -notmatch '^\s*```\s*$') {
                $buf.Add($lines[$i]); $i++
            }
            if ($i -lt $n) { $i++ }
            [void]$out.Append((RenderCode ($buf -join "`n") $lang))
            continue
        }

        # heading
        if ($line -match '^(#{1,6})\s+(.*?)\s*#*\s*$') {
            $lvl  = $Matches[1].Length
            $txt  = $Matches[2]
            $plain = [regex]::Replace($txt, '`([^`]*)`', '$1')
            $plain = $plain.Replace('**', '').Replace('*', '')
            $id    = Slug $plain
            if ($usedIds.ContainsKey($id)) {
                $usedIds[$id]++
                $id = $id + '-' + $usedIds[$id]
            } else {
                $usedIds[$id] = 1
            }
            if ($lvl -eq 1 -and -not $title) { $title = $plain }
            if ($lvl -eq 2 -or $lvl -eq 3) {
                $toc.Add([pscustomobject]@{ Level = $lvl; Text = $plain; Id = $id })
            }
            [void]$out.Append("<h$lvl id=`"$id`">" + (Inline $txt) + "</h$lvl>`n")
            $i++
            continue
        }

        # horizontal rule
        if ($line -match '^\s{0,3}(-{3,}|\*{3,}|_{3,})\s*$') {
            [void]$out.Append("<hr>`n"); $i++; continue
        }

        # table
        if ($line -match '^\s*\|' -and ($i + 1) -lt $n -and
            $lines[$i + 1] -match '^\s*\|?[\s:\-\|]+\|?\s*$' -and
            $lines[$i + 1] -match '-') {
            $head = $line
            $sep  = $lines[$i + 1]
            $i += 2
            $rows = New-Object 'System.Collections.Generic.List[string]'
            while ($i -lt $n -and $lines[$i] -match '^\s*\|') {
                $rows.Add($lines[$i]); $i++
            }
            [void]$out.Append((RenderTable $head $sep $rows.ToArray()))
            continue
        }

        # blockquote
        if ($line -match '^\s*>') {
            $buf = New-Object 'System.Collections.Generic.List[string]'
            while ($i -lt $n -and $lines[$i] -match '^\s*>') {
                $buf.Add(($lines[$i] -replace '^\s*>\s?', ''))
                $i++
            }
            $inner = $buf -join "`n"
            $paras = $inner -split "\n\s*\n"
            $html  = ''
            foreach ($p in $paras) {
                $clean = ($p -replace "`n", ' ').Trim()
                if ($clean) { $html += '<p>' + (Inline $clean) + '</p>' }
            }
            [void]$out.Append('<blockquote>' + $html + '</blockquote>' + "`n")
            continue
        }

        # list
        if ($line -match '^(\s*)([-*+]|\d{1,3}[.)])\s+(.*)$') {
            $items = New-Object 'System.Collections.Generic.List[object]'
            while ($i -lt $n) {
                $l = $lines[$i]

                # blank line: only continue the list if the next block belongs to it
                if ($l -match '^\s*$') {
                    $j = $i
                    while ($j -lt $n -and $lines[$j] -match '^\s*$') { $j++ }
                    if ($j -ge $n) { $i = $j; break }

                    $nxt     = $lines[$j]
                    $nIndent = ([regex]::Match($nxt, '^(\s*)')).Groups[1].Length
                    $curInd  = if ($items.Count -gt 0) { $items[$items.Count - 1].Indent } else { 0 }

                    if ($nxt -match '^\s*```') {
                        if ($items.Count -gt 0 -and $nIndent -ge $curInd) { $i = $j; continue }
                        break
                    }
                    if ($nxt -match '^(\s*)([-*+]|\d{1,3}[.)])\s+') {
                        if ($nIndent -ge $curInd) { $i = $j; continue }
                        break
                    }
                    # an indented paragraph or table is a continuation of the item above
                    if ($nIndent -ge 2 -and $items.Count -gt 0) { $i = $j; continue }
                    break
                }

                # fenced code that belongs to the item above
                if ($l -match '^(\s*)```(.*)$') {
                    $fenceIndent = $Matches[1].Length
                    $lang        = $Matches[2].Trim()
                    $i++
                    $buf = New-Object 'System.Collections.Generic.List[string]'
                    while ($i -lt $n -and $lines[$i] -notmatch '^\s*```\s*$') {
                        $body = $lines[$i]
                        if ($body.Length -ge $fenceIndent) { $body = $body.Substring($fenceIndent) }
                        $buf.Add($body)
                        $i++
                    }
                    if ($i -lt $n) { $i++ }
                    if ($items.Count -gt 0) {
                        $items[$items.Count - 1].Blocks.Add((RenderCode ($buf -join "`n") $lang))
                    }
                    continue
                }

                # table that belongs to the item above
                if ($l -match '^\s*\|' -and ($i + 1) -lt $n -and
                    $lines[$i + 1] -match '^\s*\|?[\s:\-\|]+\|?\s*$' -and
                    $lines[$i + 1] -match '-') {
                    $head = $l.Trim()
                    $sep  = $lines[$i + 1].Trim()
                    $i += 2
                    $rows = New-Object 'System.Collections.Generic.List[string]'
                    while ($i -lt $n -and $lines[$i] -match '^\s*\|') {
                        $rows.Add($lines[$i].Trim()); $i++
                    }
                    if ($items.Count -gt 0) {
                        $items[$items.Count - 1].Blocks.Add((RenderTable $head $sep $rows.ToArray()))
                    }
                    continue
                }

                if ($l -match '^(\s*)([-*+]|\d{1,3}[.)])\s+(.*)$') {
                    $mIndent  = $Matches[1].Length
                    $mMarker  = $Matches[2]
                    $mText    = $Matches[3]
                    $mOrdered = $mMarker -match '^\d'
                    $mNumber  = 0
                    if ($mOrdered) {
                        $mNumber = [int]([regex]::Match($mMarker, '\d+').Value)
                    }
                    $items.Add([pscustomobject]@{
                        Indent  = $mIndent
                        Ordered = $mOrdered
                        Number  = $mNumber
                        Text    = $mText
                        Blocks  = (New-Object 'System.Collections.Generic.List[string]')
                    })
                    $i++
                    continue
                }

                if ($l -match '^(\s+)(\S.*)$' -and $items.Count -gt 0) {
                    $items[$items.Count - 1].Text += ' ' + $Matches[2].Trim()
                    $i++
                    continue
                }
                break
            }
            [void]$out.Append((RenderList $items 0 $items.Count))
            continue
        }

        # paragraph
        $buf = New-Object 'System.Collections.Generic.List[string]'
        while ($i -lt $n) {
            $l = $lines[$i]
            if ($l -match '^\s*$') { break }
            if ($l -match '^\s*(```|#{1,6}\s|>|\|[-*+]\s|[-*+]\s|\d{1,3}[.)]\s)') { break }
            if ($l -match '^\s*\|') { break }
            if ($l -match '^(:::|\s*[QA]>)') { break }
            $buf.Add($l.Trim())
            $i++
        }
        if ($buf.Count -gt 0) {
            [void]$out.Append('<p>' + (Inline ($buf -join ' ')) + '</p>' + "`n")
        } else {
            $i++
        }
    }

    return [pscustomobject]@{
        Html   = $out.ToString()
        Toc    = $toc
        Title  = $title
        Words  = ([regex]::Matches($md, '\S+')).Count
        Tasks  = $script:TaskNo
        Blanks = $script:BlankNo
    }
}

# ------------------------------------------------------------- page shell ---

function BuildNav([string]$root, [string]$activeOut) {
    $sb = New-Object System.Text.StringBuilder
    $groups = $script:Docs | Group-Object Group

    foreach ($g in $groups) {
        [void]$sb.Append('<div class="nav-group">')
        [void]$sb.Append('<div class="nav-head">' + (HtmlEscape $g.Name) + '</div>')
        foreach ($d in $g.Group) {
            $cls = ''
            if ($d.Out -eq $activeOut) { $cls = ' class="active"' }
            [void]$sb.Append('<a href="' + $root + $d.Out + '"' + $cls + '>' + (HtmlEscape $d.Label) + '</a>')
        }
        [void]$sb.Append('</div>')
    }
    return $sb.ToString()
}

function BuildToc($toc) {
    if (-not $toc -or $toc.Count -eq 0) { return '' }
    $sb = New-Object System.Text.StringBuilder
    foreach ($t in $toc) {
        $cls = if ($t.Level -eq 3) { ' class="toc-h3"' } else { '' }
        [void]$sb.Append('<a href="#' + $t.Id + '"' + $cls + '>' + (HtmlEscape $t.Text) + '</a>')
    }
    return $sb.ToString()
}

function BuildPager([int]$index, [string]$root) {
    $sb = New-Object System.Text.StringBuilder
    [void]$sb.Append('<nav class="pager">')

    if ($index -gt 0) {
        $p = $script:Docs[$index - 1]
        [void]$sb.Append('<a class="prev" href="' + $root + $p.Out + '"><span class="dir">&larr; Previous</span><span class="name">' +
                         (HtmlEscape $p.Label) + '</span></a>')
    } else {
        [void]$sb.Append('<span class="spacer"></span>')
    }

    if ($index -lt ($script:Docs.Count - 1)) {
        $nx = $script:Docs[$index + 1]
        [void]$sb.Append('<a class="next" href="' + $root + $nx.Out + '"><span class="dir">Next &rarr;</span><span class="name">' +
                         (HtmlEscape $nx.Label) + '</span></a>')
    } else {
        [void]$sb.Append('<span class="spacer"></span>')
    }

    [void]$sb.Append('</nav>')
    return $sb.ToString()
}

$script:PageTemplate = @'
<!DOCTYPE html>
<html lang="en" data-theme="light">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>__TITLE__ · CSC 112 Revision</title>
<meta name="description" content="CSC 112 / STA 121 Introduction to Programming revision notes.">
<link rel="stylesheet" href="__ROOT__assets/notes.css">
</head>
<body data-page="__PAGEID__" data-pages="__PAGELIST__">
<div class="progress" id="progress"></div>
<div class="layout">
<aside class="sidebar">
  <a class="brand" href="__ROOT__index.html">
    <span class="brand-mark">C</span>
    <span class="brand-text"><strong>CSC 112</strong><span>Revision Notes</span></span>
  </a>
  <details class="nav-details" open>
    <summary>Contents</summary>
    __NAV__
  </details>
</aside>
<main class="main">
  <div class="topbar">
    <span class="crumb">__CRUMB__</span>
    <button class="theme-btn" id="themeBtn" title="Switch light / dark" aria-label="Switch theme">&#9789;</button>
  </div>
  <article class="content">
__TOOLS__
__BODY__
  </article>
__PAGER__
  <footer class="foot">
    CSC 112 / STA 121 — Introduction to Programming. Built from the official course outline and lecture notes.
  </footer>
</main>
<aside class="toc">
  <div class="toc-title">On this page</div>
  __TOC__
</aside>
</div>
<script>
(function () {
  var root = document.documentElement;
  try {
    var saved = localStorage.getItem('csc112-theme');
    if (saved) root.setAttribute('data-theme', saved);
  } catch (e) {}

  var btn = document.getElementById('themeBtn');
  if (btn) btn.addEventListener('click', function () {
    var next = root.getAttribute('data-theme') === 'dark' ? 'light' : 'dark';
    root.setAttribute('data-theme', next);
    btn.textContent = next === 'dark' ? '\u2600' : '\u263D';
    try { localStorage.setItem('csc112-theme', next); } catch (e) {}
  });

  var bar = document.getElementById('progress');
  if (bar) window.addEventListener('scroll', function () {
    var h = document.documentElement;
    var max = h.scrollHeight - h.clientHeight;
    bar.style.width = (max > 0 ? (h.scrollTop / max) * 100 : 0) + '%';
  }, { passive: true });

  // highlight the current section in the right-hand table of contents
  var links = [].slice.call(document.querySelectorAll('.toc a'));
  if (links.length) {
    var heads = links.map(function (a) { return document.getElementById(a.getAttribute('href').slice(1)); });
    window.addEventListener('scroll', function () {
      var best = -1;
      for (var i = 0; i < heads.length; i++) {
        if (heads[i] && heads[i].getBoundingClientRect().top < 120) best = i;
      }
      links.forEach(function (a, i) { a.classList.toggle('active', i === best); });
    }, { passive: true });
  }

  // on phones, start with the contents menu collapsed
  var det = document.querySelector('.nav-details');
  if (det && window.innerWidth < 1000) det.removeAttribute('open');

  // ---- interactive checklist -------------------------------------------
  var pageId  = document.body.getAttribute('data-page') || location.pathname;
  var checks  = [].slice.call(document.querySelectorAll('.task-check'));
  var countEl = document.getElementById('checkCount');
  var resetBtn = document.getElementById('resetChecks');

  function checkKey(el) { return 'csc112:task:' + pageId + ':' + el.getAttribute('data-task'); }
  function updateCount() {
    if (!countEl) return;
    var done = checks.filter(function (c) { return c.checked; }).length;
    countEl.textContent = done + ' / ' + checks.length + ' done';
    countEl.classList.toggle('all', checks.length > 0 && done === checks.length);
  }
  checks.forEach(function (c) {
    try { if (localStorage.getItem(checkKey(c)) === '1') c.checked = true; } catch (e) {}
    c.addEventListener('change', function () {
      try { localStorage.setItem(checkKey(c), c.checked ? '1' : '0'); } catch (e) {}
      updateCount();
    });
  });
  updateCount();
  if (resetBtn) resetBtn.addEventListener('click', function () {
    checks.forEach(function (c) {
      c.checked = false;
      try { localStorage.removeItem(checkKey(c)); } catch (e) {}
    });
    updateCount();
  });

  // ---- fill-in blanks ---------------------------------------------------
  var blanks = [].slice.call(document.querySelectorAll('input.blank'));
  blanks.forEach(function (b) {
    var k = 'csc112:blank:' + pageId + ':' + b.getAttribute('data-blank');
    try {
      var v = localStorage.getItem(k);
      if (v !== null) b.value = v;
    } catch (e) {}
    b.addEventListener('input', function () {
      try { localStorage.setItem(k, b.value); } catch (e) {}
      if (b.getAttribute('data-kind') === 'date') updateDays();
    });
  });

  function updateDays() {
    var date = document.querySelector('input.blank[data-kind="date"]');
    var days = document.querySelector('input.blank[data-kind="days"]');
    if (!date || !days) return;
    if (!date.value) { days.value = ''; return; }
    var d = new Date(date.value + 'T00:00:00');
    if (isNaN(d.getTime())) { days.value = ''; return; }
    var today = new Date();
    today.setHours(0, 0, 0, 0);
    days.value = String(Math.round((d - today) / 86400000));
  }
  updateDays();

  // ---- mark as done + progress panel -----------------------------------
  var doneBtn = document.getElementById('markDone');
  var doneKey = 'csc112:done:' + pageId;
  function isDone() { try { return localStorage.getItem(doneKey) === '1'; } catch (e) { return false; } }
  function paintDone() {
    if (!doneBtn) return;
    doneBtn.textContent = isDone() ? '\u2713 Done' : 'Mark as done';
    doneBtn.classList.toggle('is-done', isDone());
  }
  if (doneBtn) doneBtn.addEventListener('click', function () {
    try { localStorage.setItem(doneKey, isDone() ? '0' : '1'); } catch (e) {}
    paintDone();
    renderPanel();
  });
  paintDone();

  var panel = document.getElementById('donePanel');
  var pages = [];
  try { pages = JSON.parse(document.body.getAttribute('data-pages') || '[]'); } catch (e) {}
  function renderPanel() {
    if (!panel || !pages.length) return;
    panel.innerHTML = '';
    var n = 0;
    pages.forEach(function (p) {
      try { if (localStorage.getItem('csc112:done:' + p.key) === '1') n++; } catch (e) {}
    });
    var head = document.createElement('p');
    head.className = 'done-summary';
    head.textContent = n + ' / ' + pages.length + ' pages marked done';
    panel.appendChild(head);

    var list = document.createElement('ul');
    list.className = 'done-list';
    pages.forEach(function (p) {
      var li = document.createElement('li');
      var a = document.createElement('a');
      a.href = p.href;
      a.textContent = p.label;
      var s = document.createElement('span');
      var d = false;
      try { d = localStorage.getItem('csc112:done:' + p.key) === '1'; } catch (e) {}
      s.className = 'done-flag' + (d ? ' yes' : '');
      s.textContent = d ? '\u2713 done' : 'not done';
      li.appendChild(a);
      li.appendChild(s);
      list.appendChild(li);
    });
    panel.appendChild(list);
  }
  renderPanel();

  // print shows the answers so the PDF is a complete revision sheet
  window.addEventListener('beforeprint', function () {
    [].slice.call(document.querySelectorAll('details.reveal')).forEach(function (d) {
      d.setAttribute('data-was-open', d.open ? '1' : '0');
      d.open = true;
    });
  });
  window.addEventListener('afterprint', function () {
    [].slice.call(document.querySelectorAll('details.reveal')).forEach(function (d) {
      if (d.getAttribute('data-was-open') === '0') d.open = false;
    });
  });
})();
</script>
</body>
</html>
'@

# ------------------------------------------------------------------ docs ----

$script:Docs = @(
    # --- start here ---------------------------------------------------------
    @{ Md = 'START_HERE.md';                          Group = 'Start here'; Label = 'Start here (pack index)';      Out = 'START_HERE.html' }
    @{ Md = 'YOUR_14_DAY_PLAN.md';                    Group = 'Start here'; Label = 'Your 14-day study plan';       Out = 'YOUR_14_DAY_PLAN.html' }
    @{ Md = 'CHEAT_SHEET.md';                         Group = 'Start here'; Label = 'Cheat sheet';                  Out = 'CHEAT_SHEET.html' }
    @{ Md = 'PROGRESS_TRACKER.md';                    Group = 'Start here'; Label = 'Progress tracker';             Out = 'PROGRESS_TRACKER.html' }
    @{ Md = 'SETUP_AND_RUN.md';                       Group = 'Start here'; Label = 'Setup: run C on this PC';      Out = 'SETUP_AND_RUN.html' }
    # --- notes --------------------------------------------------------------
    @{ Md = 'notes\01_programming_fundamentals.md';   Group = 'Notes'; Label = '01 · Programming fundamentals'; Out = 'notes/01_programming_fundamentals.html' }
    @{ Md = 'notes\02_c_basics_and_compilation.md';   Group = 'Notes'; Label = '02 · C basics & compilation'; Out = 'notes/02_c_basics_and_compilation.html' }
    @{ Md = 'notes\03_data_types_and_number_systems.md'; Group = 'Notes'; Label = '03 · Data types & number systems'; Out = 'notes/03_data_types_and_number_systems.html' }
    @{ Md = 'notes\04_operators_and_expressions.md';  Group = 'Notes'; Label = '04 · Operators & expressions'; Out = 'notes/04_operators_and_expressions.html' }
    @{ Md = 'notes\05_control_statements.md';         Group = 'Notes'; Label = '05 · Control statements';      Out = 'notes/05_control_statements.html' }
    @{ Md = 'notes\06_loops.md';                      Group = 'Notes'; Label = '06 · Loops';                    Out = 'notes/06_loops.html' }
    @{ Md = 'notes\07_functions_and_recursion.md';    Group = 'Notes'; Label = '07 · Functions & recursion'; Out = 'notes/07_functions_and_recursion.html' }
    @{ Md = 'notes\08_arrays_and_strings.md';         Group = 'Notes'; Label = '08 · Arrays & strings';     Out = 'notes/08_arrays_and_strings.html' }
    @{ Md = 'notes\09_pointers.md';                   Group = 'Notes'; Label = '09 · Pointers';                 Out = 'notes/09_pointers.html' }
    @{ Md = 'notes\10_structures_unions_files.md';    Group = 'Notes'; Label = '10 · Structures, unions & files'; Out = 'notes/10_structures_unions_files.html' }
    @{ Md = 'notes\11_formatted_io_and_reports.md';   Group = 'Notes'; Label = '11 · Formatted I/O & reports'; Out = 'notes/11_formatted_io_and_reports.html' }
    # --- practice -----------------------------------------------------------
    @{ Md = 'practice\ACTUAL_QUIZ_ANSWERS.md';        Group = 'Practice'; Label = 'Actual quiz answers (24)';   Out = 'practice/ACTUAL_QUIZ_ANSWERS.html' }
    @{ Md = 'practice\QUESTION_BANK.md';              Group = 'Practice'; Label = 'Question bank (96)';         Out = 'practice/QUESTION_BANK.html' }
    @{ Md = 'practice\ANSWER_KEY.md';                 Group = 'Practice'; Label = 'Answer key';                  Out = 'practice/ANSWER_KEY.html' }
    @{ Md = 'practice\LAB_TASKS.md';                  Group = 'Practice'; Label = 'Lab tasks (25)';              Out = 'practice/LAB_TASKS.html' }
    @{ Md = 'practice\MOCK_EXAM_1.md';                Group = 'Practice'; Label = 'Mock exam 1';                  Out = 'practice/MOCK_EXAM_1.html' }
    @{ Md = 'practice\MOCK_EXAM_1_MARKING_SCHEME.md'; Group = 'Practice'; Label = 'Mock exam 1 — marking';  Out = 'practice/MOCK_EXAM_1_MARKING_SCHEME.html' }
    @{ Md = 'practice\MOCK_EXAM_2.md';                Group = 'Practice'; Label = 'Mock exam 2';                  Out = 'practice/MOCK_EXAM_2.html' }
    @{ Md = 'practice\MOCK_EXAM_2_MARKING_SCHEME.md'; Group = 'Practice'; Label = 'Mock exam 2 — marking';  Out = 'practice/MOCK_EXAM_2_MARKING_SCHEME.html' }
    # --- code ---------------------------------------------------------------
    @{ Md = 'code\README.md';                         Group = 'Code'; Label = 'Program list (22 examples)';      Out = 'code/README.html' }
)

# ------------------------------------------------------------------ build ---

$sw = [System.Diagnostics.Stopwatch]::StartNew()
$built = 0
$indexCards = New-Object 'System.Collections.Generic.List[object]'

# Link map: source Markdown path -> generated page.
foreach ($d in $script:Docs) {
    $srcRel = $d.Md -replace '\\', '/'
    $script:DocMap[$srcRel.ToLowerInvariant()] = $d.Out
    $leaf = $srcRel.Substring($srcRel.LastIndexOf('/') + 1).ToLowerInvariant()
    if (-not $script:DocMap.ContainsKey($leaf)) { $script:DocMap[$leaf] = $d.Out }
}

for ($d = 0; $d -lt $script:Docs.Count; $d++) {
    $doc = $script:Docs[$d]
    $src = Join-Path $PackRoot $doc.Md
    if (-not (Test-Path $src)) { Write-Warning "missing: $src"; continue }

    $script:CurrentOut = $doc.Out
    $script:TaskNo     = 0
    $script:BlankNo    = 0

    $md = Get-Content -LiteralPath $src -Raw -Encoding UTF8
    $res = ConvertMarkdown $md

    $depth = $doc.Out.Split('/').Count - 1
    $root  = if ($depth -gt 0) { '../' } else { '' }

    $title = if ($res.Title) { $res.Title } else { $doc.Label }

    $tools = '<div class="page-tools">'
    if ($res.Tasks -gt 0) {
        $tools += '<span class="check-count" id="checkCount">0 / ' + $res.Tasks + ' done</span>'
        $tools += '<button type="button" class="reset-btn" id="resetChecks">Reset checklist</button>'
    }
    $tools += '<button type="button" class="done-btn" id="markDone">Mark as done</button>'
    $tools += '</div>'

    $pageList = @()
    foreach ($pd in $script:Docs) {
        if ($pd.Group -ne 'Notes') { continue }
        $pageList += [pscustomobject]@{
            label = $pd.Label
            href  = (Get-RelHref $pd.Out)
            key   = $pd.Out
        }
    }
    $pageJson = ConvertTo-Json -InputObject @($pageList) -Compress

    $html = $script:PageTemplate
    $html = $html.Replace('__TITLE__', (HtmlEscape $title))
    $html = $html.Replace('__ROOT__',  $root)
    $html = $html.Replace('__PAGEID__', (HtmlEscape $doc.Out))
    $html = $html.Replace('__PAGELIST__', (HtmlEscape $pageJson))
    $html = $html.Replace('__NAV__',   (BuildNav $root $doc.Out))
    $html = $html.Replace('__CRUMB__', (HtmlEscape $doc.Group) + ' <b>&rsaquo;</b> ' + (HtmlEscape ((Split-Path -Leaf $src) -replace '\.md$', '')))
    $html = $html.Replace('__TOOLS__', $tools)
    $html = $html.Replace('__BODY__',  $res.Html)
    $html = $html.Replace('__PAGER__', (BuildPager $d $root))
    $html = $html.Replace('__TOC__',   (BuildToc $res.Toc))

    $dest = Join-Path $OutRoot ($doc.Out -replace '/', '\')
    $destDir = Split-Path -Parent $dest
    if (-not (Test-Path $destDir)) { New-Item -ItemType Directory -Force -Path $destDir | Out-Null }

    [System.IO.File]::WriteAllText($dest, $html, (New-Object System.Text.UTF8Encoding($false)))
    $built++

    $indexCards.Add([pscustomobject]@{
        Group = $doc.Group
        Label = $doc.Label
        Out   = $doc.Out
        Title = $title
        Words = $res.Words
    })

    Write-Host ("  {0,-52} {1,6} words" -f $doc.Out, $res.Words)
}

# ----------------------------------------------------------------- index ----

$totalWords = ($indexCards | Measure-Object Words -Sum).Sum
$cardHtml = New-Object System.Text.StringBuilder

foreach ($g in ($indexCards | Group-Object Group)) {
    [void]$cardHtml.Append('<div class="group-title">' + (HtmlEscape $g.Name) + '</div><div class="cards">')
    foreach ($c in $g.Group) {
        $mins = [math]::Max(1, [math]::Round($c.Words / 200))
        [void]$cardHtml.Append(
            '<a class="card" href="' + $c.Out + '" data-search="' +
            (HtmlEscape ($c.Title + ' ' + $g.Name).ToLowerInvariant()) + '">' +
            '<span class="num">' + (HtmlEscape $g.Name).ToUpperInvariant() + '</span>' +
            '<span class="title">' + (HtmlEscape $c.Label) + '</span>' +
            '<span class="meta">' + $mins + ' min read</span></a>')
    }
    [void]$cardHtml.Append('</div>')
}

$indexTemplate = @'
<!DOCTYPE html>
<html lang="en" data-theme="light">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>CSC 112 / STA 121 · Revision Notes</title>
<meta name="description" content="Complete CSC 112 / STA 121 Introduction to Programming revision pack: notes, examples, question bank, mock exams.">
<link rel="stylesheet" href="assets/notes.css">
</head>
<body>
<div class="progress" id="progress"></div>
<header class="hero">
  <span class="kicker">CSC 112 · STA 121</span>
  <h1>Introduction to Programming</h1>
  <p class="lede">Revision notes, 22 runnable C programs, 96 practice questions and two mock exams — everything in one place, from zero to exam-ready.</p>
  <div class="search">
    <svg viewBox="0 0 24 24" aria-hidden="true"><circle cx="11" cy="11" r="7"></circle><path d="M20 20l-3.5-3.5"></line></svg>
    <input id="q" type="search" placeholder="Search the notes&hellip;" autocomplete="off" aria-label="Search">
  </div>
</header>
<main class="groups" id="groups">
__CARDS__
<div class="no-results" id="noResults">Nothing matches that search.</div>
<div class="group-title">Print</div>
<p style="color:var(--muted);font-size:13.5px;margin:0">
  Any page can be saved as a PDF: open it and press <strong>Ctrl+P</strong> &rarr; <em>Destination: Save as PDF</em>.
</p>
</main>
<footer class="foot" style="padding-top:10px">
  __COUNT__ pages · __WORDS__ words · built from the official course outline and lecture notes.
</footer>
<script>
(function () {
  var root = document.documentElement;
  try {
    var saved = localStorage.getItem('csc112-theme');
    if (saved) root.setAttribute('data-theme', saved);
  } catch (e) {}

  var q = document.getElementById('q');
  var cards = [].slice.call(document.querySelectorAll('.card'));
  var noRes = document.getElementById('noResults');

  if (q) q.addEventListener('input', function () {
    var v = q.value.trim().toLowerCase();
    var shown = 0;
    cards.forEach(function (c) {
      var hit = !v || c.getAttribute('data-search').indexOf(v) !== -1;
      c.style.display = hit ? '' : 'none';
      if (hit) shown++;
    });
    document.querySelectorAll('.group-title').forEach(function (t) {
      var next = t.nextElementSibling;
      if (!next || !next.classList.contains('cards')) return;
      var any = [].slice.call(next.children).some(function (c) { return c.style.display !== 'none'; });
      t.style.display = any ? '' : 'none';
      next.style.display = any ? '' : 'none';
    });
    noRes.style.display = shown ? 'none' : 'block';
  });

  var bar = document.getElementById('progress');
  if (bar) window.addEventListener('scroll', function () {
    var h = document.documentElement;
    var max = h.scrollHeight - h.clientHeight;
    bar.style.width = (max > 0 ? (h.scrollTop / max) * 100 : 0) + '%';
  }, { passive: true });
})();
</script>
</body>
</html>
'@

$index = $indexTemplate.Replace('__CARDS__', $cardHtml.ToString())
$index = $index.Replace('__COUNT__', [string]$built)
$index = $index.Replace('__WORDS__', ('{0:N0}' -f $totalWords))

[System.IO.File]::WriteAllText((Join-Path $OutRoot 'index.html'), $index,
    (New-Object System.Text.UTF8Encoding($false)))

$sw.Stop()
Write-Host ''
Write-Host ("Done: {0} pages + index in {1:N1}s" -f $built, $sw.Elapsed.TotalSeconds) -ForegroundColor Green
Write-Host ("Open: {0}" -f (Join-Path $OutRoot 'index.html'))
