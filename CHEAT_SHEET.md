# CSC 112 / STA 121 — C Cheat Sheet

> One-page-ish reference for the last day. If you learn nothing else, learn this.

---

## 1. Definitions in one line

| Term | Definition |
|---|---|
| Program | Finite set of sequenced instructions to perform a task |
| Algorithm | Finite, unambiguous step-by-step solution to a problem |
| Compiler | Translates the whole program to object code at once |
| Interpreter | Translates and executes one statement at a time |
| Syntax error | Grammar violation; caught by compiler; program will not compile |
| Runtime error | Occurs during execution (e.g., divide by zero) |
| Logical error | Compiles and runs but gives wrong output |

**Good program:** correct, reliable, portable, efficient, simple, readable, maintainable, robust.

**Development phases:** problem definition → algorithm → design → coding → compilation → testing/debugging → documentation → maintenance.

**Compilation pipeline:** `.c` → preprocessor → compiler → assembler → `.o` → linker → `.exe` → loader → run.

---

## 2. Skeleton of a C program

```c
#include <stdio.h>
#define PI 3.14159

int main(void)
{
    int x = 0;

    printf("Enter x: ");
    scanf("%d", &x);
    printf("x = %d\n", x);

    return 0;
}
```

- C is case-sensitive.
- Statements end with `;`.
- `#include` and `#define` have **no** semicolon.
- `main` returns `int`; `return 0;` means success.
- Comments: `/* ... */` (no nesting) or `// ...`.

---

## 3. Data types

| Type | Size (typical) | Specifier | Example |
|---|---|---|---|
| `char` | 1 | `%c` | `'A'` |
| `short` | 2 | `%hd` | `100` |
| `int` | 4 | `%d` | `42` |
| `unsigned int` | 4 | `%u` | `42u` |
| `long` | 4/8 | `%ld` | `42L` |
| `long long` | 8 | `%lld` | `42LL` |
| `float` | 4 | `%f` | `3.14f` |
| `double` | 8 | `%lf` (scanf) / `%f` (printf) | `3.14` |
| `char[]` (string) | n+1 | `%s` | `"Hello"` |

**Ranges:** 8-bit unsigned 0…255; 8-bit signed −128…127; 16-bit signed −32,768…32,767; 32-bit signed −2,147,483,648…2,147,483,647.

**ASCII:** `'0'`=48, `'A'`=65, `'a'`=97, space=32, `'\n'`=10, `'\0'`=0. Lowercase − uppercase = 32.

**Two's complement:** invert bits + 1. `-5` in 8 bits = `11111011`.

**Casting:** `(float)a / b`; `(int)3.9` = 3.

---

## 4. Operators

| Group | Operators |
|---|---|
| Arithmetic | `+ - * / %` |
| Relational | `== != > < >= <=` |
| Logical | `&& \|\| !` |
| Bitwise | `& \| ^ ~ << >>` |
| Assignment | `= += -= *= /= %= &= \|= ^= <<= >>=` |
| Inc/dec | `++ --` |
| Conditional | `?:` |
| Other | `sizeof`, `&`, `*`, `.`, `->`, `,`, `(type)` |

**Integer division:** `7/2 = 3`; `7/2.0 = 3.5`; `7%2 = 1`. `%` only for integers.

**Precedence (high → low):**

```
() [] . ->  ++ -- (postfix)
unary + - ! ~ ++ -- * & sizeof (type)
* / %
+ -
<< >>
< <= > >=
== !=
&
^
|
&&
||
?:
= += -= ...        (right-associative)
,                  (lowest)
```

**Prefix vs postfix:** `a=5; b=a++;` → b=5, a=6. `a=5; b=++a;` → a=6, b=6.

**Short-circuit:** `a && b` skips `b` if `a` is false; `a || b` skips `b` if `a` is true.

**Bitwise examples:** `5 & 3 = 1`, `5 | 3 = 7`, `5 ^ 3 = 6`, `~5 = -6`, `5 << 1 = 10`, `5 >> 1 = 2`.

---

## 5. Selection

```c
if (condition) { ... }

if (condition) { ... } else { ... }

if (condition1) { ... }
else if (condition2) { ... }
else { ... }

switch (integer_or_char_expression)
{
    case 1: ...; break;
    case 2: ...; break;
    default: ...;
}
```

- `=` assigns; `==` compares.
- No semicolon after `if (...)`.
- `switch` works on `int`/`char`/`enum`, not `float`/string.
- Missing `break` → fall-through.
- `?:` → `y = (x > 5) ? 1 : 0;`

---

## 6. Loops

```c
while (condition) { ... }

do { ... } while (condition);

for (initialise; condition; update) { ... }
```

- `while`: may run 0 times; entry-controlled.
- `do-while`: runs at least once; exit-controlled; needs `;`.
- `for`: know the count; all three parts on one line.

**Control:**

- `break` — exit loop/switch.
- `continue` — skip to next iteration.
- `goto label;` — jump (avoid).

**Nested loop:** inner loop finishes for each outer iteration.

**Classic patterns:**

```c
/* sum 1..n */
sum = 0;
for (i = 1; i <= n; i++) sum += i;

/* factorial */
fact = 1;
for (i = 1; i <= n; i++) fact *= i;

/* reverse digits */
rev = 0;
while (n != 0) { rev = rev * 10 + n % 10; n /= 10; }

/* count digits */
count = 0;
do { n /= 10; count++; } while (n != 0);

/* prime */
is_prime = 1;
if (n <= 1) is_prime = 0;
for (i = 2; i * i <= n; i++)
    if (n % i == 0) { is_prime = 0; break; }

/* star triangle */
for (i = 1; i <= n; i++) {
    for (j = 1; j <= i; j++) printf("*");
    printf("\n");
}
```

