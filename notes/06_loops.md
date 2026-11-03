# Note 06 — Loops (Iteration)

> **Covers outline Week 8** (for, do..while, while..do, goto).

---

## 1. Why loops?

A loop repeats a block of statements while a condition remains true.

Without a loop:

```c
printf("1\n");
printf("2\n");
printf("3\n");
/* ... 100 lines ... */
```

With a loop:

```c
for (int i = 1; i <= 100; i++)
    printf("%d\n", i);
```

Loops are used for:

- Counting (sum, average, factorial).
- Processing a sequence of inputs (marks, transactions).
- Searching and sorting.
- Repeating a menu until the user quits.
- Generating patterns and tables.

---

## 2. The three parts of every loop

Every correct loop has:

1. **Initialisation** — set the starting value (`i = 1`).
2. **Condition** — test whether to continue (`i <= n`).
3. **Update** — change something so the loop eventually stops (`i++`).

```
   initialise
       │
       ▼
   ┌─────────────┐
   │  condition? │◄────────┐
   └──┬───────┬──┘         │
    true     false         │
      │        │            │
      ▼        ▼            │
   body ───► update ────────┘
      │
      ▼
   after loop
```

**If any part is missing or wrong, you get an infinite loop.**

---

## 3. The `while` loop

### 3.1 Syntax

```c
while (condition)
{
    /* body */
}
```

### 3.2 How it works

1. Evaluate the condition.
2. If true, run the body.
3. Go back to step 1.
4. If false, skip the body and continue after the loop.

Because the condition is tested **before** the body, `while` is an **entry-controlled** (pre-test) loop. If the condition is false at the start, the body **never runs**.

### 3.3 Example: count from 1 to 5

```c
#include <stdio.h>

int main(void)
{
    int i = 1;

    while (i <= 5)
    {
        printf("%d ", i);
        i++;
    }
    printf("\n");
    return 0;
}
```

**Output:** `1 2 3 4 5`

**Trace**

| Check | `i` | Action |
|---|---|---|
| 1 ≤ 5 true | 1 | print 1, i=2 |
| 2 ≤ 5 true | 2 | print 2, i=3 |
| 3 ≤ 5 true | 3 | print 3, i=4 |
| 4 ≤ 5 true | 4 | print 4, i=5 |
| 5 ≤ 5 true | 5 | print 5, i=6 |
| 6 ≤ 5 false | 6 | exit |

### 3.4 Example: sum of the first N natural numbers

```c
#include <stdio.h>

int main(void)
{
    int n, i = 1, sum = 0;

    printf("Enter N: ");
    scanf("%d", &n);

    while (i <= n)
    {
        sum = sum + i;
        i++;
    }

    printf("Sum = %d\n", sum);
    return 0;
}
```

**Input:** `5` → **Output:** `Sum = 15` (1+2+3+4+5).

### 3.5 Example: sentinel-controlled loop

Read numbers until the user enters `0`:

```c
#include <stdio.h>

int main(void)
{
    int num, sum = 0, count = 0;

    printf("Enter numbers (0 to stop): ");
    scanf("%d", &num);

    while (num != 0)
    {
        sum += num;
        count++;
        scanf("%d", &num);
    }

    printf("Count = %d, Sum = %d\n", count, sum);
    return 0;
}
```

> A **sentinel** is a special value that marks the end of input. It must be a value that cannot be valid data.

---

## 4. The `do-while` loop

### 4.1 Syntax

```c
do
{
    /* body */
} while (condition);
```

Note the **semicolon** after `while (condition);`.

### 4.2 How it works

1. Run the body **once**.
2. Evaluate the condition.
3. If true, go back to step 1.
4. If false, exit.

The condition is tested **after** the body, so `do-while` is **exit-controlled** (post-test). The body always runs **at least once**, even if the condition is false.

### 4.3 Example: menu that runs at least once

```c
#include <stdio.h>

int main(void)
{
    int choice;

    do
    {
        printf("\n1. Say hello\n");
        printf("2. Say goodbye\n");
        printf("0. Quit\n");
        printf("Choice: ");
        scanf("%d", &choice);

        switch (choice)
        {
            case 1: printf("Hello!\n"); break;
            case 2: printf("Goodbye!\n"); break;
            case 0: printf("Exiting...\n"); break;
            default: printf("Invalid choice\n");
        }
    } while (choice != 0);

    return 0;
}
```

