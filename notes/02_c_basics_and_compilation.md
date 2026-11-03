# Note 02 — C Basics, Program Structure & Compilation

> **Covers outline Week 2** (compilation; C programming format and structure).

---

## 1. What is C?

- **C** is a general-purpose, procedural, compiled, high-level language.
- Developed by **Dennis M. Ritchie** at **Bell Laboratories** in **1972**.
- It grew out of the earlier **B** language and was used to rewrite the **UNIX** operating system.
- Standardised as **ANSI C (C89)**, then C99, C11, C17, C23.
- It is called a **"mid-level" language** because it combines high-level readability with low-level access to memory (pointers).

**Why learn C?**

| Reason | Explanation |
|---|---|
| Compact, fast and powerful | Small language, efficient compiled code |
| Portable | Same source compiles on many machines |
| Standard | Widely accepted; foundation of modern computing |
| Modular | Supports functions and separate compilation |
| Close to hardware | Pointers, bitwise operators, memory control |
| Foundation | C++ , Java, C#, Python's internals and OS kernels borrow from C |
| Native language of UNIX/Linux | Most operating systems are written in C |

---

## 2. The structure of a C program

### 2.1 Canonical first program

```c
#include <stdio.h>          /* preprocessor directive: include standard I/O */

int main(void)              /* program starts here; returns an int */
{
    /* My first program */
    printf("Hello World!\n");

    return 0;               /* tell the OS the program ended successfully */
}
```

**Output**

```
Hello World!
```

### 2.2 The six parts of a C program

| Part | Example | Purpose |
|---|---|---|
| **Preprocessor directives** | `#include <stdio.h>`, `#define PI 3.14` | Processed before compilation; no semicolon |
| **Global declarations** | `int count = 0;` | Variables/functions visible to the whole program |
| **`main()` function** | `int main(void)` | Entry point; every C program has exactly one |
| **Declarations** | `int age; float price;` | Reserve memory and state types |
| **Statements** | `age = 20; printf(...);` | The actual instructions; each ends with `;` |
| **Return statement** | `return 0;` | Ends `main` and returns a status to the OS |

### 2.3 Rules of C you must never break

1. **C is case-sensitive.** `main`, `Main` and `MAIN` are different. All keywords are lowercase.
2. **Every statement ends with a semicolon** `;` — except preprocessor directives and block braces.
3. **Braces `{ }` group statements** into a block. They must balance.
4. **C is free-form.** Whitespace and line breaks are ignored (except inside strings), so you can format code neatly.
5. **Strings use double quotes** `"hello"`; **single characters use single quotes** `'A'`.
6. **Every variable must be declared before use.**
7. **`main` returns `int`** in standard C; use `int main(void)` or `int main(int argc, char *argv[])`.
8. **Comments do not nest** (see §4).

### 2.4 `main` signatures

```c
int main(void) { ... }                       /* no command-line arguments */
int main(int argc, char *argv[]) { ... }     /* with command-line arguments */
```

`void main()` is common in old notes but is **not standard**. Use `int main` and `return 0;`.

---

## 3. Header files

A **header file** contains declarations of functions, macros and types. It is included with the preprocessor.

```c
#include <stdio.h>    /* printf, scanf, getchar, putchar, FILE, fopen... */
#include <stdlib.h>   /* malloc, free, exit, atoi, rand, system... */
#include <math.h>     /* sqrt, pow, sin, cos, fabs... */
#include <string.h>   /* strlen, strcpy, strcat, strcmp... */
#include <ctype.h>    /* isalpha, isdigit, toupper, tolower... */
#include <conio.h>    /* getch() — non-standard, Windows only */
```

**Angle brackets vs double quotes**

```c
#include <stdio.h>    /* search the compiler's standard include directories */
#include "mylib.h"    /* search the current project directory first */
```

**Important:** `#include` is **not** a statement, so it has **no semicolon**.

---

## 4. Comments

Comments are ignored by the compiler; they document the code.

