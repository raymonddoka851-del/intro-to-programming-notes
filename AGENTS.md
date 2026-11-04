# Project: C revision notes site (STA 121 / CSC 112)

## Environment
- Windows, PowerShell 5.1 only. No Python, Node or Pandoc. Do not suggest installing them.
- GCC 16.2.0: `%LOCALAPPDATA%\mingw64\mingw64\bin\gcc.exe` (also g++, gdb).
- git and gh are not on PATH. Run first:
  `$env:PATH = "$env:LOCALAPPDATA\PortableGit\bin;" + $env:PATH`
- Plain `git push` works (gh credential helper is set).
- Transient GitHub errors ("GraphQL: Something went wrong", "fatal error in commit_refs") succeed on retry.

## Commands
- Build: `powershell -NoProfile -ExecutionPolicy Bypass -File ".\docs\_build.ps1"`
- Check: `powershell -NoProfile -ExecutionPolicy Bypass -File ".\docs\_check.ps1"` (exit 0 = clean, 1 = problems)
- Local server: `%TEMP%\opencode\_serve.ps1` -> http://127.0.0.1:8765/ (file:// is rejected by the browser tool)

## Gotchas
- PS 5.1 console misrenders UTF-8. Verify text with
  `[System.IO.File]::ReadAllText($p,[Text.Encoding]::UTF8)` or in the browser, never from console output.
- `_build.ps1` and `START_HERE.md` have a UTF-8 BOM. Do not strip it from `_build.ps1`.
- [System.IO.File] relative paths use the process CWD. Always use absolute paths.

## Rules
- Fix root causes in the build script, never page by page.
- Run build then check after every change. Do not report "done" until check exits 0.
- One commit per kind of fix. Never push until I say so.
- Never touch or commit anything outside this repo folder.
  The parent folder contains a private file (Backup-codes-*.txt) that must never be read, copied or committed.
- Never change my note content. Report blanks in the source instead of inventing text.
