# Answer Key — Question Bank

> Mark your own work strictly. A wrong answer you understand is worth more than a
> right answer you guessed. For code questions, any correct program earns the marks —
> the versions below are model answers, not the only answers.

---

## Section A — Programming fundamentals

**Q1.**
(a) **Program:** a finite set of sequenced instructions that tells a computer how to
perform a task.
(b) **Programming:** the process of designing, writing, testing and maintaining those
instructions.
(c) **Programming language:** a formal language with syntax and semantics used to
write instructions, e.g. C, Python, Java.

**Q2.**
**Low-level languages** (machine and assembly):
- Advantages: fast execution; efficient use of memory; no translator needed for
  machine code; direct control of hardware.
- Disadvantages: machine-dependent; difficult to learn/write/read; error-prone;
  bulky; time-consuming to develop.

**High-level languages** (C, Python, Java):
- Advantages: machine-independent/portable; easy to learn and write; readable;
  easier to debug and maintain.
- Disadvantages: need translation (compiler/interpreter); slower than low-level;
  less memory-efficient; cannot access hardware directly.

**Q3.**

| Machine language | Assembly language | High-level language |
|---|---|---|
| Binary 0s and 1s | Mnemonics, e.g. `MOV`, `ADD` | English-like statements |
| Directly executed by CPU | Needs an assembler | Needs compiler/interpreter |
| Machine-dependent | Machine-dependent | Machine-independent |
| Example: `10110000 01100001` | Example: `MOV AL, 61h` | Example: `x = a + b;` |

**Q4.**
1. Compiler translates the whole program at once; interpreter translates one
   statement at a time.
2. Compiler produces object code; interpreter produces no object code.
3. Compiler reports errors after scanning the whole program; interpreter stops at the
   first error.
4. Compiled programs generally execute faster; interpreted programs execute slower but
   are easier to debug.
5. C/C++ use compilers; Python/Ruby commonly use interpreters.

**Q5.**
1. **Problem definition/analysis** — understand the problem, inputs, outputs and
   requirements.
2. **Algorithm selection/development** — write the steps to solve it.
3. **Program design** — represent the logic using flowcharts, pseudocode, IPO/HIPO.
4. **Coding** — write the program in a programming language.
5. **Compilation** — translate source code to object code; remove syntax errors.
6. **Testing, running and debugging** — run with test data and fix errors.
7. **Documentation** — record how the program works and how to use it.
8. **Maintenance** — correct, modify and improve the program after release.

**Q6.** Any six with a sentence each:
- **Correctness/reliability** — does what it is supposed to do.
- **Portability** — runs on different machines with little/no change.
- **Efficiency** — uses reasonable time and memory.
- **Simplicity/readability** — easy to read and understand.
- **Maintainability** — easy to modify and fix.
- **Robustness** — handles invalid input without crashing.
- **Cost-effectiveness** — benefits outweigh development cost.
- **Documentation** — well explained for users and maintainers.

**Q7.**
(a) An **algorithm** is a finite, ordered, unambiguous set of steps that solves a
problem.
(b) Features: **input**, **output**, **definiteness** (clear steps), **finiteness**
(must terminate), **effectiveness** (each step is simple enough to perform), and it
should produce a unique solution.

**Q8.**
*Algorithm:*
1. Start.
2. Read A, B, C.
3. If A ≥ B and A ≥ C, then Largest = A.
4. Else if B ≥ A and B ≥ C, then Largest = B.
5. Else Largest = C.
6. Print Largest.
7. Stop.

*Pseudocode:*
```
BEGIN
  INPUT A, B, C
  IF A >= B AND A >= C THEN
      Largest = A
  ELSE IF B >= A AND B >= C THEN
      Largest = B
  ELSE
      Largest = C
  END IF
  PRINT Largest
END
```

**Q9.**
(a)
- **Terminal (oval):** start/stop.
- **Input/Output (parallelogram):** read data or display results.
- **Process (rectangle):** a calculation or assignment.
- **Decision (diamond):** a condition with Yes/No branches.
- **Connector (circle):** joins parts of the chart / continues on another page.
- (Also flow lines = arrows.)

(b) Flowchart:
```
        ( Start )
            |
      / Read n /
            |
        < n % 2 == 0 ? >
         /          \
      Yes            No
       |              |
/ Print "Even" /  / Print "Odd" /
       \              /
        +-------> ( Stop )
```

**Q10.**
- **Syntax error:** breaks the grammar of C; detected by the compiler; the program
  will not compile. Example: `printf("Hi")` missing `;`.
- **Runtime error:** occurs while the program runs, after successful compilation.
  Example: division by zero `a / 0`.
- **Logical error:** the program compiles and runs but gives the wrong result.
  Example: using `average = sum + n` instead of `sum / n`.

