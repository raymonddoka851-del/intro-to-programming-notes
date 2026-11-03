# Note 11 — Formatted Input/Output and Report Design

> **Covers the "report and display design" part of the course description** and the formatted I/O material in your Week 4 notes.

---

## 1. Why formatting matters

The default output of `printf` is often ugly:

```c
printf("%f\n", 3.14159);      /* 3.141590 */
printf("%d\n", 7);            /* 7 */
```

Formatting lets you control:

- how many decimal places are shown,
- how wide a column is,
- whether numbers are left- or right-aligned,
- whether to show `+` signs, leading zeros, or hexadecimal,
- how a report or table looks.

---

## 2. The `printf` function

### 2.1 General form

```c
printf("control string", argument1, argument2, ...);
```

The control string contains:

1. **Literal text** — printed as-is.
2. **Format specifiers** — start with `%`, e.g. `%d`.
3. **Escape sequences** — start with `\`, e.g. `\n`, `\t`.

### 2.2 Format specifier syntax

```
%[flags][width][.precision][length]specifier
```

| Part | Meaning | Example |
|---|---|---|
| `%` | Start of specifier | `%` |
| **flags** | `-` left-align, `+` show sign, `0` pad with zeros, space, `#` | `%-8d` |
| **width** | Minimum number of characters | `%8d` |
| **.precision** | Decimal places (float) or max characters (string) | `%.2f` |
| **length** | `h`, `l`, `ll`, `L` | `%ld`, `%lf` |
| **specifier** | Type of value | `d`, `f`, `s`, `c` |

### 2.3 Specifier table

| Specifier | Type | Example | Output |
|---|---|---|---|
| `%d` / `%i` | Signed decimal integer | `printf("%d", 42)` | `42` |
| `%u` | Unsigned decimal integer | `printf("%u", 42u)` | `42` |
| `%o` | Octal integer | `printf("%o", 8)` | `10` |
| `%x` / `%X` | Hexadecimal (lower/upper) | `printf("%x", 255)` | `ff` |
| `%f` | Floating point (decimal) | `printf("%f", 3.14)` | `3.140000` |
| `%e` / `%E` | Scientific notation | `printf("%e", 314.0)` | `3.140000e+02` |
| `%g` / `%G` | Shorter of `%f` and `%e` | `printf("%g", 0.0001)` | `0.0001` |
| `%c` | Single character | `printf("%c", 'A')` | `A` |
| `%s` | String | `printf("%s", "Hi")` | `Hi` |
| `%p` | Pointer address | `printf("%p", (void*)&x)` | `0x...` |
| `%%` | A literal percent sign | `printf("100%%")` | `100%` |
| `%zu` | `sizeof` result (`size_t`) | `printf("%zu", sizeof(int))` | `4` |

### 2.4 Width and alignment

```c
printf("|%6d|\n", 9876);      /* |  9876|  right-aligned in 6 columns */
printf("|%-6d|\n", 9876);     /* |9876  |  left-aligned */
printf("|%06d|\n", 9876);     /* |009876|  zero-padded */
printf("|%3d|\n", 9876);      /* |9876|    too narrow: expands, does not truncate */
```

### 2.5 Precision

```c
printf("%.2f\n", 987.6543);   /* 987.65  (rounded) */
printf("%.0f\n", 987.6543);   /* 988     (0 decimal places) */
printf("%.f\n", 987.6543);    /* 988     (same as .0) */
printf("%10.3f\n", 3.14159);  /*     3.142 (width 10, 3 decimals) */
printf("%-10.2f|\n", 3.14);   /* 3.14      | (left-aligned) */
printf("%.3s\n", "Hello");    /* Hel     (max 3 characters) */
printf("%8s\n", "Hi");        /*       Hi (right-aligned in 8) */
```

### 2.6 Flags

| Flag | Meaning | Example | Output |
|---|---|---|---|
| `-` | Left-align | `%-5d` | `42   ` |
| `+` | Always show sign | `%+d` | `+42` |
| `0` | Pad with zeros | `%05d` | `00042` |
| space | Show space for positive | `% d` | ` 42` |
| `#` | Alternate form (`0x`, leading `0`) | `%#x` | `0x2a` |

