@echo off
setlocal EnableExtensions
title C Program Runner - CSC 112

if "%~1"=="" (
    echo ============================================
    echo        C PROGRAM RUNNER - CSC 112
    echo ============================================
    echo.
    echo Type the name of a .c file, for example: hello.c
    echo Tip: you can also drag a .c file onto this window.
    echo.
    set /p "FILE=File: "
) else (
    set "FILE=%~1"
)

rem Remove surrounding quotes if the user typed them
set "FILE=%FILE:"=%"

if not exist "%FILE%" (
    echo.
    echo ERROR: file not found: "%FILE%"
    echo Make sure you are in the code folder, or type the full path.
    echo.
    pause
    exit /b 1
)

set "GCC=%LOCALAPPDATA%\mingw64\mingw64\bin\gcc.exe"
if not exist "%GCC%" (
    where gcc >nul 2>nul
    if errorlevel 1 (
        echo.
        echo ERROR: gcc was not found.
        echo Use the online compiler instead:
        echo https://www.onlinegdb.com/online_c_compiler
        echo.
        pause
        exit /b 1
    )
    set "GCC=gcc"
)

for %%F in ("%FILE%") do set "NAME=%%~nF"
set "OUT=%TEMP%\%NAME%.exe"

echo.
echo Compiling %FILE% ...
echo.
"%GCC%" -std=c11 -Wall -Wextra "%FILE%" -o "%OUT%"

if errorlevel 1 (
    echo.
    echo ============================================
    echo  COMPILATION FAILED
    echo  Read the FIRST error message above.
    echo  Common causes: missing ;  missing }  typo in a name
    echo ============================================
    echo.
    pause
    exit /b 1
)

echo.
echo ---------- OUTPUT ----------
echo.
"%OUT%"
echo.
echo ----------------------------
echo.
pause
endlocal