---

## Section B — C basics and compilation

**Q11.**
```c
#include <stdio.h>      /* preprocessor: include header */

#define PI 3.14159      /* symbolic constant */

int main(void)          /* main function: program starts here */
{
    int x = 5;          /* declarations */
    printf("%d\n", x);  /* statements */
    return 0;           /* return success to the OS */
}
```
Parts: **documentation/comments**, **preprocessor directives**, **global
declarations**, **main function**, **declarations**, **executable statements**,
**return**.

**Q12.** A header file contains declarations of functions, macros and types used by
the program; it is included with `#include`.
- `<stdio.h>` — input/output (`printf`, `scanf`, `fopen`).
- `<stdlib.h>` — general utilities (`malloc`, `free`, `exit`, `atoi`).
- `<math.h>` — mathematical functions (`sqrt`, `pow`, `sin`).
- `<string.h>` — string functions (`strlen`, `strcpy`, `strcmp`).
- `<ctype.h>` — character tests (`isalpha`, `isdigit`, `toupper`).
- `<conio.h>` — console input/output (non-standard; `getch`).

**Q13.** Rules:
- Must begin with a letter or underscore.
- May contain only letters, digits and underscores.
- No spaces or special symbols.
- Cannot be a keyword.
- Case-sensitive; meaningful names recommended.

Valid: `total`, `_count`, `Sum`. Invalid: `2ndNumber` (starts with a digit),
`student-name` (hyphen), `float` (keyword).

**Q14.** **Keywords** are reserved words with a fixed meaning to the compiler, e.g.
`int`, `float`, `char`, `if`, `else`, `for`, `while`, `return`, `void`, `switch`.
They cannot be used as identifiers because the compiler would confuse the user name
with its own reserved instruction.

**Q15.**
| `#define` | `const` |
|---|---|
| Preprocessor directive | C keyword/qualifier |
| No semicolon; no `=` | Uses `=` and ends with `;` |
| Textual substitution before compilation | Real typed variable |
| No data type; no type checking | Has a type; type-checked |
| `#define PI 3.14` | `const float PI = 3.14;` |

**Q16.**
- `/* ... */` — block comment, can span lines.
- `// ...` — single-line comment (C99 onwards).

Reasons: document the program; explain difficult logic; record author/date/version;
temporarily disable code. Comments **cannot be nested** — the first `*/` closes the
comment.

**Q17.**
1. **Preprocessor** — handles `#include`, `#define`, conditional compilation; produces
   expanded source code.
2. **Compiler** — checks syntax and translates the expanded source into assembly
   language.
3. **Assembler** — translates assembly into machine/object code (`.o`/`.obj`).
4. **Linker** — combines the object code with library code and other object files to
   produce an executable.
5. **Loader** — loads the executable from secondary storage into memory and starts
   execution.

**Q18.**
- **Source code:** human-readable program written in a high-level language, e.g.
  `program.c`.
- **Object code:** machine code produced by the compiler, e.g. `program.o`; not yet
  executable because library functions are missing.
- **Executable:** fully linked file, e.g. `program.exe`, that the operating system can
  run.

**Q19.** The **linker** combines object files and library functions (e.g. `printf`)
into one executable program and resolves references between them. Without it, the
object code would lack the library code needed to run.

**Q20.** Two errors:
1. **Syntax error:** the `printf` statement is missing its semicolon (`;`). The program
   will not compile.
2. **Runtime error (after fixing the semicolon):** `a / b` divides by zero because
   `b = 0`, causing undefined behaviour/a crash.

---

## Section C — Data types and number systems

**Q21.** A **bit** is one binary digit (0 or 1). A **byte** is 8 bits. A **nibble** is
4 bits. A **word** is the natural unit a CPU processes at once (often 16, 32 or 64
bits). Values: 4 bits → 2⁴ = 16; 8 bits → 2⁸ = 256; n bits → 2ⁿ.

**Q22.**
- 13 = `1101`
- 45 = `101101`
- 100 = `1100100`
- 255 = `11111111`

**Q23.**
- `1011` = 8 + 2 + 1 = **11**
- `110010` = 32 + 16 + 2 = **50**
- `11111111` = 128+64+32+16+8+4+2+1 = **255**

**Q24.**
(a) 60 ÷ 8 = 7 remainder 4, 7 ÷ 8 = 0 remainder 7 → **074₈**.
(b) 60 = 3×16 + 12 → **0x3C**.
(c) `101011` → group `0010 1011` → **0x2B**.
(d) `3F` = 3×16 + 15 = **63**.