### 4.4 Example: add numbers until 0

```c
#include <stdio.h>

int main(void)
{
    int num, sum = 0;

    do
    {
        printf("Enter a number (0 to stop): ");
        scanf("%d", &num);
        sum += num;
    } while (num != 0);

    printf("Sum = %d\n", sum);
    return 0;
}
```

**Note:** this adds the final `0`, which does not change the sum.

### 4.5 `while` vs `do-while`

| `while` | `do-while` |
|---|---|
| Tests condition **before** body | Tests condition **after** body |
| Body may run **0** times | Body runs **at least once** |
| Entry-controlled | Exit-controlled |
| `while (cond) { ... }` | `do { ... } while (cond);` |

**Exam favourite:** "What is the output?"

```c
int i = 10;
while (i < 5)
    printf("A");
```

→ prints **nothing**.

```c
int i = 10;
do
    printf("A");
while (i < 5);
```

→ prints **A once**.

---

## 5. The `for` loop

### 5.1 Syntax

```c
for (initialisation; condition; update)
{
    /* body */
}
```

All three parts are on one line:

```c
for (int i = 1; i <= 5; i++)
    printf("%d ", i);
```

### 5.2 Order of execution

1. **Initialisation** — once, before the loop.
2. **Condition** — before each iteration.
3. **Body** — if the condition is true.
4. **Update** — after the body.
5. Repeat from step 2.

```
i = 1
  ↓
i <= 5? ── no ──► exit
  │ yes
  ▼
body
  ↓
i++
  └────────────► back to condition
```

### 5.3 Equivalent loops

These three all print 1 to 5:

```c
/* for */
for (i = 1; i <= 5; i++)
    printf("%d ", i);

/* while */
i = 1;
while (i <= 5)
{
    printf("%d ", i);
    i++;
}

/* do-while */
i = 1;
do
{
    printf("%d ", i);
    i++;
} while (i <= 5);
```

### 5.4 Flexible forms

```c
for (i = 0; i < n; i++)          /* 0 to n-1 — standard array loop */
for (i = n; i >= 1; i--)         /* countdown */
for (i = 0; i <= 10; i += 2)     /* step by 2 */
for (i = 1; i <= n; i *= 2)      /* doubling */
for ( ; i <= n; i++)             /* initialisation already done */
for (i = 0; ; i++)               /* no condition = infinite; use break */
for ( ; ; )                      /* infinite loop */
```

Multiple expressions with the comma operator:

```c
for (i = 1, j = 10; i < j; i++, j--)
    printf("%d %d\n", i, j);
```

### 5.5 Example: factorial

```c
#include <stdio.h>

int main(void)
{
    int n, i;
    long long factorial = 1;

    printf("Enter a positive integer: ");
    scanf("%d", &n);

    for (i = 1; i <= n; i++)
        factorial *= i;

    printf("%d! = %lld\n", n, factorial);
    return 0;
}
```

**Input:** `5` → **Output:** `5! = 120`

> Use `long long` because factorials grow very fast. `13!` already exceeds a 32-bit `int`.

### 5.6 Example: multiplication table

```c
#include <stdio.h>

int main(void)
{
    int n, i;

    printf("Enter a number: ");
    scanf("%d", &n);

    for (i = 1; i <= 10; i++)
        printf("%d x %2d = %3d\n", n, i, n * i);

    return 0;
}
```

**Input:** `7`

```
7 x  1 =   7
7 x  2 =  14
...
7 x 10 =  70
```

---

## 6. Nested loops

A loop inside another loop. The **outer** loop controls rows; the **inner** loop controls columns/items in each row.

### 6.1 Syntax

```c
for (i = 1; i <= rows; i++)
{
    for (j = 1; j <= columns; j++)
    {
        /* body */
    }
    /* statements after inner loop, once per outer iteration */
}
```

**The inner loop completes all its iterations for each single outer iteration.**

### 6.2 Example: multiplication table grid

