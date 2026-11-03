# Mock Examination 2 — Marking Scheme

**Total: 70 marks**

> Award marks for correct reasoning even if the final line has a small slip.
> In programs, do not penalise the same error twice.

---

## Section A — Multiple choice (15 marks)

| Q | Answer | Q | Answer | Q | Answer |
|---|---|---|---|---|---|
| 1 | C | 6 | C | 11 | B |
| 2 | C | 7 | A | 12 | B |
| 3 | C | 8 | B | 13 | B |
| 4 | B | 9 | C | 14 | B |
| 5 | B | 10 | B | 15 | B |

**1 mark each.**

---

## Section B — Short answers (15 marks)

### B16 (3 marks)
Any **four** characteristics, ½ mark each (max 2), plus 1 mark for explaining one:
correctness, reliability, portability, efficiency, clarity, readability, maintainability, robustness, usability, cost-effectiveness.

Example explanation: "Correctness means the program produces the expected output for every valid input; without it, the other qualities do not matter."

### B17 (3 marks)
- **Preprocessor:** expands `#include`/`#define`, removes comments.
- **Compiler:** translates C into assembly/object code and reports syntax errors.
- **Assembler:** converts assembly into machine-language object code.
- **Linker:** joins object files and library code into one executable.
- **Loader:** loads the executable into RAM and starts execution.

Award 1 mark for each correct stage, up to 3, provided the order is correct.

### B18 (3 marks)
- `while` is **entry-controlled**: it tests the condition before the body, so the body may run **zero** times. *(1)*
- `do-while` is **exit-controlled**: it tests after the body, so the body runs **at least once**. *(1)*
- `do-while` is better for a menu that must be displayed before the user can choose Exit. *(1)*

### B19 (3 marks)
An array is a **fixed-size collection of elements of the same type**, stored contiguously and accessed by index. *(1)*
Any **three** properties, ⅔ mark each (max 2): fixed size; same type; contiguous memory; index starts at 0; no bounds checking; name is the address of the first element.

### B20 (3 marks)
- `#define` is handled by the **preprocessor**; it performs textual substitution, has no type and no semicolon. Example: `#define PI 3.14`. *(1½)*
- `const` declares a **typed read-only variable** checked by the compiler, with normal scope. Example: `const double pi = 3.14;`. *(1½)*

---

## Section C — Trace and debug (20 marks)

### C21 (5 marks)
Output (spaces shown):
```text
   1
  222
 33333
4444444
```
Row `i` has `4 − i` spaces, then `2i − 1` copies of digit `i`.
Marks: one per correct row (4), plus 1 for correct spacing/structure.

### C22 (5 marks)
Output:
```text
15
6
```
- `sum(a,5) = 5 + 4 + 3 + 2 + 1 = 15`.
- `sum(a,3) = 3 + 2 + 1 = 6`.
- Base case `n == 0` returns 0.

Marks: 15 (2), 6 (2), base case/trace (1).

### C23 (5 marks)
Output:
```text
CExam
5
x
```
- The loop prints each character until `'\0'`.
- `p - s` is the number of characters advanced = **5** (pointer difference).
- `*(s + 2)` is `s[2]`: `s[0]='C'`, `s[1]='E'`, `s[2]='x'`, so the answer is **`x`**.

Marks: `CExam` (2), `5` (2), `x` (1).

### C24 (5 marks)
Problems (1 mark each, max 5):
1. `sum` is **not initialised** before `sum += a[i]`.
2. The input loop uses `i <= n`, so it writes `a[n]`, which is **out of bounds**; use `i < n`.
3. There is **no validation** of `n`; if `n == 0`, `sum / n` divides by zero.
4. `printf("%d", average)` uses the **wrong format** for a `float`; use `%f` or `%.2f`.
5. The return value of `scanf` is not checked, so bad input is not detected.

(C99 permits `int a[n];`, so do not count the VLA itself as an error. If a candidate mentions C89 portability, accept it as a bonus but not as one of the five.)

Corrected:
```c
#include <stdio.h>

int main(void)
{
    int n, i;
    float sum = 0.0f, average;

    printf("How many? ");
    if (scanf("%d", &n) != 1 || n <= 0)
    {
        printf("Invalid count\n");
        return 1;
    }

    int a[n];

    for (i = 0; i < n; i++)
        scanf("%d", &a[i]);

    for (i = 0; i < n; i++)
        sum += a[i];

    average = sum / n;
    printf("Average = %.2f\n", average);

    return 0;
}
```

---

## Section D — Programs (20 marks)

### D25 — Text analyzer (10 marks)