**Q25.** **Signed** integers can be positive, negative or zero and use one bit
(usually the leftmost) for the sign. **Unsigned** integers are only zero or positive,
so all bits represent magnitude.
- 8-bit unsigned: 0 to 255.
- 8-bit signed (two's complement): −128 to +127.
- 16-bit signed: −32,768 to +32,767.

**Q26.**
(a) −12: 12 = `00001100` → invert `11110011` → +1 = **`11110100`** (0xF4).
−25: 25 = `00011001` → invert `11100110` → +1 = **`11100111`** (0xE7).

(b) Two's complement has only one representation of zero, makes addition and
subtraction use the same hardware, and handles overflow simply. Sign-and-magnitude
has two zeros (+0 and −0) and needs separate subtraction circuitry.

**Q27.**

| Type | Size (typical) | `printf` | Example | Use |
|---|---|---|---|---|
| `int` | 4 bytes | `%d` | `25` | counting, whole numbers |
| `float` | 4 bytes | `%f` | `3.14f` | decimals (6–7 digits) |
| `double` | 8 bytes | `%f` (printf), `%lf` (scanf) | `3.14159` | precise decimals |
| `char` | 1 byte | `%c` | `'A'` | single character |

**Q28.** `'A'` = 65, `'a'` = 97, `'0'` = 48, space = 32, `'\n'` = 10, `'\0'` = 0.
A **character code** is the numeric value used internally to represent a character
(C uses ASCII on most systems).

**Q29.**
- **Implicit conversion:** automatic conversion by the compiler when types are mixed,
  e.g. `int` to `float` in `3 + 2.5`.
- **Explicit casting:** the programmer forces a conversion with `(type)`, e.g.
  `(float)7 / 2`.

(a) `7 / 2` = **3** (integer division).
(b) `(float)7 / 2` = **3.5**.
(c) `(int)7.9` = **7** (fraction discarded).
(d) `'A' + 1` = 65 + 1 = **66** (which is `'B'`).

**Q30.** `sizeof` returns the number of bytes occupied by a type or variable.
`sizeof(int)` is typically **4** and `sizeof(char)` is **1**, so the output is
`4 1`.

---

## Section D — Operators and expressions

**Q31.** Any five:
- Arithmetic: `+ - * / %`
- Relational: `== != < > <= >=`
- Logical: `&& || !`
- Bitwise: `& | ^ ~ << >>`
- Assignment: `= += -= *= /= %=`
- Increment/decrement: `++ --`
- Conditional: `?:`
- `sizeof`, `&`, `*`, `.`, `->`.

**Q32.**
(a) 17 / 5 = **3**.
(b) 17 % 5 = **2**.
(c) −17 / 5 = **−3** (C truncates toward zero); −17 % 5 = **−2**.
(d) 7 / 2.0 = **3.5**.

`/` gives the quotient and works with integers or floating point. `%` gives the
remainder and works **only with integers**.

**Q33.** **Relational operators** compare two values and return 1 (true) or 0 (false),
e.g. `>`, `==`. **Logical operators** combine conditions, e.g. `&&`, `||`, `!`.

| a | b | a && b | a \|\| b | !a |
|---|---|---|---|---|
| 0 | 0 | 0 | 0 | 1 |
| 0 | 1 | 0 | 1 | 1 |
| 1 | 0 | 0 | 1 | 0 |
| 1 | 1 | 1 | 1 | 0 |

**Q34.** 12 = `1100`, 10 = `1010`.
(a) `12 & 10` = `1000` = **8**.
(b) `12 | 10` = `1110` = **14**.
(c) `12 ^ 10` = `0110` = **6**.
(d) `~12` = **−13**.
(e) `12 << 2` = 12 × 4 = **48**.
(f) `12 >> 2` = **3**.

**Q35.**
```c
int x = 3;
x += 5;   /* x = 8  */
x *= 2;   /* x = 16 */
x -= 4;   /* x = 12 */
```

**Q36.** Starting from `a = 5` each time:
(a) `b = a++` → b = **5**, a = **6**.
(b) `b = ++a` → a = **6**, b = **6**.
(c) `b = a--` → b = **5**, a = **4**.
(d) `b = --a` → a = **4**, b = **4**.

**Q37.** Syntax: `condition ? value_if_true : value_if_false`.
```c
printf("%s", (n % 2 == 0) ? "Even" : "Odd");
```

**Q38.**
(a) 2 + 12 = **14**.
(b) 5 × 4 = **20**.
(c) (10 − 4) − 3 = **3** (left-associative).
(d) (100 / 10) / 2 = **5**.
(e) `5 > 3` is true (1) and `2 < 4` is true (1), so **1** (true).

**Q39.**
```
x = 10
x += 5  → 15
x -= 3  → 12
x *= 2  → 24
x /= 4  → 6
x %= 4  → 2
```
Final **x = 2**.

**Q40.**
(a) With a temporary:
```c
int temp = a; a = b; b = temp;
```
(b) Without a temporary:
```c
a = a + b;
b = a - b;
a = a - b;
```
Risk: `a + b` can **overflow** the integer range. (XOR swap avoids overflow but is
harder to read.)

---

## Section E — Selection statements

**Q41.**
```c
if (condition)
{
    statements;
}
```
```c
#include <stdio.h>
int main(void)
{
    int n;
    printf("Enter an integer: ");
    scanf("%d", &n);
    if (n % 2 == 0)
        printf("Even\n");
    return 0;
}
```

**Q42.** `if-else` handles **two** alternatives (true/false). The `else-if` ladder
handles **many mutually exclusive** alternatives and tests conditions in order; once
one is true, the rest are skipped. Use `if-else` for a simple yes/no; use `else-if`
for grades, categories or ranges.

**Q43.**
```c
#include <stdio.h>
int main(void)
{
    int mark;
    printf("Enter mark: ");
    scanf("%d", &mark);

    if (mark >= 70 && mark <= 100)      printf("A\n");
    else if (mark >= 60)                printf("B\n");
    else if (mark >= 50)                printf("C\n");
    else if (mark >= 40)                printf("D\n");
    else if (mark >= 0)                 printf("E\n");
    else                                printf("Invalid mark\n");
    return 0;
}
```

**Q44.**
```c
#include <stdio.h>
int main(void)
{
    int a, b, c;
    printf("Enter three numbers: ");
    scanf("%d %d %d", &a, &b, &c);

    if (a >= b) {
        if (a >= c) printf("Largest = %d\n", a);
        else        printf("Largest = %d\n", c);
    } else {
        if (b >= c) printf("Largest = %d\n", b);
        else        printf("Largest = %d\n", c);
    }
    return 0;
}
```

**Q45.**
```c
switch (expression)
{
    case constant1: statements; break;
    case constant2: statements; break;
    default: statements;
}
```
Rules:
- The expression must be an integer or character type (not `float` or a string).
- Case labels must be **constant** expressions and must be unique.
- `break` is needed to stop fall-through.
- `default` is optional and handles all other values.
- Braces are needed if you declare variables inside a case.

**Q46.** For `choice = 2`: execution starts at `case 2`, prints `"Two "`, then falls
through to `case 3`, prints `"Three "`, then `break` exits. Output: **`Two Three `**.

If `break` is removed from case 3, execution also falls into `default` and prints
`"Other"`, giving **`Two Three Other`**.

**Q47.** `=` is **assignment**; `==` is **comparison**. `if (x = 5)` assigns 5 to `x`;
the value of the assignment is 5, which is non-zero/true, so the program prints
**`Yes`** (and `x` becomes 5). Most compilers give a warning.

**Q48.**
```c
#include <stdio.h>
int main(void)
{
    int year;
    printf("Enter year: ");
    scanf("%d", &year);

    if ((year % 4 == 0 && year % 100 != 0) || year % 400 == 0)
        printf("%d is a leap year\n", year);
    else
        printf("%d is not a leap year\n", year);
    return 0;
}
```

**Q49.**
```c
#include <stdio.h>
#include <ctype.h>
int main(void)
{
    char ch;
    printf("Enter a letter: ");
    scanf(" %c", &ch);
    ch = tolower(ch);

    switch (ch) {
        case 'a': case 'e': case 'i': case 'o': case 'u':
            printf("Vowel\n"); break;
        default:
            if (isalpha(ch)) printf("Consonant\n");
            else             printf("Not a letter\n");
    }
    return 0;
}
```

**Q50.** `x = 10`, so `x > 5` is true. The inner `if (x > 15)` is false, so its
`else` prints `B`. Then `printf("C")` runs. Output: **`BC`**.

---

## Section F — Loops

**Q51.**
```c
while (condition)
{
    statements;
}
```
```c
#include <stdio.h>
int main(void)
{
    int i = 1;
    while (i <= 5) {
        printf("%d ", i);
        i++;
    }
    return 0;
}
/* Output: 1 2 3 4 5 */
```

**Q52.** `while` is **entry-controlled**: the condition is tested before the body, so
it may run **zero** times. `do-while` is **exit-controlled**: the body runs once
before the condition is tested, so it runs **at least once**. `do-while` is better
for input validation menus ("repeat until the user enters a valid choice").

**Q53.**
```c
for (initialise; condition; update)
{
    statements;
}
```
```c
#include <stdio.h>
int main(void)
{
    int n, i, sum = 0;
    printf("Enter n: ");
    scanf("%d", &n);
    for (i = 1; i <= n; i++)
        sum += i;
    printf("Sum = %d\n", sum);
    return 0;
}
```

**Q54.**
```c
#include <stdio.h>
int main(void)
{
    int n, i;
    long long fact = 1;
    printf("Enter n: ");
    scanf("%d", &n);
    for (i = 1; i <= n; i++)
        fact *= i;
    printf("Factorial = %lld\n", fact);
    return 0;
}
```

**Q55.**
```c
#include <stdio.h>
int main(void)
{
    int n, rev = 0, digit;
    printf("Enter number: ");
    scanf("%d", &n);
    while (n != 0) {
        digit = n % 10;
        rev = rev * 10 + digit;
        n /= 10;
    }
    printf("Reversed = %d\n", rev);
    return 0;
}
```

**Q56.**
```c
#include <stdio.h>
int main(void)
{
    int n, count = 0, sum = 0, digit;
    printf("Enter number: ");
    scanf("%d", &n);
    if (n == 0) { count = 1; sum = 0; }
    while (n != 0) {
        digit = n % 10;
        sum += digit;
        count++;
        n /= 10;
    }
    printf("Digits = %d, Sum = %d\n", count, sum);
    return 0;
}
```

**Q57.**
```c
#include <stdio.h>
int main(void)
{
    int n, i, isPrime = 1;
    printf("Enter number: ");
    scanf("%d", &n);

    if (n <= 1) isPrime = 0;
    for (i = 2; i * i <= n; i++) {
        if (n % i == 0) { isPrime = 0; break; }
    }
    if (isPrime) printf("%d is prime\n", n);
    else         printf("%d is not prime\n", n);
    return 0;
}
```

**Q58.**
```c
#include <stdio.h>
int main(void)
{
    int n, i;
    printf("Enter number: ");
    scanf("%d", &n);
    for (i = 1; i <= 10; i++)
        printf("%d x %d = %d\n", n, i, n * i);
    return 0;
}
```

**Q59.**
```c
#include <stdio.h>
int main(void)
{
    int i, j, n = 5;
    for (i = 1; i <= n; i++) {
        for (j = 1; j <= i; j++)
            printf("*");
        printf("\n");
    }
    return 0;
}
```

**Q60.**
(a)
```
1
12
123
```
(b) `break` exits the loop (or switch) immediately; `continue` skips the rest of the
current iteration and goes to the next iteration (or the loop condition/update).
`break` can also end a `switch`; `continue` applies only to loops.

---

## Section G — Functions and recursion

**Q61.** A **function** is a named block of code that performs one specific task and
can be called whenever needed.
Advantages: reusability; readability; easier testing/debugging; easier maintenance;
avoids repetition; supports divide-and-conquer and teamwork.

**Q62.**
- **Prototype:** declaration of the function's name, return type and parameter types,
  ending with `;`, e.g. `int max(int a, int b);`.
- **Definition:** the actual body with the code.
- **Call:** using the function, e.g. `m = max(3, 7);`.

```c
#include <stdio.h>
int max(int a, int b);          /* prototype */

int main(void)
{
    int x = 3, y = 7;
    printf("Max = %d\n", max(x, y));   /* call */
    return 0;
}

int max(int a, int b)           /* definition */
{
    return (a > b) ? a : b;
}
```

**Q63.** **Actual parameters (arguments)** are the values/variables supplied in the
function call, e.g. `x` and `y` in `max(x, y)`. **Formal parameters** are the
variables declared in the function definition that receive those values, e.g. `a` and
`b` in `int max(int a, int b)`. C passes them by value.

**Q64.** Four categories:
1. **No arguments, no return value:** `void greet(void) { printf("Hi"); }`
2. **No arguments, with return value:** `int readNumber(void) { int n; scanf("%d",&n); return n; }`
3. **With arguments, no return value:** `void printSum(int a, int b) { printf("%d", a+b); }`
4. **With arguments and return value:** `int add(int a, int b) { return a+b; }`

**Q65.** **Call by value** passes a copy of the argument; changes inside the function
do not affect the caller. **Call by reference** passes the address; changes through
the pointer do affect the caller. C uses call by value, but pointers simulate call by
reference.
```c
void swap(int *a, int *b)
{
    int temp = *a;
    *a = *b;
    *b = temp;
}
/* call: swap(&x, &y); */
```

**Q66.**
- **Local:** declared inside a function/block; accessible only there; lifetime = while
  the block runs; **no default value** (garbage unless initialised).
- **Global:** declared outside all functions; accessible throughout the file/program;
  lifetime = whole program; default value **0**.
- **Static local:** declared with `static` inside a function; accessible only there;
  lifetime = whole program; default value **0**; keeps its value between calls.

**Q67.** **Recursion** is when a function calls itself to solve a smaller version of
the same problem. Two parts:
1. **Base case** — the stopping condition.
2. **Recursive case** — the function calls itself with a smaller input.
```c
long long fact(int n)
{
    if (n <= 1) return 1;       /* base case */
    return n * fact(n - 1);     /* recursive case */
}
```

**Q68.** `factorial(4)` → `4 * factorial(3)` → `4 * 3 * factorial(2)` →
`4 * 3 * 2 * factorial(1)` → `4 * 3 * 2 * 1` = **24**. Calls: fact(4), fact(3),
fact(2), fact(1); then returns 1, 2, 6, 24.

**Q69.**
```c
int fib(int n)
{
    if (n <= 1) return n;       /* base: fib(0)=0, fib(1)=1 */
    return fib(n - 1) + fib(n - 2);
}
```
It is inefficient because the same subproblems are recalculated many times
(exponential time, O(2ⁿ)). It can be improved with memoisation or an iterative loop.

**Q70.**
```c
int sumDigits(int n)
{
    if (n == 0) return 0;
    return (n % 10) + sumDigits(n / 10);
}
/* sumDigits(1234) = 4 + 3 + 2 + 1 = 10 */
```

---

## Section H — Arrays and strings

**Q71.** An **array** is a collection of a fixed number of elements of the **same
type**, stored in contiguous memory and accessed by index.
```c
int a[5] = {10, 20, 30, 40, 50};
```
First index is **0**; last is **4** (size − 1).

**Q72.**
```c
#include <stdio.h>
int main(void)
{
    int a[10], i;
    printf("Enter 10 integers:\n");
    for (i = 0; i < 10; i++)
        scanf("%d", &a[i]);

    printf("In reverse: ");
    for (i = 9; i >= 0; i--)
        printf("%d ", a[i]);
    printf("\n");
    return 0;
}
```

**Q73.**
```c
#include <stdio.h>
int main(void)
{
    int a[100], n, i, sum = 0, max, min;
    printf("Enter number of elements: ");
    scanf("%d", &n);
    printf("Enter %d integers:\n", n);
    for (i = 0; i < n; i++)
        scanf("%d", &a[i]);

    max = min = a[0];
    for (i = 0; i < n; i++) {
        sum += a[i];
        if (a[i] > max) max = a[i];
        if (a[i] < min) min = a[i];
    }
    printf("Sum = %d\n", sum);
    printf("Average = %.2f\n", (float)sum / n);
    printf("Max = %d, Min = %d\n", max, min);
    return 0;
}
```

**Q74.** **Linear search** checks each element from the beginning until the target is
found or the array ends. It works on unsorted arrays; time is O(n).
```c
#include <stdio.h>
int main(void)
{
    int a[100], n, i, key, found = -1;
    printf("Enter n: "); scanf("%d", &n);
    for (i = 0; i < n; i++) scanf("%d", &a[i]);
    printf("Enter value to search: "); scanf("%d", &key);

    for (i = 0; i < n; i++) {
        if (a[i] == key) { found = i; break; }
    }
    if (found != -1) printf("Found at index %d\n", found);
    else             printf("Not found\n");
    return 0;
}
```

**Q75.** **Bubble sort** repeatedly compares adjacent pairs and swaps them if they are
in the wrong order. After each pass, the largest remaining value "bubbles" to the end.
```c
#include <stdio.h>
int main(void)
{
    int a[100], n, i, j, temp;
    printf("Enter n: "); scanf("%d", &n);
    for (i = 0; i < n; i++) scanf("%d", &a[i]);

    for (i = 0; i < n - 1; i++) {
        for (j = 0; j < n - 1 - i; j++) {
            if (a[j] > a[j + 1]) {
                temp = a[j];
                a[j] = a[j + 1];
                a[j + 1] = temp;
            }
        }
    }
    printf("Sorted: ");
    for (i = 0; i < n; i++) printf("%d ", a[i]);
    return 0;
}
```
Trace for `{5, 1, 4, 2, 8}`:
- Pass 1: {1,5,4,2,8} → {1,4,5,2,8} → {1,4,2,5,8} → {1,4,2,5,8}
- Pass 2: {1,4,2,5,8} → {1,2,4,5,8}
- Pass 3: no swaps → sorted **{1, 2, 4, 5, 8}**.

**Q76.**
```c
int m[3][4] = {
    {1, 2, 3, 4},
    {5, 6, 7, 8},
    {9, 10, 11, 12}
};

int i, j;
for (i = 0; i < 3; i++) {
    for (j = 0; j < 4; j++)
        scanf("%d", &m[i][j]);
}
for (i = 0; i < 3; i++) {
    for (j = 0; j < 4; j++)
        printf("%4d", m[i][j]);
    printf("\n");
}
```

**Q77.**
```c
#include <stdio.h>
int main(void)
{
    int a[2][2], b[2][2], c[2][2], i, j;
    printf("Enter matrix A (4 values):\n");
    for (i = 0; i < 2; i++)
        for (j = 0; j < 2; j++) scanf("%d", &a[i][j]);
    printf("Enter matrix B (4 values):\n");
    for (i = 0; i < 2; i++)
        for (j = 0; j < 2; j++) scanf("%d", &b[i][j]);

    for (i = 0; i < 2; i++)
        for (j = 0; j < 2; j++)
            c[i][j] = a[i][j] + b[i][j];

    printf("A + B =\n");
    for (i = 0; i < 2; i++) {
        for (j = 0; j < 2; j++) printf("%4d", c[i][j]);
        printf("\n");
    }
    return 0;
}
```

**Q78.**
```c
#include <stdio.h>
int main(void)
{
    int a[2][3], t[3][2], i, j;
    printf("Enter a 2x3 matrix:\n");
    for (i = 0; i < 2; i++)
        for (j = 0; j < 3; j++) scanf("%d", &a[i][j]);

    for (i = 0; i < 2; i++)
        for (j = 0; j < 3; j++)
            t[j][i] = a[i][j];

    printf("Transpose:\n");
    for (i = 0; i < 3; i++) {
        for (j = 0; j < 2; j++) printf("%4d", t[i][j]);
        printf("\n");
    }
    return 0;
}
```

**Q79.** A string is a `char` array ending with the **null character** `'\0'`.
`"Hello"` has 5 visible characters plus the `'\0'` terminator, so it needs **6 bytes**.
The **length** (`strlen`) counts characters before `'\0'` and is 5; the **size** of
the array is 6.

**Q80.**
```c
int myStrlen(const char *s)
{
    int i = 0;
    while (s[i] != '\0') i++;
    return i;
}

void myStrcpy(char *dest, const char *src)
{
    int i = 0;
    while ((dest[i] = src[i]) != '\0') i++;
}

void myStrcat(char *dest, const char *src)
{
    int i = 0, j = 0;
    while (dest[i] != '\0') i++;
    while ((dest[i++] = src[j++]) != '\0') ;
}

int myStrcmp(const char *a, const char *b)
{
    int i = 0;
    while (a[i] != '\0' && a[i] == b[i]) i++;
    return (unsigned char)a[i] - (unsigned char)b[i];
}
```
`myStrcmp` returns 0 if equal, negative if `a < b`, positive if `a > b`.

---

## Section I — Pointers

**Q81.** A **pointer** is a variable that stores the memory address of another
variable.
```c
int x = 10;
int *p = &x;    /* p holds the address of x */
```
`&` is the **address-of** operator (`&x` gives x's address). `*` is the
**dereference/indirection** operator (`*p` gives the value at the address, 10).

**Q82.** Memory:
```
x: [ 10 ]  at address, say, 1000
p: [1000]  → points to x
```
Output: **`10 10`**. `*p = 10` changes `x` itself to 10.

**Q83.** Pointer arithmetic moves in units of the pointed-to type, not bytes.
If `int *p = &a[0]`, then `p + 2` points to `a[2]`. On a machine where `int` is 4
bytes, `p + 1` moves **4 bytes** (one integer) forward.

**Q84.** An array name acts like a pointer to its first element. For `int a[5]`,
`a` is equivalent to `&a[0]`, and `a[i]` is defined as `*(a + i)`. So
`a[2]` and `*(a + 2)` are the same value, and `&a[2]` equals `a + 2`. Arrays are not
pointers, but they decay to pointers when passed to functions.

**Q85.**
```c
#include <stdio.h>
void swap(int *a, int *b)
{
    int temp = *a;
    *a = *b;
    *b = temp;
}
int main(void)
{
    int x = 3, y = 8;
    swap(&x, &y);
    printf("x = %d, y = %d\n", x, y);   /* x = 8, y = 3 */
    return 0;
}
```
Call by value alone passes copies, so swapping the copies leaves the originals
unchanged. Passing addresses lets the function modify the original variables.

**Q86.**
- `malloc(size)` allocates `size` bytes, uninitialised, returns `void *` (or `NULL`).
- `calloc(n, size)` allocates `n × size` bytes and initialises them to zero.
- `realloc(ptr, newSize)` resizes a previously allocated block.
- `free(ptr)` releases the memory.

```c
#include <stdio.h>
#include <stdlib.h>
int main(void)
{
    int *a = malloc(5 * sizeof(int));
    if (a == NULL) { printf("Allocation failed\n"); return 1; }

    for (int i = 0; i < 5; i++) a[i] = i * i;
    for (int i = 0; i < 5; i++) printf("%d ", a[i]);

    free(a);
    a = NULL;
    return 0;
}
```

---

## Section J — Structures, unions, files and formatting

**Q87.** A **structure** is a user-defined data type that groups variables of
**different** types under one name.
```c
struct Student {
    char name[50];
    int age;
    float marks;
};

struct Student s1 = {"Alice", 20, 78.5};
```

**Q88.**
```c
#include <stdio.h>
struct Student {
    char name[50];
    int age;
    float marks;
};

int main(void)
{
    struct Student s[3];
    int i, best = 0;

    for (i = 0; i < 3; i++) {
        printf("Student %d name: ", i + 1);
        scanf("%49s", s[i].name);
        printf("Age and marks: ");
        scanf("%d %f", &s[i].age, &s[i].marks);
    }

    for (i = 1; i < 3; i++)
        if (s[i].marks > s[best].marks) best = i;

    printf("Best: %s (%.2f)\n", s[best].name, s[best].marks);
    return 0;
}
```

**Q89.** `typedef` creates an alias for a type, so you can write `Student` instead of
`struct Student`.
```c
typedef struct { char name[50]; int age; } Student;
Student s1;
```
The `->` operator accesses a member through a **pointer to a structure**.
`(*p).name` is written as `p->name`.

**Q90.**
| Structure | Union |
|---|---|
| Members have separate memory | All members share the same memory |
| Size ≥ sum of member sizes (+ padding) | Size = size of the largest member |
| All members can be used at once | Only one member is valid at a time |
| `struct` keyword | `union` keyword |

**Q91.** An **enumeration** is a user-defined type consisting of named integer
constants.
```c
enum Day { MON, TUE, WED, THU, FRI };
enum Day today = WED;   /* WED == 2 */
```
Advantage: makes code readable and restricts a variable to a set of named values.

**Q92.**
1. Declare a file pointer: `FILE *fp;`
2. Open: `fp = fopen("data.txt", "w");` and check for `NULL`.
3. Read/write: `fprintf`, `fscanf`, `fgets`, `fputc`, `fgetc`.
4. Close: `fclose(fp);`.

Modes: `"r"` read, `"w"` write (creates/erases), `"a"` append, `"r+"` read/update,
`"w+"` write/read, `"a+"` append/read.

**Q93.**
```c
#include <stdio.h>
struct Student { char name[50]; int age; float marks; };

int main(void)
{
    struct Student s[3] = {
        {"Alice", 20, 78.5},
        {"Brian", 21, 65.0},
        {"Carol", 19, 88.0}
    };
    struct Student temp;
    FILE *fp;
    int i;

    fp = fopen("students.txt", "w");
    if (fp == NULL) { printf("Cannot open file\n"); return 1; }
    for (i = 0; i < 3; i++)
        fprintf(fp, "%s %d %.2f\n", s[i].name, s[i].age, s[i].marks);
    fclose(fp);

    fp = fopen("students.txt", "r");
    if (fp == NULL) { printf("Cannot open file\n"); return 1; }
    printf("%-10s %5s %8s\n", "Name", "Age", "Marks");
    while (fscanf(fp, "%49s %d %f", temp.name, &temp.age, &temp.marks) == 3)
        printf("%-10s %5d %8.2f\n", temp.name, temp.age, temp.marks);
    fclose(fp);
    return 0;
}
```

**Q94.**
```
[   42]
[42   ]
[00042]
[3.14]
[    3.14]
[Hel]
```
(`%5d` = width 5; `%-5d` = left-aligned; `%05d` = zero-padded; `%.2f` = 2 decimal
places; `%8.2f` = width 8 with 2 decimals; `%.3s` = first 3 characters.)

**Q95.** Four common mistakes:
1. **Missing `&`** in `scanf("%d", x);` → use `scanf("%d", &x);` (arrays are the
   exception).
2. **Using `%f` for a `double`** in `scanf` → use `%lf`.
3. **`%c` reading leftover whitespace/newline** → write `scanf(" %c", &ch);` with a
   leading space.
4. **No width limit for `%s`** causing buffer overflow → use `scanf("%49s", name);`
   for a 50-byte array.
5. Also: wrong specifier/type mismatch, and forgetting that `scanf` stops at
   whitespace.

**Q96.**
```c
printf("%-15s %5s %12s\n", "Name", "Age", "Fee");
printf("%-15s %5s %12s\n", "---------------", "-----", "------------");
printf("%-15s %5d %12.2f\n", "Alice", 20, 45000.50);
printf("%-15s %5d %12.2f\n", "Brian", 21, 52000.00);
```
Output:
```
Name              Age          Fee
--------------- ----- ------------
Alice              20     45000.50
Brian              21     52000.00
```
Use `-` for left alignment, a width for each column, and `.2f` for money.

---

## Scoring guide

| Score | Meaning | What to do |
|---|---|---|
| 80–100% | Strong | Move to timed mock exams |
| 60–79% | Pass level | Review wrong answers and re-test in 2 days |
| 40–59% | Fragile | Re-read the matching note sections today |
| Below 40% | Not yet | Do the note's self-test first, then retry |