```c
printf("%+d %+d\n", 5, -5);       /* +5 -5 */
printf("%#x %#o\n", 42, 42);      /* 0x2a 052 */
printf("%08.2f\n", 3.14159);      /* 00003.14 */
```

### 2.7 Argument mismatch

The number and type of arguments must match the format specifiers.

```c
printf("%d %d\n", 1);             /* missing argument — undefined */
printf("%d\n", 3.5);              /* wrong type — undefined */
printf("%f\n", 5);                /* wrong type — undefined */
```

The compiler may warn, but C does not check at runtime. **Always match the specifier to the type.**

---

## 3. The `scanf` function

### 3.1 General form

```c
scanf("control string", &variable1, &variable2, ...);
```

- `&` gives the address where the value should be stored.
- **Exception:** array/string names already represent addresses, so no `&`.

### 3.2 Reading multiple values

```c
int a, b;
scanf("%d %d", &a, &b);
```

Input can be separated by spaces, tabs or newlines.

### 3.3 Return value

`scanf` returns the **number of items successfully read**.

```c
int n = scanf("%d %d", &a, &b);
if (n != 2)
    printf("Invalid input\n");
```

- `0` = no items matched.
- `EOF` = end of input.

Always check when input reliability matters.

### 3.4 Whitespace and `%c`

`%d`, `%f`, `%s` skip leading whitespace automatically. **`%c` does not.**

```c
char ch;
scanf("%c", &ch);       /* may read a leftover newline */
scanf(" %c", &ch);      /* the space skips whitespace — usually what you want */
```

### 3.5 Reading strings

```c
char name[20];
scanf("%19s", name);    /* reads one word, max 19 chars; no & */
```

`scanf("%s")` **stops at the first whitespace**. To read a full line, use `fgets`:

```c
char line[100];
fgets(line, sizeof(line), stdin);
```

### 3.6 Width limits

```c
scanf("%3d", &n);       /* reads at most 3 digits */
scanf("%9s", name);     /* reads at most 9 characters — prevents overflow */
```

### 3.7 Character sets

```c
char line[100];
scanf("%[^\n]", line);   /* read until newline (spaces included) */
scanf("%[0-9]", digits); /* read only digits */
```

> `%[^\n]` is powerful but does not limit the buffer size; prefer `fgets` in real code.

### 3.8 Suppression

```c
int day, year;
scanf("%d/%*d/%d", &day, &year);   /* skip the month */
```

### 3.9 Common `scanf` problems

```c
int x;
scanf("%d", x);          /* WRONG: missing & */
scanf("%d", &x);         /* correct */

float f;
scanf("%f", &f);         /* correct for float */

double d;
scanf("%lf", &d);        /* correct for double: %lf */

char s[20];
scanf("%s", &s);         /* WRONG type: s is already an address */
scanf("%s", s);          /* correct */
```

### 3.10 Leftover newline problem

```c
int age;
char name[50];

printf("Age: ");
scanf("%d", &age);
printf("Name: ");
fgets(name, sizeof(name), stdin);   /* may read the leftover '\n' and appear empty */
```

**Fix:** consume the newline first:

```c
while (getchar() != '\n');          /* discard rest of line */
fgets(name, sizeof(name), stdin);
```

Or use `scanf(" %[^\n]", name);` (note the leading space).

---

## 4. Character input/output

| Function | Purpose |
|---|---|
| `getchar()` | Read one character from stdin |
| `putchar(c)` | Write one character to stdout |
| `gets(s)` | **Unsafe, removed** — never use |
| `fgets(s, n, stdin)` | Read a line safely |
| `puts(s)` | Print a string followed by newline |

```c
int ch;
while ((ch = getchar()) != '\n' && ch != EOF)
    putchar(ch);
```

**Why `int ch`, not `char ch`?** Because `getchar` returns `EOF` (usually −1), which may not fit in an unsigned `char`.

