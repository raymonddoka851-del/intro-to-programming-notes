# Mock Examination 1 — STA 121 / CSC 112

**Introduction to Programming**
**Time allowed: 2 hours**
**Total: 70 marks**

> **Instructions**
> 1. Answer **all** questions.
> 2. Section A: circle the letter of the best answer.
> 3. Sections B–D: write your answers in the answer booklet.
> 4. All programs must be written in **C**.
> 5. Marks are shown in brackets. Budget about **1.7 minutes per mark**.
> 6. No notes, no calculator, no compiler.

---

## Section A — Multiple choice (15 marks)

*Circle the best answer. 1 mark each.*

**1.** Which tool translates an entire high-level program into object code before it runs?
A. Assembler  B. Interpreter  C. Compiler  D. Loader

**2.** Which of the following is **not** a C keyword?
A. `static`  B. `main`  C. `sizeof`  D. `continue`

**3.** On a typical 32-bit system, `sizeof(int)` is:
A. 1  B. 2  C. 4  D. 8

**4.** What is the value of `17 % 5`?
A. 2  B. 3  C. 3.4  D. 4

**5.** What does `printf("%d", 7 / 2);` print?
A. 3  B. 3.5  C. 4  D. 3.0

**6.** Which identifier is valid in C?
A. `2total`  B. `total-marks`  C. `_total`  D. `float`

**7.** Which loop always executes its body at least once?
A. `for`  B. `while`  C. `do-while`  D. none

**8.** The first element of `int a[10]` is accessed as:
A. `a[1]`  B. `a[0]`  C. `a[10]`  D. `a[-1]`

**9.** `strlen("Hi")` returns:
A. 1  B. 2  C. 3  D. 4

**10.** `int *p;` declares:
A. a pointer to an integer  B. an integer named `p`  C. a pointer to a pointer  D. an array

**11.** If `s` is a pointer to a structure, its member `name` is accessed as:
A. `s.name`  B. `s->name`  C. `*s.name`  D. `&s.name`

**12.** Which file mode adds data to the end of an existing file without erasing it?
A. `"r"`  B. `"w"`  C. `"a"`  D. `"r+"`

**13.** The ASCII code of `'A'` is:
A. 61  B. 65  C. 90  D. 97

**14.** What is the value of `!0`?
A. 0  B. 1  C. −1  D. undefined

**15.** Which format specifier prints a `float`?
A. `%d`  B. `%c`  C. `%f`  D. `%s`

---

## Section B — Short answers (15 marks)

*Answer briefly. 3 marks each.*

**16.** Define an **algorithm** and state **three** of its properties.

**17.** Give **three** differences between a compiler and an interpreter.

**18.** Explain **syntax**, **runtime** and **logical** errors. Give one example of each.

**19.** Differentiate between **call by value** and **call by reference**. Give one advantage of each.

**20.** Differentiate between a **structure** and a **union**. State one practical use of a union.

---

## Section C — Trace and debug (20 marks)

**21.** What is the exact output? Show your working. **(5 marks)**

```c
#include <stdio.h>

int main(void)
{
    int i, sum = 0;

    for (i = 1; i <= 6; i++)
    {
        if (i % 2 == 0)
            continue;
        sum += i;
    }

    printf("%d %d\n", i, sum);
    return 0;
}
```

**22.** What is the exact output? Draw a small table of `i`, `p + i` and `total`. **(5 marks)**

```c
#include <stdio.h>

int main(void)
{
    int a[6] = {4, 8, 15, 16, 23, 42};
    int *p = a;
    int i, total = 0;

    for (i = 0; i < 6; i += 2)
        total += *(p + i);

    printf("%d %d %d\n", *p, *(p + 4), total);
    return 0;
}
```

**23.** What is the exact output? Explain the role of `static`. **(5 marks)**

```c
#include <stdio.h>

int fact(int n)
{
    if (n <= 1)
        return 1;
    return n * fact(n - 1);
}

void bump(void)
{
    static int x = 0;
    x += 2;
    printf("%d ", x);
}

int main(void)
{
    int i;

    for (i = 1; i <= 4; i++)
        printf("%d ", fact(i));
    printf("\n");

    bump();
    bump();
    bump();
    printf("\n");

    return 0;
}
```

**24.** The program below contains **five** errors. Identify each error, state its type, and write the corrected program. **(5 marks)**

```c
#include <stdio.h>

int main(void)
{
    int n, i, sum;

    printf("Enter n: ");
    scanf("%d", n);

    for (i = 1; i <= n; i++);
    {
        sum += i;
    }

    if (sum = 0)
        printf("Zero\n")
    else
        printf("Sum = %d\n", sum);

    return 0;
}
```

---

## Section D — Write complete programs (20 marks)

**25.** Write a complete C program that reads a positive integer `n` and prints **all prime numbers from 2 to n**, with **five primes per line**, followed by the total count. Use a function `int is_prime(int n)`. **(10 marks)**

Example:
```text
Enter n: 30
 2  3  5  7 11
13 17 19 23 29
Count = 10
```

**26.** Write a complete C program that:

1. reads 10 integers into an array;
2. sorts them in **descending** order using **bubble sort**;
3. prints the sorted array;
4. asks for a target value and searches for it using **binary search**;
5. prints the index if found, or "Not found". **(10 marks)**

Example:
```text
Enter 10 integers: 4 9 1 7 3 8 2 6 5 0
Sorted: 9 8 7 6 5 4 3 2 1 0
Target: 6
Found at index 3
```

---

**END OF PAPER**

*Check: have you answered every question? Are your `scanf` calls using `&`? Are your loops bounded correctly?*