```c
#include <stdio.h>

int main(void)
{
    int i, j;

    for (i = 1; i <= 5; i++)
    {
        for (j = 1; j <= 5; j++)
            printf("%4d", i * j);
        printf("\n");
    }

    return 0;
}
```

**Output**

```
   1   2   3   4   5
   2   4   6   8  10
   3   6   9  12  15
   4   8  12  16  20
   5  10  15  20  25
```

### 6.3 Example: star triangle

```c
#include <stdio.h>

int main(void)
{
    int rows, i, j;

    printf("Enter number of rows: ");
    scanf("%d", &rows);

    for (i = 1; i <= rows; i++)
    {
        for (j = 1; j <= i; j++)
            printf("*");
        printf("\n");
    }

    return 0;
}
```

**Input:** `5`

```
*
**
***
****
*****
```

### 6.4 Example: centred pyramid

```c
#include <stdio.h>

int main(void)
{
    int rows, i, space, star;

    printf("Enter number of rows: ");
    scanf("%d", &rows);

    for (i = 1; i <= rows; i++)
    {
        for (space = 1; space <= rows - i; space++)
            printf(" ");

        for (star = 1; star <= 2 * i - 1; star++)
            printf("*");

        printf("\n");
    }

    return 0;
}
```

**Input:** `5`

```
    *
   ***
  *****
 *******
*********
```

### 6.5 Example: prime numbers from 2 to 50

```c
#include <stdio.h>

int main(void)
{
    int i, j, is_prime;

    for (i = 2; i <= 50; i++)
    {
        is_prime = 1;

        for (j = 2; j * j <= i; j++)
        {
            if (i % j == 0)
            {
                is_prime = 0;
                break;
            }
        }

        if (is_prime)
            printf("%d ", i);
    }

    printf("\n");
    return 0;
}
```

**Output:** `2 3 5 7 11 13 17 19 23 29 31 37 41 43 47`

---

## 7. `break`, `continue` and `goto`

### 7.1 `break`

Immediately exits the **innermost** loop or `switch`. Execution continues after that loop.

```c
for (i = 1; i <= 10; i++)
{
    if (i == 5)
        break;
    printf("%d ", i);
}
```

**Output:** `1 2 3 4`

**Use:** stop searching when you find a match; exit a menu; stop on error.

### 7.2 `continue`

Skips the rest of the **current iteration** and jumps to the next iteration (in a `for` loop, the update runs first).

```c
for (i = 1; i <= 5; i++)
{
    if (i == 3)
        continue;
    printf("%d ", i);
}
```

**Output:** `1 2 4 5`

**Use:** skip invalid or unwanted values.

### 7.3 `break` vs `continue`

| `break` | `continue` |
|---|---|
| Exits the loop completely | Skips to the next iteration |
| Control goes after the loop | Control goes to the loop's next test/update |
| Also works in `switch` | Does **not** work in `switch` |

### 7.4 `goto`

Transfers control to a **label** anywhere in the same function.

```c
goto label;
...
label:
    statement;
```

**Example**

```c
#include <stdio.h>

int main(void)
{
    int i = 1;

start:
    if (i <= 5)
    {
        printf("%d ", i);
        i++;
        goto start;
    }

    printf("\n");
    return 0;
}
```

**Output:** `1 2 3 4 5`

**Use `goto` sparingly.** It can make programs hard to read ("spaghetti code"). Kernighan and Ritchie called it "infinitely abusable". A common acceptable use is jumping to a single cleanup block on error.

### 7.5 `break` in nested loops

`break` only exits the **inner** loop:

```c
for (i = 1; i <= 3; i++)
{
    for (j = 1; j <= 3; j++)
    {
        if (j == 2)
            break;
        printf("%d%d ", i, j);
    }
}
```

**Output:** `11 21 31` (inner loop breaks at j=2 each time; outer continues).

To exit both loops, use a flag:

```c
int found = 0;
for (i = 0; i < n && !found; i++)
    for (j = 0; j < m; j++)
        if (a[i][j] == target)
        {
            found = 1;
            break;
        }
```

---

## 8. Classic loop programs (know these by heart)

### 8.1 Count digits in a number