```c
#include <stdio.h>
#include <string.h>
#include <ctype.h>

void analyze(const char *s, int *chars, int *vowels,
             int *consonants, int *digits, int *spaces);

int main(void)
{
    char line[200];
    int chars, vowels, consonants, digits, spaces;

    printf("Enter a line: ");
    if (fgets(line, sizeof(line), stdin) == NULL)
        return 1;

    line[strcspn(line, "\n")] = '\0';

    analyze(line, &chars, &vowels, &consonants, &digits, &spaces);

    printf("Characters : %d\n", chars);
    printf("Vowels     : %d\n", vowels);
    printf("Consonants : %d\n", consonants);
    printf("Digits     : %d\n", digits);
    printf("Spaces     : %d\n", spaces);

    return 0;
}

void analyze(const char *s, int *chars, int *vowels,
             int *consonants, int *digits, int *spaces)
{
    int i;

    *chars = *vowels = *consonants = *digits = *spaces = 0;

    for (i = 0; s[i] != '\0'; i++)
    {
        unsigned char c = (unsigned char)s[i];
        (*chars)++;

        if (isalpha(c))
        {
            char lower = (char)tolower(c);

            if (lower == 'a' || lower == 'e' || lower == 'i' ||
                lower == 'o' || lower == 'u')
                (*vowels)++;
            else
                (*consonants)++;
        }
        else if (isdigit(c))
        {
            (*digits)++;
        }
        else if (c == ' ')
        {
            (*spaces)++;
        }
    }
}
```

**Mark allocation**

| Item | Marks |
|---|---|
| Reads a full line with `fgets` and removes the newline | 1 |
| Correct function design (at least two functions, parameters used) | 2 |
| Counts characters correctly | 1 |
| Counts vowels correctly, case-insensitive | 2 |
| Counts consonants correctly (letters only, not vowels) | 2 |
| Counts digits and spaces | 1 |
| Labelled output | 1 |

For the sample, accept **24 characters, 3 vowels, 11 consonants, 5 digits, 4 spaces**. The `!` is counted as a character but not as a letter, digit or space.

### D26 — Employee payroll (10 marks)

```c
#include <stdio.h>

#define MAX 50

typedef struct {
    char name[30];
    float basic;
    float allowance;
    float tax;
    float net;
} Employee;

int main(void)
{
    Employee e[MAX];
    int n, i;
    float total = 0.0f;
    FILE *fp;

    printf("How many employees? ");
    if (scanf("%d", &n) != 1 || n < 1 || n > MAX)
    {
        printf("Invalid count\n");
        return 1;
    }

    for (i = 0; i < n; i++)
    {
        printf("Name and basic: ");
        if (scanf("%29s %f", e[i].name, &e[i].basic) != 2)
        {
            printf("Invalid record\n");
            return 1;
        }

        e[i].allowance = 0.20f * e[i].basic;
        e[i].tax = 0.10f * e[i].basic;
        e[i].net = e[i].basic + e[i].allowance - e[i].tax;
        total += e[i].net;
    }

    printf("\n%-12s %10s %10s %9s %10s\n",
           "NAME", "BASIC", "ALLOWANCE", "TAX", "NET");

    for (i = 0; i < n; i++)
        printf("%-12s %10.2f %10.2f %9.2f %10.2f\n",
               e[i].name, e[i].basic, e[i].allowance, e[i].tax, e[i].net);

    printf("Total net: %.2f\n", total);

    /* Write to file */
    fp = fopen("payroll.txt", "w");
    if (fp == NULL)
    {
        printf("Cannot open payroll.txt for writing\n");
        return 1;
    }

    for (i = 0; i < n; i++)
        fprintf(fp, "%s %.2f %.2f %.2f %.2f\n",
                e[i].name, e[i].basic, e[i].allowance, e[i].tax, e[i].net);

    fclose(fp);

    /* Read back */
    fp = fopen("payroll.txt", "r");
    if (fp == NULL)
    {
        printf("Cannot open payroll.txt for reading\n");
        return 1;
    }

    printf("\nRecords in payroll.txt:\n");

    while (fscanf(fp, "%29s %f %f %f %f",
                  e[0].name, &e[0].basic, &e[0].allowance,
                  &e[0].tax, &e[0].net) == 5)
    {
        printf("%-12s %10.2f %10.2f %9.2f %10.2f\n",
               e[0].name, e[0].basic, e[0].allowance, e[0].tax, e[0].net);
    }

    fclose(fp);
    return 0;
}
```

**Mark allocation**

| Item | Marks |
|---|---|
| Structure definition with all five members and `typedef` | 2 |
| Reads `n` employees correctly | 1 |
| Correct allowance, tax and net formulas | 2 |
| Formatted table with headers and aligned columns | 2 |
| Correct total net | 1 |
| Writes to `payroll.txt` and checks `fopen` | 1 |
| Reads the file back and displays records | 1 |

Accept `0.2 * basic` and `0.1 * basic`. Accept any correct order of the arithmetic. If file handling is missing, award at most 8/10.

---

## Grade boundaries (suggested)

| Mark | Grade |
|---|---|
| 60–70 | A |
| 52–59 | B |
| 45–51 | C |
| 38–44 | D |
| 32–37 | E |
| 0–31 | F |

Record your score and compare it with Mock 1. If Mock 2 is lower, identify which topic caused the drop and revisit that note.