```c
/* This is a block comment.
   It can span several lines. */

// This is a single-line comment (C99 and later)

int x = 5;   /* comment after code */
```

**Rules**
- Block comments `/* ... */` **cannot be nested**.
- `/* outer /* inner */ still outer */` is wrong: the first `*/` closes the comment, and `still outer */` causes an error.
- Use comments to explain **why**, not to repeat **what** the code obviously does.

---

## 5. Identifiers, keywords and names

### 5.1 Rules for identifiers (names)

An identifier is a name for a variable, function, array, struct, etc.

1. Must begin with a **letter** (A–Z, a–z) or an **underscore** `_`.
2. May contain letters, digits and underscores after the first character.
3. **No spaces**, no special symbols (`@`, `-`, `%`, etc.).
4. Cannot be a **keyword** (reserved word).
5. **Case-sensitive**: `Sum`, `sum` and `SUM` are three different identifiers.
6. Should be **meaningful** but not too long: `total_marks`, not `t`.

**Valid:** `sum`, `_count`, `student1`, `total_marks`, `x2`
**Invalid:** `2sum` (starts with digit), `total marks` (space), `total-marks` (hyphen), `float` (keyword), `student@1` (symbol)

### 5.2 Keywords

Keywords are reserved words with special meaning to the compiler. You cannot use them as names.

Common ones:

```
auto     break    case     char     const    continue  default   do
double   else     enum     extern   float    for       goto      if
int      long     register return   short    signed    sizeof    static
struct   switch   typedef  union    unsigned void      volatile  while
```

C89 has 32 keywords; C99 adds `inline`, `restrict`, `_Bool`, `_Complex`, `_Imaginary`.

### 5.3 Naming conventions

| Item | Convention | Example |
|---|---|---|
| Variables | lowercase, underscores | `total_marks` |
| Constants | UPPERCASE | `MAX_SIZE`, `PI` |
| Functions | lowercase, verbs | `calculate_average()` |
| Structs | Capitalised or `_t` suffix | `Student`, `student_t` |
| Pointers | prefix `p` | `pCount` |

---

## 6. Symbolic constants

### 6.1 `#define` (preprocessor)

```c
#define PI 3.14159
#define MAX 100
#define NEWLINE '\n'
#define NAME "Alice"
```

- No semicolon at the end.
- The preprocessor performs **text substitution** before compilation.
- Traditionally written in UPPERCASE.
- You cannot assign a new value to it.

```c
#define TAXRATE 0.10

int main(void) {
    float balance = 72.10;
    float tax = balance * TAXRATE;
    printf("The tax on %.2f is %.2f\n", balance, tax);
    return 0;
}
```

**Output:** `The tax on 72.10 is 7.21`

If the tax rate changes, you edit **one line**.

### 6.2 `const` (compiler-enforced)

```c
const double PI = 3.14159;
const int MAX = 100;
```

- Has a type, so the compiler checks it.
- Cannot be changed after initialisation.
- Preferred in modern C.

| `#define` | `const` |
|---|---|
| Preprocessor text replacement | Real variable with a type |
| No type checking | Type-checked |
| No semicolon | Needs semicolon |
| No memory allocated (usually) | Memory allocated |
| Cannot be debugged easily | Visible to the debugger |

---

## 7. From source code to running program

### 7.1 The four steps

```
hello.c
   │  preprocessor  (#include, #define)
   ▼
hello.i  (expanded source)
   │  compiler  (syntax check, translate)
   ▼
hello.s  (assembly)
   │  assembler
   ▼
hello.o  (object code)
   │  linker  (+ library code, e.g. printf)
   ▼
hello.exe  (executable)
   │  loader  (loads into RAM)
   ▼
Running program
```

