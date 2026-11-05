# ============================================================================
#  _all.ps1 - one command: rebuild the site, audit it, and summarise.
#
#  Usage (from the Revision Pack folder):
#      powershell -ExecutionPolicy Bypass -File ".\docs\_all.ps1"
#      powershell -ExecutionPolicy Bypass -File ".\docs\_all.ps1" -Serve
#
#  -Serve starts the local static server in a new window (port 8765).
#  Exit code is the checker's: 0 = clean, 1 = problems.
# ============================================================================

[CmdletBinding()]
param(
    [switch]$Serve,
    [int]$Port = 8765
)

$ErrorActionPreference = 'Stop'
$DocsRoot = $PSScriptRoot
$PackRoot = Split-Path -Parent $DocsRoot

function Write-Step([string]$Text) {
    Write-Host ''
    Write-Host ("== " + $Text) -ForegroundColor Cyan
}

Write-Step 'Build'
& powershell -NoProfile -ExecutionPolicy Bypass -File (Join-Path $DocsRoot '_build.ps1')
$buildCode = $LASTEXITCODE
if ($buildCode -ne 0) {
    Write-Host ''
    Write-Host "BUILD FAILED (exit $buildCode). Site not checked." -ForegroundColor Red
    exit $buildCode
}

Write-Step 'Audit'
& powershell -NoProfile -ExecutionPolicy Bypass -File (Join-Path $DocsRoot '_check.ps1')
$checkCode = $LASTEXITCODE

if ($Serve) {
    Write-Step 'Local server'
    $server = Join-Path $DocsRoot '_serve.ps1'
    Start-Process powershell -ArgumentList @(
        '-NoProfile', '-ExecutionPolicy', 'Bypass',
        '-File', ('"{0}"' -f $server),
        '-Root', ('"{0}"' -f $DocsRoot),
        '-Port', $Port
    )
    Write-Host ("Started. Open http://127.0.0.1:{0}/index.html" -f $Port) -ForegroundColor Green
}

Write-Step 'Summary'
if ($checkCode -eq 0) {
    Write-Host 'Site is clean: build succeeded and every check passed.' -ForegroundColor Green
} else {
    Write-Host 'Site built, but the checker found problems (see above).' -ForegroundColor Red
}
exit $checkCode