---

## 5. Report and display design

A **report** presents information clearly to a user. Good reports are:

1. **Accurate** — correct data and calculations.
2. **Clear** — headings, spacing and alignment.
3. **Consistent** — same number of decimal places, same date/currency format.
4. **Complete** — totals, subtotals, titles, date, page numbers.
5. **Readable** — not overcrowded; use white space and lines.
6. **Appropriate** — suitable for the audience (management summary vs detailed list).
7. **Error-aware** — handles missing or invalid data.

### 5.1 A simple tabular report

```c
#include <stdio.h>

int main(void)
{
    printf("==============================================\n");
    printf("           STUDENT FEE REPORT\n");
    printf("           Date: 2026-11-04\n");
    printf("==============================================\n");
    printf("%-5s %-15s %5s %12s\n", "No.", "Name", "Age", "Fee (KSh)");
    printf("----------------------------------------------\n");
    printf("%-5d %-15s %5d %12.2f\n", 1, "Alice", 20, 45000.50);
    printf("%-5d %-15s %5d %12.2f\n", 2, "Bob",   21, 42000.00);
    printf("%-5d %-15s %5d %12.2f\n", 3, "Carol", 19, 47000.75);
    printf("----------------------------------------------\n");
    printf("%-5s %-15s %5s %12.2f\n", "", "TOTAL", "", 134043.25);
    printf("==============================================\n");
    return 0;
}
```

**Output**

```
==============================================
           STUDENT FEE REPORT
           Date: 2026-11-04
==============================================
No.   Name              Age   Fee (KSh)
----------------------------------------------
1     Alice              20     45000.50
2     Bob                21     42000.00
3     Carol              19     47000.75
----------------------------------------------
      TOTAL                       134043.25
==============================================
```

### 5.2 Design principles in practice

- Use `%-15s` for left-aligned names and `%10.2f` for right-aligned money.
- Keep a **fixed number of decimal places** for money (usually 2).
- Right-align numbers; left-align text.
- Include a title, date, column headings, totals and a footer.
- Use separators (`-`, `=`) to guide the eye.
- Do not print raw variable names; use meaningful labels.
- Test with zero, negative, very large and missing values.

### 5.3 A menu display

```c
printf("\n========== MAIN MENU ==========\n");
printf("1. Add student\n");
printf("2. View students\n");
printf("3. Search student\n");
printf("4. Delete student\n");
printf("0. Exit\n");
printf("================================\n");
printf("Enter choice: ");
```

### 5.4 Error messages

Good:

```
Error: score must be between 0 and 100.
```

Bad:

```
Error!
```

Good messages state **what went wrong** and **what to do**.

---

## 6. Worked exam questions

### 6.1 "What is the output?"

```c
printf("|%5d|%-5d|%05d|\n", 42, 42, 42);
```

**Output:** `|   42|42   |00042|`

### 6.2 "What is the output?"

```c
printf("%.2f %.0f %.3s\n", 3.14159, 3.14159, "Hello");
```

**Output:** `3.14 3 Hel`

### 6.3 "What is the output?"

```c
int x = 255;
printf("%d %o %x %X\n", x, x, x, x);
```

**Output:** `255 377 ff FF`

### 6.4 "What is wrong?"

```c
double d;
scanf("%f", &d);
printf("%d\n", d);
```

**Errors:** `%f` in `scanf` is for `float`, not `double` — use `%lf`. `%d` in `printf` is for `int`, not `double` — use `%f` or `%lf`.

### 6.5 "Design the output for an invoice."

```c
#include <stdio.h>

int main(void)
{
    const float price = 250.00f;
    int qty = 4;
    float subtotal = price * qty;
    float vat = subtotal * 0.16f;
    float total = subtotal + vat;

    printf("========================================\n");
    printf("              INVOICE\n");
    printf("========================================\n");
    printf("%-20s %10s\n", "Item", "Amount");
    printf("----------------------------------------\n");
    printf("%-20s %10.2f\n", "Exercise book", subtotal);
    printf("%-20s %10.2f\n", "VAT (16%)", vat);
    printf("----------------------------------------\n");
    printf("%-20s %10.2f\n", "TOTAL", total);
    printf("========================================\n");
    return 0;
}
```