| Step | Tool | Input | Output | Errors detected |
|---|---|---|---|---|
| 1. Preprocessing | Preprocessor | `.c` | `.i` | Missing header file, bad macro |
| 2. Compilation | Compiler | `.i` | `.s` | **Syntax errors**, type errors |
| 3. Assembly | Assembler | `.s` | `.o` | Assembly-level errors (rare) |
| 4. Linking | Linker | `.o` + libraries | `.exe` | **Undefined reference** (missing function) |
| 5. Loading | Loader/OS | `.exe` | Running process | File not found, permission |
| 6. Execution | CPU | — | Output | **Runtime errors** |

### 7.2 Compiling with GCC

```bash
gcc hello.c -o hello          # compile and link
gcc -Wall -Wextra hello.c -o hello   # with warnings
gcc -E hello.c -o hello.i     # preprocess only
gcc -S hello.c -o hello.s     # compile to assembly
gcc -c hello.c -o hello.o     # compile/assemble only
gcc hello.o -o hello          # link
./hello                       # run (Linux/macOS)
hello.exe                     # run (Windows)
```

### 7.3 Important vocabulary

- **Source file** — the `.c` file you write.
- **Object file** — compiled machine code, not yet runnable because library functions are missing.
- **Library** — pre-written functions (e.g., `printf` in the C standard library).
- **Linker** — attaches library code to your object code.
- **Loader** — moves the executable from disk into RAM.
- **Executable** — the final runnable file.

> **Why "undefined reference to `printf`" happens:** you forgot `#include <stdio.h>` **or** you did not link the library. The compiler knew the name but the linker could not find the code.

---

## 8. Input and output — first look

### 8.1 `printf`

```c
printf("control string", argument1, argument2, ...);
```

```c
int age = 20;
printf("Age = %d\n", age);
```

- `%d` is a **format specifier** — it says "print an integer here".
- `\n` is a **newline** escape sequence.
- The number of format specifiers should match the number of arguments.

### 8.2 `scanf`

```c
scanf("control string", &variable1, &variable2, ...);
```

```c
int age;
printf("Enter your age: ");
scanf("%d", &age);
```

- The **`&` (address-of operator)** tells `scanf` where to store the value.
- **Exception:** when reading a string into a `char` array, the array name is already an address, so no `&`:

```c
char name[20];
scanf("%19s", name);     /* no & */
```

### 8.3 First complete programs

**Add two integers**

```c
#include <stdio.h>

int main(void)
{
    int a, b, sum;

    printf("Enter two integers: ");
    scanf("%d %d", &a, &b);

    sum = a + b;
    printf("Sum = %d\n", sum);

    return 0;
}
```

**Area of a circle**

```c
#include <stdio.h>
#define PI 3.14159

int main(void)
{
    float radius, area;

    printf("Enter radius: ");
    scanf("%f", &radius);

    area = PI * radius * radius;
    printf("Area = %.2f\n", area);

    return 0;
}
```

**Average of three numbers**

```c
#include <stdio.h>

int main(void)
{
    float a, b, c, average;

    printf("Enter three numbers: ");
    scanf("%f %f %f", &a, &b, &c);

    average = (a + b + c) / 3.0;
    printf("Average = %.2f\n", average);

    return 0;
}
```

> `(a + b + c) / 3` would still work here because `a`, `b`, `c` are floats. If they were `int`, `/ 3` would truncate. See Note 03/04.

---

## 9. Common beginner errors (and their type)

| Code | Error | Type |
|---|---|---|
| `printf("Hello")` | Missing semicolon | Syntax |
| `printf("Hello);` | Missing closing quote | Syntax |
| `Printf("Hello");` | Wrong case | Syntax (undefined function) |
| `int main() { ... ` | Missing `}` | Syntax |
| `scanf("%d", x);` | Missing `&` | Runtime (crash or no input) |
| `int x; printf("%d", x);` | Uninitialised variable | Logical/runtime (garbage) |
| `x = 5` used in `if (x = 5)` | Assignment instead of comparison | Logical |
| `printf("%d", 3.5);` | Wrong format specifier | Undefined behaviour |
| `#include <stdio.h>;` | Semicolon after include | Syntax |
| `void main()` | Non-standard | Warning/portability |
| `int 2x = 5;` | Identifier starts with digit | Syntax |
| `float = 3.14;` | Missing variable name | Syntax |
| `if (x > 5);` | Semicolon ends the `if` | Logical (body never runs as intended) |

