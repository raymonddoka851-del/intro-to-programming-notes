# Mock Examination 2 — STA 121 / CSC 112

**Introduction to Programming**
**Time allowed: 2 hours**
**Total: 70 marks**

> **Instructions**
> 1. Answer **all** questions.
> 2. Section A: circle the letter of the best answer.
> 3. Sections B–D: write your answers in the answer booklet.
> 4. All programs must be written in **C**.
> 5. Marks are shown in brackets. Do the short theory questions first.
> 6. No notes, no calculator, no compiler.

---

## Section A — Multiple choice (15 marks)

*Circle the best answer. 1 mark each.*

**1.** Which phase of program development comes immediately after **coding**?
A. Maintenance  B. Testing  C. Compilation  D. Documentation

**2.** The binary number `1101₂` equals:
A. 11  B. 12  C. 13  D. 14

**3.** The 8-bit two's complement representation of −5 is:
A. `10000101`  B. `11111010`  C. `11111011`  D. `00000101`

**4.** What is the value of `5 + 3 * 2`?
A. 16  B. 11  C. 13  D. 10

**5.** What does `printf("%d", 10 > 5 && 3 > 4);` print?
A. 1  B. 0  C. 2  D. true

**6.** Which loop tests its condition **after** executing the body?
A. `for`  B. `while`  C. `do-while`  D. `switch`

**7.** For `int a[5];`, the last valid index is:
A. 4  B. 5  C. 6  D. 0

**8.** `sizeof("C")` is:
A. 1  B. 2  C. 3  D. 4

**9.** `strcmp("abc", "abd")` returns:
A. 0  B. a positive value  C. a negative value  D. 1

**10.** If `int x = 5;`, then `&x` is:
A. the value 5  B. the address of `x`  C. a pointer to 5  D. invalid

**11.** If `p` is a pointer to a structure, `p->age` is equivalent to:
A. `p.age`  B. `(*p).age`  C. `&p.age`  D. `*p.age`

**12.** The size of a union is:
A. the sum of all members  B. the size of its largest member  C. always 4 bytes  D. always 8 bytes

**13.** Which function closes a file?
A. `fopen`  B. `fclose`  C. `fprintf`  D. `fscanf`

**14.** `printf("%04d", 7);` prints:
A. `7`  B. `0007`  C. `7000`  D. `   7`

**15.** Which of these is a logical operator?
A. `&`  B. `&&`  C. `|`  D. `^`

---

## Section B — Short answers (15 marks)

*Answer briefly. 3 marks each.*

**16.** List **four** characteristics of a good program and explain any one.

**17.** Briefly explain what happens at each of these stages: **preprocessor → compiler → assembler → linker → loader**.

**18.** Differentiate between a `while` loop and a `do-while` loop. Give a situation where `do-while` is the better choice.

**19.** Define an **array**. State three properties of arrays in C.

**20.** Differentiate between `#define` and `const`, giving one example of each.

---

## Section C — Trace and debug (20 marks)

**21.** What is the exact output? Show the spaces clearly. **(5 marks)**

```c
#include <stdio.h>

int main(void)
{
    int i, j;

    for (i = 1; i <= 4; i++)
    {
        for (j = 1; j <= 4 - i; j++)
            printf(" ");

        for (j = 1; j <= 2 * i - 1; j++)
            printf("%d", i);

        printf("\n");
    }

    return 0;
}
```

**22.** What is the exact output? Show the recursive calls. **(5 marks)**

```c
#include <stdio.h>

int sum(int a[], int n)
{
    if (n == 0)
        return 0;
    return a[n - 1] + sum(a, n - 1);
}

int main(void)
{
    int a[5] = {1, 2, 3, 4, 5};

    printf("%d\n", sum(a, 5));
    printf("%d\n", sum(a, 3));
    return 0;
}
```

**23.** What is the exact output? Explain the pointer expression. **(5 marks)**

```c
#include <stdio.h>

int main(void)
{
    char s[] = "CExam";
    char *p = s;

    while (*p != '\0')
    {
        printf("%c", *p);
        p++;
    }
    printf("\n");

    printf("%d\n", (int)(p - s));
    printf("%c\n", *(s + 2));

    return 0;
}
```

**24.** The program below contains **five** problems. Identify each one, state its type, and write the corrected program. **(5 marks)**

```c
#include <stdio.h>

int main(void)
{
    int n, i;
    float average, sum;

    printf("How many? ");
    scanf("%d", &n);

    int a[n];

    for (i = 0; i <= n; i++)
        scanf("%d", &a[i]);

    for (i = 0; i < n; i++)
        sum += a[i];

    average = sum / n;
    printf("Average = %d\n", average);

    return 0;
}
```

---

## Section D — Write complete programs (20 marks)

**25.** Write a complete C program that reads a line of text and reports:

- the number of characters (excluding the newline)
- the number of vowels
- the number of consonants
- the number of digits
- the number of spaces

Use at least **two functions**. Print a labelled report. **(10 marks)**

Example:
```text
Enter a line: CSC 112 has 30 students!
Characters : 24
Vowels     : 3
Consonants : 11
Digits     : 5
Spaces     : 4
```

**26.** Define a structure `Employee` with `name`, `basic` salary, `allowance`, `tax` and `net` pay. Write a program that:

1. reads `n` employees;
2. computes allowance = 20% of basic, tax = 10% of basic, net = basic + allowance − tax;
3. prints a formatted report with totals;
4. writes the report data to `payroll.txt`;
5. reads the file back and displays the records. **(10 marks)**

Example:
```text
How many employees? 2
Name and basic: Alice 50000
Name and basic: Bob 30000

NAME          BASIC   ALLOWANCE      TAX      NET
Alice      50000.00    10000.00  5000.00 55000.00
Bob        30000.00     6000.00  3000.00 33000.00
Total net: 88000.00
```

---

**END OF PAPER**

*Check: every program has `#include`, `main`, declarations, input, processing, output and `return 0;`.*