---

## 7. Functions

```c
/* prototype */
int add(int a, int b);

/* definition */
int add(int a, int b)
{
    return a + b;
}

/* call */
int s = add(3, 4);
```

- Four categories: no args/no return, no args/return, args/no return, args/return.
- Actual arguments in the call; formal parameters in the definition.
- C is **call by value**; use pointers for call by reference.
- Arrays decay to pointers; pass the length too.
- Local variables die at block end; `static` locals persist.

**Recursion:** base case + recursive case.

```c
long long fact(int n)
{
    if (n <= 1) return 1;
    return n * fact(n - 1);
}
```

**Call by reference swap:**

```c
void swap(int *a, int *b)
{
    int t = *a; *a = *b; *b = t;
}
swap(&x, &y);
```

---

## 8. Arrays and strings

```c
int a[5];                          /* indices 0..4 */
int b[5] = {1, 2, 3, 4, 5};
int c[] = {1, 2, 3};               /* size 3 */
int m[3][4];                       /* 3 rows, 4 columns */
int m2[2][3] = {{1,2,3}, {4,5,6}};
```

- No bounds checking.
- `sizeof(a)/sizeof(a[0])` = number of elements.
- 2D stored row by row; nested loops to process.
- Pass arrays: `void f(int a[], int n)`; no `&`.
- 2D parameter needs columns: `void f(int a[][4], int rows)`.

**Strings:**

```c
char s[] = "Hello";                /* 6 bytes incl. '\0' */
char t[20];
strcpy(t, s);
strcat(t, " World");
int len = strlen(t);               /* excludes '\0' */
if (strcmp(s, t) == 0) ...         /* never use == */
fgets(t, sizeof(t), stdin);        /* reads a line */
scanf("%19s", t);                  /* reads one word */
printf("%s\n", t);
```

**String functions (`<string.h>`):** `strlen`, `strcpy`, `strncpy`, `strcat`, `strncat`, `strcmp`, `strncmp`, `strchr`, `strstr`.

---

## 9. Pointers

```c
int x = 10;
int *p = &x;        /* p stores address of x */
printf("%d", *p);   /* 10 */
*p = 20;            /* x becomes 20 */
```

- `&` = address-of; `*` = dereference.
- `p + 1` moves by `sizeof(*p)` bytes.
- `a[i] ≡ *(a + i)`; `&a[i] ≡ a + i`.
- `*p++` = read then move; `(*p)++` = increment value.
- `NULL` = points to nothing; never dereference.
- Arrays decay to pointers when passed.
- `malloc(n * sizeof(int))`, `calloc(n, sizeof(int))`, `realloc`, `free`; check for `NULL`.

---

## 10. Structures, unions, files

```c
typedef struct
{
    char name[50];
    int age;
    float fee;
} Student;

Student s = {"Alice", 20, 45000.50};
Student *p = &s;
printf("%s", p->name);          /* p->name == (*p).name */
```

- `.` for a struct variable; `->` for a pointer.
- Array of structs: `Student list[30];`
- Struct size may include padding.
- `union` members share memory; size = largest member; one active member.
- `enum` = named integer constants.

**Files:**

```c
FILE *fp = fopen("data.txt", "r");
if (fp == NULL) { /* error */ }

fprintf(fp, "%s %d\n", name, age);
fscanf(fp, "%s %d", name, &age);
fgets(line, sizeof(line), fp);
fgetc(fp); fputc(c, fp);
fclose(fp);
```

**Modes:** `"r"` read, `"w"` write (erases), `"a"` append, `"r+"`, `"w+"`, `"a+"`, `"rb"`, `"wb"`.

---

## 11. Formatted I/O

```
%[flags][width][.precision][length]specifier
```

| Example | Output |
|---|---|
| `printf("%6d", 42)` | `    42` |
| `printf("%-6d|", 42)` | `42    |` |
| `printf("%06d", 42)` | `000042` |
| `printf("%.2f", 3.14159)` | `3.14` |
| `printf("%10.2f", 3.14159)` | `      3.14` |
| `printf("%.3s", "Hello")` | `Hel` |
| `printf("%5s", "Hi")` | `   Hi` |
| `printf("%x", 255)` | `ff` |
| `printf("%o", 8)` | `10` |
| `printf("%%")` | `%` |

**`scanf`:** needs `&` except arrays; `%lf` for `double`; `" %c"` to skip whitespace; `%19s` to limit strings.

---

## 12. Common errors checklist

- [ ] Missing semicolon
- [ ] Missing `&` in `scanf`
- [ ] `=` instead of `==`
- [ ] Semicolon after `if`, `for`, `while`
- [ ] Missing braces
- [ ] Uninitialised variable
- [ ] Integer division when float needed
- [ ] `%` with float
- [ ] Wrong format specifier
- [ ] Array index out of bounds
- [ ] Missing `'\0'` in a string
- [ ] Missing `break` in `switch`
- [ ] Infinite loop (no update)
- [ ] Comparing strings with `==`
- [ ] Missing `return 0;`
- [ ] Missing `;` after `struct`/`do-while`
- [ ] Not checking `fopen` for `NULL`
- [ ] Missing `fclose`
- [ ] Recursion without a base case
- [ ] Dereferencing an uninitialised pointer

---

## 13. Exam quick recipe

**Trace code:** draw a table of variables; update row by row; watch `++`, `/`, `%`, loop bounds.

**Write code:**

1. IPO: input → processing → output.
2. Declare variables with sensible types.
3. Read input (`scanf`, `&`).
4. Compute.
5. Print (`printf`, labels, `\n`).
6. `return 0;`.

**If stuck in an exam:** write the structure, declarations, input and output — partial marks are real marks.
