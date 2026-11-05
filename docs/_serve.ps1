# ============================================================================
#  _serve.ps1 - tiny local static server for the generated site.
#
#  Usage (from the Revision Pack folder):
#      powershell -ExecutionPolicy Bypass -File ".\docs\_serve.ps1"
#      powershell -ExecutionPolicy Bypass -File ".\docs\_serve.ps1" -Port 8080
#
#  Then open http://127.0.0.1:8765/ (the docs folder is the web root).
#  Ctrl+C stops the server.
# ============================================================================

[CmdletBinding()]
param(
    [int]$Port = 8765,
    [string]$Root
)

$ErrorActionPreference = 'Stop'

if (-not $Root) { $Root = $PSScriptRoot }
$Root = [System.IO.Path]::GetFullPath($Root)

$listener = New-Object System.Net.HttpListener
$listener.Prefixes.Add("http://127.0.0.1:$Port/")
$listener.Start()

Write-Host ("Serving {0}" -f $Root) -ForegroundColor Cyan
Write-Host ("Open http://127.0.0.1:{0}/" -f $Port) -ForegroundColor Green
Write-Host 'Press Ctrl+C to stop.'

$mime = @{
    '.html' = 'text/html; charset=utf-8'
    '.css'  = 'text/css; charset=utf-8'
    '.js'   = 'application/javascript; charset=utf-8'
    '.json' = 'application/json; charset=utf-8'
    '.svg'  = 'image/svg+xml'
    '.png'  = 'image/png'
    '.jpg'  = 'image/jpeg'
    '.ico'  = 'image/x-icon'
    '.md'   = 'text/markdown; charset=utf-8'
    '.txt'  = 'text/plain; charset=utf-8'
}

try {
    while ($listener.IsListening) {
        $ctx = $listener.GetContext()
        $path = $ctx.Request.Url.LocalPath
        if ($path -eq '/' -or $path -eq '') { $path = '/index.html' }

        $rel = ($path.TrimStart('/') -replace '/', '\')
        $file = Join-Path $Root $rel

        if (Test-Path -LiteralPath $file -PathType Container) {
            $file = Join-Path $file 'index.html'
        }

        if (Test-Path -LiteralPath $file -PathType Leaf) {
            $bytes = [System.IO.File]::ReadAllBytes($file)
            $ext = [System.IO.Path]::GetExtension($file).ToLowerInvariant()
            $ctx.Response.ContentType = if ($mime.ContainsKey($ext)) { $mime[$ext] } else { 'application/octet-stream' }
            $ctx.Response.Headers['Cache-Control'] = 'no-store'
            $ctx.Response.ContentLength64 = $bytes.Length
            $ctx.Response.OutputStream.Write($bytes, 0, $bytes.Length)
        } else {
            $ctx.Response.StatusCode = 404
            $bytes = [System.Text.Encoding]::UTF8.GetBytes('not found')
            $ctx.Response.ContentType = 'text/plain; charset=utf-8'
            $ctx.Response.OutputStream.Write($bytes, 0, $bytes.Length)
        }
        $ctx.Response.Close()
    }
}
finally {
    $listener.Stop()
    $listener.Close()
}