---

## 10. Worked exam question

**Write a C program that reads two numbers and prints their sum, difference, product and quotient.**

```c
#include <stdio.h>

int main(void)
{
    float a, b;

    printf("Enter two numbers: ");
    scanf("%f %f", &a, &b);

    printf("Sum        = %.2f\n", a + b);
    printf("Difference = %.2f\n", a - b);
    printf("Product    = %.2f\n", a * b);

    if (b != 0)
        printf("Quotient   = %.2f\n", a / b);
    else
        printf("Quotient   : division by zero is not allowed\n");

    return 0;
}
```

**Why `float`?** Because division of integers truncates: `5 / 2` gives `2`, but `5.0 / 2` gives `2.5`.

**Why check `b != 0`?** Division by zero is a runtime error. Always guard it.

---

## 11. Rapid revision

- C: Dennis Ritchie, 1972, Bell Labs, used for UNIX.
- Structure: preprocessor directives → global declarations → `main()` → declarations → statements → `return 0;`.
- `#include <stdio.h>` for `printf`/`scanf`; **no semicolon**.
- `main` is the entry point; C is case-sensitive; statements end with `;`.
- Identifiers: letter/underscore first, then letters/digits/underscores; not a keyword.
- `#define` = preprocessor substitution; `const` = typed read-only variable.
- Pipeline: **preprocessor → compiler → assembler → linker → loader → run**.
- `.c → .i → .s → .o → .exe`.
- Syntax errors = compiler; undefined reference = linker; runtime errors = execution; logical errors = testing.
- `scanf` needs `&` (except arrays/strings).

---

## 12. Self-test (answers below)

1. Who developed C, where and when?
2. List the six parts of a C program.
3. Why does `#include <stdio.h>` not end with a semicolon?
4. State five rules for naming identifiers.
5. Differentiate `#define` and `const`.
6. Describe the five stages from source code to a running program.
7. What is the difference between object code and an executable?
8. What does the linker do?
9. What is the difference between a syntax error and a logical error?
10. Write a program to read the radius and print the area and circumference of a circle.
11. Identify the errors:
    ```c
    #include <stdio.h>
    void main()
    {
        int x
        printf("Enter x: ");
        scanf("%f", x);
        printf("%d\n", x);
    }
    ```
12. What is printed?
    ```c
    int a = 7, b = 2;
    printf("%d %.2f\n", a / b, (float)a / b);
    ```

### Answers

1. Dennis M. Ritchie, Bell Laboratories, 1972.
2. Preprocessor directives, global declarations, `main()`, declarations, statements, return statement.
3. It is a preprocessor directive, not a C statement; the preprocessor handles it before compilation.
4. Start with a letter or underscore; only letters/digits/underscores afterwards; no spaces/special symbols; not a keyword; case-sensitive; meaningful.
5. `#define` is text substitution with no type checking and no semicolon; `const` is a typed, compiler-checked read-only variable that needs a semicolon.
6. Preprocessing → compilation → assembly → linking → loading/execution.
7. Object code is machine code with unresolved external references (not runnable); an executable has all library code linked and can be run.
8. The linker combines object code with library code and resolves external references to produce an executable.
9. A syntax error violates C grammar and prevents compilation; a logical error compiles and runs but produces wrong output.
10. See `code/area_circle.c` (uses `2 * PI * r` for circumference).
11. `void main` should be `int main(void)`; missing semicolon after `int x`; `scanf("%f", x)` uses the wrong specifier and missing `&` (should be `%d`, `&x`); missing `return 0;`.
12. `3 3.50` — `a / b` is integer division (7/2 = 3), while the cast makes the second division floating-point.

---

**Next:** `03_data_types_and_number_systems.md`
