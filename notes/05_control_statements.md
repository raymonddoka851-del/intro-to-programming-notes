# Note 05 — Control Statements: Selection

> **Covers outline Week 7** (if, if..else, nested if). Also includes `switch`, because it is in your Week 4/6 notes and is examinable.

---

## 1. The three control structures

Every program, no matter how complex, can be built from three structures:

```
1. SEQUENCE         2. SELECTION          3. REPETITION
   statement 1         condition?             while (condition)
   statement 2        /          \               statement
   statement 3     true          false
                  block A       block B
```

This note covers **selection** (also called **branching** or **decision control**).

Selection is used when the program must **choose** between alternatives:

```c
if (weather == SUNNY)
    play_outside();
else
    stay_inside();
```

C provides:

- `if`
- `if-else`
- `else-if` ladder
- nested `if`
- `switch`
- the conditional operator `?:` (Note 04)

---

## 2. The `if` statement

### 2.1 Syntax

```c
if (condition)
{
    /* statements executed only if condition is true */
}
```

or, for a single statement, the braces are optional (but recommended):

```c
if (condition)
    statement;
```

### 2.2 How it works

1. Evaluate `condition`.
2. If the result is **non-zero** (true), execute the block.
3. If the result is **zero** (false), skip the block.

```
        ┌───────────────┐
        │   condition?  │
        └──┬─────────┬──┘
        true       false
          │          │
          ▼          ▼
   ┌────────────┐    │
   │ statements │    │
   └─────┬──────┘    │
         └─────┬─────┘
               ▼
          rest of program
```

### 2.3 Example: print a message if a number is negative

```c
#include <stdio.h>

int main(void)
{
    int number;

    printf("Enter a number: ");
    scanf("%d", &number);

    if (number < 0)
    {
        printf("The number is negative.\n");
        number = -number;          /* make it positive */
    }

    printf("Value = %d\n", number);
    return 0;
}
```

**Run 1**

```
Enter a number: 6
Value = 6
```

**Run 2**

```
Enter a number: -2
The number is negative.
Value = 2
```

### 2.4 Example: avoid division by zero

```c
#include <stdio.h>

int main(void)
{
    int a, b;
    float quotient;

    printf("Enter two integers: ");
    scanf("%d %d", &a, &b);

    if (b == 0)
    {
        printf("Division by zero is not allowed.\n");
        return 1;
    }

    quotient = (float)a / b;
    printf("Quotient = %.2f\n", quotient);
    return 0;
}
```

---

## 3. The `if-else` statement

### 3.1 Syntax

```c
if (condition)
{
    /* if block: runs when true */
}
else
{
    /* else block: runs when false */
}
```

Exactly **one** of the two blocks runs — never both, never neither.

### 3.2 Example: even or odd

```c
#include <stdio.h>

int main(void)
{
    int n;

    printf("Enter an integer: ");
    scanf("%d", &n);

    if (n % 2 == 0)
        printf("Even\n");
    else
        printf("Odd\n");

    return 0;
}
```

### 3.3 Example: largest of two numbers

```c
#include <stdio.h>

int main(void)
{
    int a, b;

    printf("Enter two numbers: ");
    scanf("%d %d", &a, &b);

    if (a > b)
        printf("%d is larger\n", a);
    else if (b > a)
        printf("%d is larger\n", b);
    else
        printf("Both are equal\n");

    return 0;
}
```

### 3.4 Example: leap year

A year is a leap year if:

- it is divisible by 4 **and not** divisible by 100, **or**
- it is divisible by 400.

```c
#include <stdio.h>

int main(void)
{
    int year;

    printf("Enter a year: ");
    scanf("%d", &year);

    if ((year % 4 == 0 && year % 100 != 0) || (year % 400 == 0))
        printf("%d is a leap year.\n", year);
    else
        printf("%d is not a leap year.\n", year);

    return 0;
}
```

**Test values:** 1996 (leap), 2000 (leap), 1900 (not leap), 2015 (not leap), 2024 (leap).

---

## 4. The `else-if` ladder

Use this when there are **several mutually exclusive alternatives**.

### 4.1 Syntax

