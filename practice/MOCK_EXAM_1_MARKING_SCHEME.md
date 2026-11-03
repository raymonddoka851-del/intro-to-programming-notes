# Mock Examination 1 — Marking Scheme

**Total: 70 marks**

> Mark positively: award marks for what the candidate demonstrates.
> In programs, do not deduct the same mistake twice. If the logic is correct but there is one syntax slip, award most of the logic marks.

---

## Section A — Multiple choice (15 marks)

| Q | Answer | Q | Answer | Q | Answer |
|---|---|---|---|---|---|
| 1 | C | 6 | C | 11 | B |
| 2 | B | 7 | C | 12 | C |
| 3 | C | 8 | B | 13 | B |
| 4 | A | 9 | B | 14 | B |
| 5 | A | 10 | A | 15 | C |

**1 mark each. No half marks.**

---

## Section B — Short answers (15 marks)

### B16 (3 marks)
An algorithm is a **finite, ordered set of unambiguous steps** for solving a problem. *(1)*
Any **two** properties *(1 mark each)*: input, output, definiteness, finiteness, effectiveness.
(A third correct property earns nothing extra, but do not deduct for it.)
Example wording: "It must terminate after a finite number of steps and each step must be clear enough to carry out."

### B17 (3 marks)
Any **three** correct differences, 1 mark each:
- Compiler translates the whole program at once; interpreter translates one statement at a time.
- Compiler produces object code; interpreter does not.
- Compiler reports errors after scanning the whole program; interpreter stops at the first error.
- Compiled code runs faster; interpreted code runs slower.
- Compiler is used by C/C++; interpreter by Python/JavaScript.

### B18 (3 marks)
- **Syntax error** *(1)*: violates the grammar, detected by the compiler, program will not compile. Example: missing semicolon.
- **Runtime error** *(1)*: occurs while the program runs. Example: division by zero or file not found.
- **Logical error** *(1)*: compiles and runs but produces the wrong output. Example: `average = sum / 5` when there are 4 values.

### B19 (3 marks)
- **Call by value** passes a copy; changes inside the function do not affect the caller. *(1)*
- **Call by reference** passes the address; the function can change the original. *(1)*
- Advantage of value: safer, original protected. Advantage of reference: allows a function to return more than one result / modify arrays and structures efficiently. *(1)*

### B20 (3 marks)
- In a **struct**, each member has its own storage and all members exist at once. *(1)*
- In a **union**, all members share the same storage, so only one member is valid at a time; the size is the largest member. *(1)*
- Use of union: variant record / storing one value that may be an `int`, `float` or string, saving memory. *(1)*

---

## Section C — Trace and debug (20 marks)

### C21 (5 marks)
Output:
```text
7 9
```
Working:
- `i = 1`: odd → `sum = 1`
- `i = 2`: even → `continue`
- `i = 3`: odd → `sum = 4`
- `i = 4`: even → `continue`
- `i = 5`: odd → `sum = 9`
- `i = 6`: even → `continue`
- `i = 7`: loop ends

Marks: correct `7` (2), correct `9` (2), evidence of tracing/`continue` explanation (1).

### C22 (5 marks)
Output:
```text
4 23 42
```
Table:

| `i` | `p + i` | `*(p + i)` | `total` |
|---|---|---|---|
| 0 | `a + 0` | 4 | 4 |
| 2 | `a + 2` | 15 | 19 |
| 4 | `a + 4` | 23 | 42 |

`*p` = `a[0]` = 4; `*(p + 4)` = `a[4]` = 23.

Marks: `4` (1), `23` (1), `42` (2), table/explanation (1).

### C23 (5 marks)
Output:
```text
1 2 6 24
2 4 6
```
- `fact(1)=1`, `fact(2)=2`, `fact(3)=6`, `fact(4)=24`. *(2)*
- `static int x` is initialised **once** and keeps its value between calls, so `bump` prints 2, 4, 6. *(2)*
- Correct layout/newlines. *(1)*

