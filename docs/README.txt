Formatted notes — how this works
===============================

index.html
    Open this in a browser (or double-click OPEN_NOTES.bat in the folder above).

The files in this folder are GENERATED. Do not edit them.

Source of truth
---------------
The real content lives one level up, as Markdown:

    ..\START_HERE.md
    ..\YOUR_14_DAY_PLAN.md
    ..\CHEAT_SHEET.md
    ..\PROGRESS_TRACKER.md
    ..\SETUP_AND_RUN.md
    ..\notes\*.md
    ..\practice\*.md
    ..\code\README.md

If you change any of those, regenerate this site:

    powershell -ExecutionPolicy Bypass -File ".\_build.ps1"

It takes about 15 seconds and rewrites every .html file here.

Saving as PDF
-------------
Open any page and press Ctrl+P, then choose "Save as PDF".

Colours and dark mode
---------------------
The moon/sun button in the top-right corner switches theme. The choice is
remembered in the browser.