```c
if (condition1)
{
    /* block 1 */
}
else if (condition2)
{
    /* block 2 */
}
else if (condition3)
{
    /* block 3 */
}
else
{
    /* default block */
}
```

The conditions are tested **top to bottom**. The first true condition wins; the rest are skipped.

### 4.2 Example: grade classification

```c
#include <stdio.h>

int main(void)
{
    int score;

    printf("Enter score (0-100): ");
    scanf("%d", &score);

    if (score < 0 || score > 100)
        printf("Invalid score\n");
    else if (score >= 70)
        printf("Grade A\n");
    else if (score >= 60)
        printf("Grade B\n");
    else if (score >= 50)
        printf("Grade C\n");
    else if (score >= 40)
        printf("Grade D\n");
    else
        printf("Grade F\n");

    return 0;
}
```

**Why this order?** Because `>= 70` is checked first, a score of 75 never reaches `>= 60`. If you reversed the order, everyone above 40 would get a D.

### 4.3 Example: largest of three numbers

```c
#include <stdio.h>

int main(void)
{
    int a, b, c;

    printf("Enter three numbers: ");
    scanf("%d %d %d", &a, &b, &c);

    if (a >= b && a >= c)
        printf("%d is the largest\n", a);
    else if (b >= a && b >= c)
        printf("%d is the largest\n", b);
    else
        printf("%d is the largest\n", c);

    return 0;
}
```

### 4.4 Example: character type

```c
#include <stdio.h>

int main(void)
{
    char ch;

    printf("Enter a character: ");
    scanf(" %c", &ch);          /* the space skips leftover whitespace */

    if (ch >= 'A' && ch <= 'Z')
        printf("Uppercase letter\n");
    else if (ch >= 'a' && ch <= 'z')
        printf("Lowercase letter\n");
    else if (ch >= '0' && ch <= '9')
        printf("Digit\n");
    else
        printf("Other character\n");

    return 0;
}
```

---

## 5. Nested `if`

An `if` (or `if-else`) placed **inside** another `if` or `else` block.

### 5.1 Syntax

```c
if (condition1)
{
    if (condition2)
    {
        /* both true */
    }
    else
    {
        /* condition1 true, condition2 false */
    }
}
else
{
    /* condition1 false */
}
```

### 5.2 Example: positive numbers and which is larger

```c
#include <stdio.h>

int main(void)
{
    int m = 40, n = 20;

    if (m > 0 && n > 0)
    {
        printf("Both numbers are positive\n");

        if (m > n)
            printf("m is greater than n\n");
        else if (m < n)
            printf("m is less than n\n");
        else
            printf("m is equal to n\n");
    }
    else
    {
        printf("At least one number is not positive\n");
    }

    return 0;
}
```

**Output**

```
Both numbers are positive
m is greater than n
```

### 5.3 The dangling-`else` problem

An `else` always binds to the **nearest unmatched `if`**.

```c
if (a > 0)
    if (b > 0)
        printf("both positive\n");
else
    printf("a is not positive\n");     /* WRONG indentation: else belongs to inner if */
```

The compiler sees:

```c
if (a > 0)
{
    if (b > 0)
        printf("both positive\n");
    else
        printf("b is not positive\n");   /* this is what it actually means */
}
```

**Fix: always use braces.**

```c
if (a > 0)
{
    if (b > 0)
        printf("both positive\n");
}
else
{
    printf("a is not positive\n");
}
```

---

## 6. The `switch` statement

`switch` is a multi-way decision that compares **one integer or character expression** against several **constant** cases.

### 6.1 Syntax

```c
switch (expression)
{
    case constant1:
        statements;
        break;
    case constant2:
        statements;
        break;
    case constant3:
        statements;
        break;
    default:
        statements;
}
```

### 6.2 Rules

1. `expression` must have an **integer type** (`int`, `char`, `long`, `enum`). **Not** `float`, `double` or a string.
2. Each `case` label must be a **constant** expression, and all cases must be **unique**.
3. Execution starts at the matching case and **continues into the following cases** unless stopped by `break`. This is called **fall-through**.
4. `default` is optional and runs if no case matches. It can appear anywhere, but is usually last.
5. `break` exits the `switch` immediately. Without it, execution "falls through".