### C24 (5 marks)
Errors (1 mark each, max 5):
1. `scanf("%d", n);` — missing `&n` (logical/runtime — undefined behaviour).
2. `sum` is not initialised before `sum += i` (logical/runtime — garbage value).
3. `for (...);` — the semicolon makes the loop body empty (logical).
4. `if (sum = 0)` — assignment instead of comparison (logical).
5. Missing `;` after `printf("Zero\n")` (syntax).

Corrected program:
```c
#include <stdio.h>

int main(void)
{
    int n, i, sum = 0;

    printf("Enter n: ");
    scanf("%d", &n);

    for (i = 1; i <= n; i++)
    {
        sum += i;
    }

    if (sum == 0)
        printf("Zero\n");
    else
        printf("Sum = %d\n", sum);

    return 0;
}
```
Award 5 for five correct identifications; 4 for four; etc. If all five are corrected in code but not listed, give full marks.

---

## Section D — Programs (20 marks)

### D25 — Primes from 2 to n (10 marks)

```c
#include <stdio.h>

int is_prime(int n);

int main(void)
{
    int n, i, count = 0;

    printf("Enter n: ");
    if (scanf("%d", &n) != 1 || n < 0)
    {
        printf("Invalid input\n");
        return 1;
    }

    for (i = 2; i <= n; i++)
    {
        if (is_prime(i))
        {
            printf("%2d ", i);
            count++;

            if (count % 5 == 0)
                printf("\n");
        }
    }

    if (count % 5 != 0)
        printf("\n");

    printf("Count = %d\n", count);
    return 0;
}

int is_prime(int n)
{
    if (n < 2)
        return 0;

    for (int i = 2; i * i <= n; i++)
        if (n % i == 0)
            return 0;

    return 1;
}
```

**Mark allocation**

| Item | Marks |
|---|---|
| Function prototype and definition with correct return type | 2 |
| Reads `n` correctly, with `&` | 1 |
| Loops from 2 to `n` inclusive | 2 |
| Correct prime test (handles n < 2, checks factors) | 2 |
| Five primes per line and newline handling | 2 |
| Counts and prints the total | 1 |

Accept `for (i = 2; i < n; i++)` inside `is_prime` (slower but correct). Accept `i <= n/2`. Do **not** accept a test that returns prime for 1.

### D26 — Sort descending and binary search (10 marks)

```c
#include <stdio.h>

int main(void)
{
    int a[10];
    int i, j, temp, target;
    int low, high, mid, found = -1;

    printf("Enter 10 integers: ");
    for (i = 0; i < 10; i++)
        scanf("%d", &a[i]);

    /* Bubble sort: descending */
    for (i = 0; i < 9; i++)
    {
        for (j = 0; j < 9 - i; j++)
        {
            if (a[j] < a[j + 1])
            {
                temp = a[j];
                a[j] = a[j + 1];
                a[j + 1] = temp;
            }
        }
    }

    printf("Sorted: ");
    for (i = 0; i < 10; i++)
        printf("%d ", a[i]);
    printf("\n");

    printf("Target: ");
    scanf("%d", &target);

    /* Binary search on a descending array */
    low = 0;
    high = 9;

    while (low <= high)
    {
        mid = (low + high) / 2;

        if (a[mid] == target)
        {
            found = mid;
            break;
        }
        else if (a[mid] > target)
        {
            low = mid + 1;      /* target is to the right */
        }
        else
        {
            high = mid - 1;     /* target is to the left */
        }
    }

    if (found != -1)
        printf("Found at index %d\n", found);
    else
        printf("Not found\n");

    return 0;
}
```

**Mark allocation**

| Item | Marks |
|---|---|
| Reads 10 integers with correct loop and `&` | 1 |
| Bubble sort structure (two loops, correct bounds) | 2 |
| Descending comparison and swap | 2 |
| Prints sorted array | 1 |
| Binary search with `low`, `high`, `mid` and correct loop condition | 3 |
| Correct branch direction for descending order and found/not found | 1 |

If the candidate sorts ascending and adjusts the search correctly, award full marks. If binary search is replaced by linear search, award at most 1 of the 3 search marks.

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

Record your score in `PROGRESS_TRACKER.md` and redo every question where you lost more than half the marks.
