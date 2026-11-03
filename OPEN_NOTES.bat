@echo off
setlocal
title CSC 112 Revision Notes

set "INDEX=%~dp0docs\index.html"

if not exist "%INDEX%" (
    echo.
    echo ERROR: the formatted notes were not found:
    echo   "%INDEX%"
    echo.
    echo You can still read the .md files directly, or rebuild the
    echo browser version with:
    echo   powershell -ExecutionPolicy Bypass -File "%~dp0docs\_build.ps1"
    echo.
    pause
    exit /b 1
)

start "" "%INDEX%"
endlocal