### 6.3 Example: grade remarks

```c
#include <stdio.h>

int main(void)
{
    char grade;

    printf("Enter grade: ");
    scanf(" %c", &grade);

    switch (grade)
    {
        case 'A':
            printf("Outstanding!\n");
            break;
        case 'B':
            printf("Excellent!\n");
            break;
        case 'C':
            printf("Well done\n");
            break;
        case 'D':
            printf("You passed\n");
            break;
        case 'F':
            printf("Better try again\n");
            break;
        default:
            printf("Invalid grade\n");
    }

    printf("Your grade is %c\n", grade);
    return 0;
}
```

### 6.4 Fall-through demonstration

```c
int i = 2;
switch (i)
{
    case 1: printf("I am in case 1\n");
    case 2: printf("I am in case 2\n");
    case 3: printf("I am in case 3\n");
    default: printf("I am in default\n");
}
```

**Output**

```
I am in case 2
I am in case 3
I am in default
```

Because there is no `break`, execution continues downward. Add `break` to each case if you want only one message.

**Intentional fall-through** is sometimes useful:

```c
switch (month)
{
    case 12:
    case 1:
    case 2:
        printf("Winter\n");
        break;
    case 3: case 4: case 5:
        printf("Spring\n");
        break;
    /* ... */
}
```

### 6.5 Example: simple calculator

```c
#include <stdio.h>

int main(void)
{
    char op;
    float a, b;

    printf("Enter expression (e.g. 5 + 3): ");
    scanf("%f %c %f", &a, &op, &b);

    switch (op)
    {
        case '+':
            printf("%.2f\n", a + b);
            break;
        case '-':
            printf("%.2f\n", a - b);
            break;
        case '*':
            printf("%.2f\n", a * b);
            break;
        case '/':
            if (b != 0)
                printf("%.2f\n", a / b);
            else
                printf("Division by zero is not allowed\n");
            break;
        default:
            printf("Invalid operator\n");
    }

    return 0;
}
```

### 6.6 `switch` vs `if-else`

| `switch` | `if-else` |
|---|---|
| Tests one expression against constant cases | Can test any condition, including ranges |
| Only integer/char/enum expressions | Any expression, including float and strings |
| Cleaner for many fixed choices (menus) | Better for ranges and complex logic |
| Uses `break` to prevent fall-through | No fall-through concept |
| Can be faster (jump table) | Evaluated in order |

---

## 7. Worked traces

### Trace 1

```c
int x = 10;
if (x > 5)
    printf("A");
if (x > 8)
    printf("B");
else
    printf("C");
```

**Output:** `AB`

- First `if` is independent → A.
- Second `if` true → B; the `else` is skipped.

### Trace 2

```c
int x = 3;
if (x > 5)
    printf("A");
else if (x > 2)
    printf("B");
else if (x > 1)
    printf("C");
else
    printf("D");
```

**Output:** `B`

The first true condition wins; `x > 1` is never checked.

### Trace 3

```c
int a = 5, b = 10;
if (a > 3)
    if (b > 20)
        printf("X");
    else
        printf("Y");
```

**Output:** `Y`

The `else` belongs to the inner `if` (`b > 20` is false).

### Trace 4

```c
int i = 2;
switch (i)
{
    case 1: printf("One ");
    case 2: printf("Two ");
    case 3: printf("Three ");
    default: printf("Default");
}
```

**Output:** `Two Three Default`

### Trace 5

```c
int i = 5;
switch (i)
{
    case 1: printf("One");
    case 2: printf("Two"); break;
    default: printf("Default");
}
```

**Output:** `Default`

No case matches; execution jumps to `default`.

---

## 8. Common errors

