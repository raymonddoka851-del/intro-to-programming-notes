# Setup: Run C Code on This Computer

You do **not** need to install anything else. A C compiler (GCC 16.2.0) has already
been set up for you on this computer.

---

## The easy way: `RUN_CODE.bat`

1. Open the **Revision Pack** folder.
2. Double-click **`RUN_CODE.bat`**.
3. Type a program name, e.g. `hello.c`, and press Enter.

Or simply **drag a `.c` file** from the `code` folder onto `RUN_CODE.bat`.

The window shows:

- any compiler errors (if the program is wrong), and
- the program's output (if it compiles).

It pauses at the end so you can read the result. Press any key to close.

> The first time you run a program, Windows may show a security warning. Choose
> **More info → Run anyway** only if you trust the file (it is a simple batch file
> created for this revision pack).

---

## Run from a terminal (optional)

Open PowerShell in the `code` folder and run:

```powershell
& "$env:LOCALAPPDATA\mingw64\mingw64\bin\gcc.exe" -std=c11 -Wall -Wextra hello.c -o hello.exe
.\hello.exe
```

For any other file, replace `hello.c` and `hello.exe`.

To see useful warnings (recommended while learning):

```powershell
& "$env:LOCALAPPDATA\mingw64\mingw64\bin\gcc.exe" -std=c11 -Wall -Wextra -g program.c -o program.exe
```

`-Wall -Wextra` turns on warnings. **Read warnings even when the program runs** —
they often point to the exact bug the examiner will test.

---

## If Windows Defender blocks the compiler

Windows Defender sometimes flags `ld.exe` (the linker inside GCC) as
`Trojan:Win32/Bearfoos.A!ml`. **This is a known false positive** — `ld.exe` is a
standard part of every C compiler, not a virus.

The folder has already been added to Defender's exclusion list, so this should not
happen again. If `RUN_CODE.bat` ever says `cannot find 'ld'` or
`CreateProcess: No such file or directory`, the linker has been quarantined again.
Two ways to fix it:

1. **Use the online compiler** (below) — zero setup, works immediately.
2. **Restore the linker.** In Windows Security → *Virus & threat protection* →
   *Protection history*, find the `ld.exe` item and choose **Restore** (or
   **Allow on device**). Then run `hello.c` again.

As a last resort, re-extract it by opening PowerShell and running:

```powershell
& "C:\Program Files\7-Zip\7z.exe" x "$env:TEMP\opencode\winlibs.7z" `
  "mingw64\bin\ld.exe" "-o$env:LOCALAPPDATA\mingw64" -y
```

(That only works while the download is still in your Temp folder. If it is gone,
just use the online compiler — it is completely fine for this exam.)

---

## The absolutely easiest fallback: online

If anything goes wrong with the local compiler:

1. Go to <https://www.onlinegdb.com/online_c_compiler>.
2. Delete the sample code.
3. Paste the contents of any `.c` file from the `code` folder.
4. Press **Run** (or Ctrl+F5).

You can also use <https://www.programiz.com/c-programming/online-compiler/>.

---

## Day 2 check (do this once)

1. Run `hello.c`. You should see:

   ```
   Hello, World!
   Welcome to C programming.
   ```

2. Run `add_two.c`, enter `2 3`. You should see `2 + 3 = 5`.
3. Run `area_circle.c`, enter `2`. You should see area `12.57`.

If all three work, your setup is complete.

---

## What the compiler messages mean

| Message contains | Meaning | Usual fix |
|---|---|---|
| `expected ';' before ...` | Missing semicolon | Add `;` at the end of the previous statement |
| `'x' undeclared` | Variable used before declaration | Declare it, e.g. `int x;` |
| `expected declaration or statement at end of input` | Missing `}` | Count your braces |
| `implicit declaration of function 'printf'` | Missing header | Add `#include <stdio.h>` |
| `format '%d' expects argument of type 'int'` | Wrong `printf`/`scanf` specifier | Match `%d` with `int`, `%f` with `float`, `%lf` with `double` |
| `warning: suggest parentheses around assignment used as truth value` | You wrote `=` instead of `==` | Fix the condition |
| `undefined reference to ...` | Function declared but not defined / missing library | Check the function name or link the library |
| Program compiles but prints garbage | Uninitialised variable or wrong format | Initialise the variable; check specifiers |
| Program freezes | Infinite loop / waiting for input | Check the loop update and `scanf` |

---

## If you ever need to reinstall the compiler

The compiler lives here:

```
%LOCALAPPDATA%\mingw64\mingw64\bin\gcc.exe
```

Alternative options:

- **Online:** use the links above (no install).
- **Dev-C++:** <https://www.bloodshed.net/> (simple IDE for beginners).
- **Code::Blocks:** <https://www.codeblocks.org/downloads/> (choose the `mingw` build).
- **VS Code + MinGW:** install the C/C++ extension, then use the GCC path above.

You do **not** need an IDE for this exam. A terminal, or `RUN_CODE.bat`, is enough.