```c
int n, count = 0;
scanf("%d", &n);
if (n == 0) count = 1;
while (n != 0)
{
    n /= 10;
    count++;
}
printf("Digits = %d\n", count);
```

### 8.2 Sum of digits

```c
int n, sum = 0;
scanf("%d", &n);
while (n != 0)
{
    sum += n % 10;
    n /= 10;
}
printf("Sum of digits = %d\n", sum);
```

### 8.3 Reverse a number

```c
int n, reverse = 0, digit;
scanf("%d", &n);
while (n != 0)
{
    digit = n % 10;
    reverse = reverse * 10 + digit;
    n /= 10;
}
printf("Reverse = %d\n", reverse);
```

**Trace for 1234:**

| `n` | `digit` | `reverse` |
|---|---|---|
| 1234 | 4 | 4 |
| 123 | 3 | 43 |
| 12 | 2 | 432 |
| 1 | 1 | 4321 |
| 0 | — | stop |

### 8.4 Palindrome number

```c
int n, original, reverse = 0;
scanf("%d", &n);
original = n;
while (n != 0)
{
    reverse = reverse * 10 + n % 10;
    n /= 10;
}
if (original == reverse)
    printf("Palindrome\n");
else
    printf("Not a palindrome\n");
```

### 8.5 Prime check

```c
int n, i, is_prime = 1;
scanf("%d", &n);

if (n <= 1)
    is_prime = 0;
else
    for (i = 2; i * i <= n; i++)
        if (n % i == 0)
        {
            is_prime = 0;
            break;
        }

if (is_prime)
    printf("Prime\n");
else
    printf("Not prime\n");
```

### 8.6 Fibonacci series

```c
int n, i, a = 0, b = 1, c;
scanf("%d", &n);

for (i = 1; i <= n; i++)
{
    printf("%d ", a);
    c = a + b;
    a = b;
    b = c;
}
```

**For n=8:** `0 1 1 2 3 5 8 13`

### 8.7 GCD (Euclid's algorithm)

```c
int a, b, temp;
scanf("%d %d", &a, &b);

while (b != 0)
{
    temp = b;
    b = a % b;
    a = temp;
}
printf("GCD = %d\n", a);
```

**Trace for 48, 18:** (48,18) → (18,12) → (12,6) → (6,0) → GCD 6.

### 8.8 Armstrong number (3 digits)

```c
int n, temp, digit, sum = 0;
scanf("%d", &n);
temp = n;

while (temp != 0)
{
    digit = temp % 10;
    sum += digit * digit * digit;
    temp /= 10;
}

if (sum == n)
    printf("Armstrong\n");
else
    printf("Not Armstrong\n");
```

`153 = 1³ + 5³ + 3³ = 1 + 125 + 27 = 153`. ✓

---

## 9. Loop trace questions (very common)

### Trace A

```c
int i, sum = 0;
for (i = 1; i <= 4; i++)
    sum += i;
printf("%d", sum);
```

| `i` | `sum` |
|---|---|
| 1 | 1 |
| 2 | 3 |
| 3 | 6 |
| 4 | 10 |
| 5 (fails) | 10 |

**Output:** `10`

### Trace B

```c
int i = 5;
while (i > 0)
{
    printf("%d ", i);
    i -= 2;
}
```

**Output:** `5 3 1`

### Trace C

```c
int i;
for (i = 0; i < 3; i++)
{
    for (int j = 0; j < 2; j++)
        printf("%d%d ", i, j);
}
```

**Output:** `00 01 10 11 20 21`

### Trace D

```c
int i = 0;
while (i < 5)
{
    i++;
    if (i == 3)
        continue;
    printf("%d ", i);
}
```

**Output:** `1 2 4 5`

### Trace E

```c
int i = 1;
do
{
    printf("%d ", i);
    i++;
} while (i <= 3);
```

**Output:** `1 2 3`

### Trace F

```c
int i = 10;
do
{
    printf("%d ", i);
    i++;
} while (i < 5);
```

**Output:** `10` (body runs once, then condition false)

---

## 10. Common loop errors