---

## 7. Common errors

| Error | Problem | Fix |
|---|---|---|
| `printf("%d", 3.5)` | Wrong specifier | `%f` |
| `scanf("%f", &d)` where `d` is `double` | Wrong specifier | `%lf` |
| `scanf("%d", x)` | Missing `&` | `&x` |
| `scanf("%s", &s)` | Array already an address | `s` |
| `%c` after `%d` | Reads leftover newline | `" %c"` |
| `%s` expecting spaces | `%s` stops at whitespace | `fgets` or `%[^\n]` |
| No width on `%s` input | Buffer overflow | `%19s` |
| `printf("%d", sizeof(x))` | `sizeof` returns `size_t` | `%zu` |
| Too few/many arguments | Undefined behaviour | Match counts |
| Inconsistent decimals | Ugly report | Use `%.2f` everywhere for money |
| No `\n` at end | Output runs together | Add `\n` |
| `gets` | Unsafe | `fgets` |

---

## 8. Rapid revision

- `printf("%[flags][width][.precision][length]specifier", value)`
- `%d` int, `%f` float/double, `%lf` double in `scanf`, `%c` char, `%s` string, `%x` hex, `%o` octal, `%u` unsigned, `%zu` size.
- `%6d` right-align in 6; `%-6d` left-align; `%06d` zero-pad.
- `%.2f` two decimal places; `%.3s` first three characters.
- `scanf` needs `&` except for arrays/strings.
- `%c` does not skip whitespace; use `" %c"`.
- `%s` stops at whitespace; use `fgets` for lines.
- Check `scanf`'s return value for valid input.
- Reports: title, headings, aligned columns, consistent decimals, totals, separators, clear errors.

---

## 9. Self-test (answers below)

1. What is the general syntax of a format specifier?
2. What is the output of `printf("|%7.2f|", 3.14159);`?
3. What is the output of `printf("|%-7d|", 42);`?
4. What is the output of `printf("|%07d|", 42);`?
5. What is the output of `printf("%x %o %c", 255, 8, 65);`?
6. What does `scanf` return?
7. Why does `scanf("%d", x);` fail?
8. Why is `%c` different from `%d` regarding whitespace?
9. How do you read a full line containing spaces?
10. How do you safely read a name into `char name[20]`?
11. What is the difference between `%f` and `%lf` in `scanf`?
12. Design a formatted report for 3 products with price and quantity, including a total.
13. What is wrong?
    ```c
    double d;
    scanf("%f", &d);
    printf("%d", d);
    ```
14. Why is `gets` dangerous?
15. What is the output?
    ```c
    printf("%5.1f|%-5.1f|", 2.345, 2.345);
    ```

### Answers

1. `%[flags][width][.precision][length]specifier`
2. `|   3.14|` — width 7, 2 decimals.
3. `|42     |` — left-aligned in 7.
4. `|0000042|` — zero-padded to 7.
5. `ff 10 A`.
6. The number of items successfully read (or `EOF`).
7. Missing `&`; `scanf` needs the address of `x`.
8. `%d` skips leading whitespace; `%c` reads the very next character, including a space or newline.
9. `fgets(line, sizeof(line), stdin);` (or `scanf(" %[^\n]", line);`).
10. `scanf("%19s", name);` (no `&`).
11. `%f` is for `float`; `%lf` is for `double` in `scanf`. In `printf`, `%f` works for both because `float` is promoted to `double`.
12. See §5.1/§6.5.
13. `%f` should be `%lf` for a `double` in `scanf`; `%d` should be `%f` in `printf`.
14. It does not check the buffer size, so long input overflows the array and can crash or be exploited.
15. `  2.3|2.3  |` — first is width 5 right-aligned, second is width 5 left-aligned, both rounded to 1 decimal.

---

**Next:** `CHEAT_SHEET.md`, then the practice folder.