| Error | Explanation | Fix |
|---|---|---|
| `if (x = 5)` | Assignment, not comparison; always true | `if (x == 5)` |
| `if (x > 5);` | Semicolon ends the `if`; the next statement always runs | Remove the semicolon |
| Missing braces | Only the first statement is controlled | Always use `{ }` |
| `else` without `if` | Syntax error | Match each `else` |
| Dangling `else` | Binds to nearest `if` | Use braces |
| `if (a < b < c)` | Evaluates `(a < b) < c`, i.e. `0 < c` or `1 < c` | `if (a < b && b < c)` |
| `switch` on `float`/string | Not allowed | Use `if-else` or `strcmp` |
| Missing `break` | Unwanted fall-through | Add `break` |
| Duplicate `case` | Compile error | Use unique constants |
| `case x:` where `x` is a variable | Case labels must be constant | Use a constant or `if` |
| Comparing floats with `==` | Precision problems | Compare with a tolerance |
| `if (x == 0.1)` | Same problem | `fabs(x - 0.1) < 1e-9` |

---

## 9. Exam-style programs to practise

1. Read a number and print whether it is positive, negative or zero.
2. Read three numbers and print the largest and smallest.
3. Read a mark (0–100) and print the grade (A–F) with validation.
4. Read a year and determine whether it is a leap year.
5. Read a character and determine whether it is a vowel, consonant, digit or special character.
6. Read a month number (1–12) and print the month name and number of days (use `switch`, handle February).
7. Build a menu-driven calculator using `switch` that repeats until the user chooses "quit" (you will need loops — see Note 06).
8. Read a student's score and classify: Distinction (70+), Credit (60–69), Pass (50–59), Fail (<50).
9. Read two numbers and print their relation (`<`, `>`, `=`).
10. Read a single digit (0–9) and print its English name using `switch`.

---

## 10. Rapid revision

- `if (condition) { ... }` — runs the block only if true.
- `if-else` — exactly one of two blocks runs.
- `else-if` ladder — first true condition wins; order matters.
- Nested `if` — an `if` inside another; use braces to avoid dangling `else`.
- `switch` — integer/char expression, constant cases, `break`, optional `default`.
- Missing `break` causes fall-through.
- `=` vs `==` is the most common bug.
- Never put a semicolon after `if (...)`.
- For ranges, use `if-else`; for fixed choices, `switch`.

---

## 11. Self-test (answers below)

1. State the three control structures.
2. Write the syntax of `if-else`.
3. What is the difference between `if` and `if-else`?
4. What is an `else-if` ladder? When is it better than nested `if`?
5. What is the dangling-`else` problem? How do you avoid it?
6. What type must a `switch` expression be?
7. What happens if you omit `break` in a `switch`?
8. Is `default` compulsory in a `switch`? Explain.
9. What is printed?
   ```c
   int a = 4;
   if (a > 2) printf("X");
   if (a > 5) printf("Y");
   else printf("Z");
   ```
10. What is printed?
    ```c
    int x = 7;
    if (x > 10) printf("A");
    else if (x > 5) printf("B");
    else if (x > 0) printf("C");
    ```
11. What is printed?
    ```c
    int n = 1;
    switch (n) {
        case 1: printf("One ");
        case 2: printf("Two ");
        default: printf("Many");
    }
    ```
12. Write a program that reads a number and prints "Positive", "Negative" or "Zero".
13. Write a program that reads a score and prints A (70+), B (60–69), C (50–59), D (40–49), F (below 40).

### Answers

1. Sequence, selection, repetition.
2. `if (condition) { statements; } else { statements; }`
3. `if` runs a block only when true and does nothing when false; `if-else` always runs exactly one of two blocks.
4. A chain of `if ... else if ... else`; good when there are multiple mutually exclusive ranges/conditions, because it stops at the first true condition and is clearer than deeply nested `if`s.
5. An `else` binds to the nearest unmatched `if`, which may not be the one the indentation suggests. Avoid it by always using braces.
6. Integer or character type (`int`, `char`, `long`, `enum`) — not float or string.
7. Execution falls through into the following cases until a `break` or the end of the `switch`.
8. No; if no case matches and there is no `default`, the `switch` does nothing.
9. `XZ` — first `if` true; second false, so its `else` prints Z.
10. `B` — first true condition wins.
11. `One Two Many` — fall-through.
12. See §2.3/§4 examples; use `if (n > 0) ... else if (n < 0) ... else ...`.
13. See §4.2.

---

**Next:** `06_loops.md`