| Error | Result | Fix |
|---|---|---|
| Missing initialisation | Garbage start value | Initialise before the loop |
| Missing update (`i++`) | **Infinite loop** | Add the update |
| Semicolon after header: `while (i<5);` | Empty body; loop does nothing useful | Remove the semicolon |
| `for (i=1; i<=n; i++);` | Same problem | Remove the semicolon |
| Off-by-one: `i <= n` vs `i < n` | One extra or missing iteration | Check whether n is inclusive |
| Modifying the loop variable in the body | Unpredictable iteration count | Use a separate variable |
| Wrong direction: `for (i=n; i<=1; i--)` | Never runs | Match condition to direction |
| `while (n != 0)` but `n` never changes | Infinite loop | Update `n` |
| `float` loop counter | Precision errors, missed iterations | Use `int` |
| `break` inside nested loop | Exits only inner loop | Use a flag |
| `do-while` missing `;` | Syntax error | Add `;` |
| `for (;;)` | Intentional infinite loop | Use `break` to exit |
| `while (i <= n)` with `unsigned` and `i--` | Underflow → huge value | Use signed or restructure |

---

## 11. How to choose the right loop

| Situation | Best loop |
|---|---|
| You know the number of iterations | `for` |
| You do not know how many times, but may run zero times | `while` |
| The body must run at least once (menu, input validation) | `do-while` |
| Iterating over an array with an index | `for` |
| Reading until a sentinel value | `while` or `do-while` |
| Infinite loop with an internal exit | `for (;;)` or `while (1)` |

---

## 12. Self-test (answers below)

1. Name the three parts of a loop and explain why each is necessary.
2. Differentiate `while` and `do-while`.
3. Write the general syntax of a `for` loop.
4. What is an infinite loop? Give two ways one can occur.
5. What is the difference between `break` and `continue`?
6. What does `goto` do? Why should it be used sparingly?
7. What is printed?
   ```c
   int i = 1;
   while (i <= 5) {
       printf("%d ", i);
       i += 2;
   }
   ```
8. What is printed?
   ```c
   int i;
   for (i = 5; i >= 1; i--)
       printf("%d ", i);
   ```
9. What is printed?
   ```c
   int i, j;
   for (i = 1; i <= 2; i++)
       for (j = 1; j <= 3; j++)
           printf("%d ", i * j);
   ```
10. What is printed?
    ```c
    int i;
    for (i = 1; i <= 5; i++) {
        if (i % 2 == 0) continue;
        printf("%d ", i);
    }
    ```
11. What is printed?
    ```c
    int i = 10;
    do {
        printf("%d ", i);
        i++;
    } while (i < 5);
    ```
12. Write a program to find the sum of the first N natural numbers.
13. Write a program to print the factorial of a number.
14. Write a program to reverse a number and check whether it is a palindrome.
15. Write a program to print a pyramid of stars with N rows.
16. Write a program to check whether a number is prime.
17. Write a program to print the Fibonacci series up to N terms.
18. What is the output of the following? Explain.
    ```c
    int i = 1;
    while (i <= 3)
        printf("%d ", i);
        i++;
    ```

### Answers

1. Initialisation, condition, update. Without initialisation the loop starts with garbage; without a condition it never knows when to stop; without an update the condition never changes and the loop may run forever.
2. `while` tests before the body and may run 0 times; `do-while` tests after the body and runs at least once. `do-while` needs a semicolon after the condition.
3. `for (initialisation; condition; update) { body }`
4. A loop whose condition never becomes false. Examples: forgetting `i++`; `while (1)` with no `break`; a condition that is always true.
5. `break` exits the loop; `continue` skips the rest of the current iteration and goes to the next one.
6. `goto` jumps to a labelled statement in the same function. It makes control flow hard to follow and can produce unmaintainable "spaghetti" code.
7. `1 3 5`
8. `5 4 3 2 1`
9. `1 2 3 2 4 6`
10. `1 3 5`
11. `10`
12. See §3.4.
13. See §5.5.
14. See §8.3 and §8.4.
15. See §6.4.
16. See §8.5.
17. See §8.6.
18. Output is `1 1 1 ...` forever. The `while` controls only the `printf`; `i++` is **outside** the loop because there are no braces. The condition never changes.

---

**Next:** `07_functions_and_recursion.md`
