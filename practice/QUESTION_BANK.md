# Question Bank — CSC 112 / STA 121

> 96 exam-style questions arranged by topic. Answers are in `ANSWER_KEY.md`.
> Do **not** read the answer key until you have written an answer.
>
> **Mark guide:** 1 mark ≈ one correct point or one correct line of code.
> A 6-mark "explain" question needs about 6 distinct points.

---

## Section A — Programming fundamentals (Q1–Q10)

**Q1.** Define the following terms: (a) program, (b) programming, (c) programming
language. Give one example of each where appropriate. **(3 marks)**

**Q2.** Classify programming languages into their two main groups. For each group,
state two advantages and two disadvantages. **(6 marks)**

**Q3.** Differentiate between machine language, assembly language and high-level
language. Give one example of each. **(6 marks)**

**Q4.** State four differences between a compiler and an interpreter. **(4 marks)**

**Q5.** List the eight phases of program development **in the correct order**, and
explain any four of them. **(8 marks)**

**Q6.** State and explain six characteristics of a good program. **(6 marks)**

**Q7.** (a) Define an algorithm. (b) State five features of a good algorithm.
**(6 marks)**

**Q8.** Write an algorithm **and** pseudocode to find the largest of three numbers
A, B and C. **(6 marks)**

**Q9.** (a) Name and describe the five main flowchart symbols. (b) Draw a flowchart
to read a number and print whether it is even or odd. **(8 marks)**

**Q10.** Explain, with one example each, the three types of programming errors:
syntax, runtime and logical. **(6 marks)**

---

## Section B — C basics and compilation (Q11–Q20)

**Q11.** Write the general structure of a C program and explain the purpose of each
part. **(6 marks)**

**Q12.** What is a header file? Name five standard header files and state what each
provides. **(5 marks)**

**Q13.** State the rules for forming identifiers in C. Which of these are valid:
`total`, `2ndNumber`, `_count`, `student-name`, `Sum`, `float`? **(5 marks)**

**Q14.** What are keywords? List ten C keywords and explain why they cannot be used
as variable names. **(4 marks)**

**Q15.** Differentiate between `#define` and `const`. **(4 marks)**

**Q16.** Explain the two ways of writing comments in C. State three reasons for using
comments and whether comments can be nested. **(4 marks)**

**Q17.** Explain the stages a C program passes through from source code to execution:
preprocessor, compiler, assembler, linker, loader. **(8 marks)**

**Q18.** Differentiate between source code, object code and an executable file.
**(4 marks)**

**Q19.** What is the work of the linker? Why is it needed? **(3 marks)**

**Q20.** Identify the errors in the following program and state whether each is a
syntax, runtime or logical error. **(5 marks)**

```c
#include <stdio.h>
int main(void)
{
    int a = 10, b = 0;
    printf("%d\n", a / b)
    return 0;
}
```

---

## Section C — Data types and number systems (Q21–Q30)

**Q21.** Define bit, byte, nibble and word. How many different values can be
represented with (a) 4 bits, (b) 8 bits, (c) n bits? **(5 marks)**

**Q22.** Convert the following decimal numbers to binary: 13, 45, 100, 255.
Show your working. **(4 marks)**

**Q23.** Convert the following binary numbers to decimal: 1011, 110010, 11111111.
**(3 marks)**

**Q24.** Convert: (a) decimal 60 to octal, (b) decimal 60 to hexadecimal,
(c) binary 101011 to hexadecimal, (d) hexadecimal 3F to decimal. **(6 marks)**

**Q25.** Explain the difference between signed and unsigned integers. State the range
of an 8-bit unsigned integer, an 8-bit signed integer and a 16-bit signed integer.
**(6 marks)**

**Q26.** (a) Represent −12 and −25 in 8-bit two's complement. (b) Why do computers
use two's complement instead of sign-and-magnitude? **(6 marks)**

**Q27.** Complete the table for `int`, `float`, `double` and `char`: typical size in
bytes, format specifier for `printf`, one example value, and one use. **(8 marks)**

**Q28.** State the ASCII values of `'A'`, `'a'`, `'0'`, space, `'\n'` and `'\0'`.
What is a character code? **(6 marks)**

**Q29.** Differentiate between implicit type conversion and explicit type casting.
Evaluate: (a) `7 / 2`, (b) `(float)7 / 2`, (c) `(int)7.9`, (d) `'A' + 1`. **(5 marks)**

**Q30.** What does `sizeof` do? Predict the output:
`printf("%d %d", sizeof(int), sizeof(char));` on a typical 32/64-bit machine.
**(4 marks)**

---

## Section D — Operators and expressions (Q31–Q40)

**Q31.** List five groups of operators in C and give one example operator from each.
**(5 marks)**

**Q32.** Evaluate: (a) `17 / 5`, (b) `17 % 5`, (c) `-17 / 5`, (d) `7 / 2.0`.
Explain the difference between `/` and `%`. **(4 marks)**

**Q33.** Differentiate between relational and logical operators. Write the truth
tables for `&&`, `||` and `!`. **(5 marks)**

**Q34.** Evaluate: (a) `12 & 10`, (b) `12 | 10`, (c) `12 ^ 10`, (d) `~12`,
(e) `12 << 2`, (f) `12 >> 2`. **(6 marks)**

**Q35.** Rewrite using compound assignment and evaluate: `x = x + 5;` then
`x = x * 2;` then `x = x - 4;` if `x` starts at 3. **(4 marks)**

**Q36.** If `a = 5`, determine the value of `a` and `b` in each case:
(a) `b = a++;`, (b) `b = ++a;`, (c) `b = a--;`, (d) `b = --a;`.
Start from `a = 5` each time. **(6 marks)**

**Q37.** Explain the conditional (ternary) operator with its syntax. Rewrite this
using `?:`: `if (n % 2 == 0) printf("Even"); else printf("Odd");` **(4 marks)**

**Q38.** Using precedence and associativity, evaluate:
(a) `2 + 3 * 4`, (b) `(2 + 3) * 4`, (c) `10 - 4 - 3`, (d) `100 / 10 / 2`,
(e) `5 > 3 && 2 < 4`. **(5 marks)**

**Q39.** Evaluate the final value of `x`:
```c
int x = 10;
x += 5;
x -= 3;
x *= 2;
x /= 4;
x %= 4;
```
Show each step. **(5 marks)**

**Q40.** Write C statements to swap two integers `a` and `b` (a) using a temporary
variable, (b) without a temporary variable. State one risk of method (b).
**(4 marks)**

---

## Section E — Selection statements (Q41–Q50)

**Q41.** Write the syntax of the `if` statement and a program that reads an integer
and prints "Even" if it is even. **(4 marks)**

**Q42.** Differentiate between `if-else` and the `else-if` ladder. When would you use
each? **(4 marks)**

**Q43.** Write a program that reads a mark (0–100) and prints the grade:
A (70–100), B (60–69), C (50–59), D (40–49), E (0–39). Use an `else-if` ladder.
**(6 marks)**

**Q44.** Write a program using **nested if** to find the largest of three numbers.
**(6 marks)**

**Q45.** Write the syntax of a `switch` statement. State three rules/restrictions of
`switch`. **(5 marks)**

**Q46.** Trace the output of this code for `choice = 2`:
```c
switch (choice) {
    case 1: printf("One ");
    case 2: printf("Two ");
    case 3: printf("Three "); break;
    default: printf("Other");
}
```
Explain what happens if `break` is removed from case 3. **(5 marks)**

**Q47.** Explain the difference between `=` and `==`. What is printed by
`if (x = 5) printf("Yes"); else printf("No");` when `x` is 0? **(4 marks)**

**Q48.** Write a program to check whether a year is a leap year. A year is a leap
year if it is divisible by 4 but not by 100, or if it is divisible by 400.
**(5 marks)**

**Q49.** Write a program that reads a character and uses `switch` to determine
whether it is a vowel or a consonant. **(5 marks)**

**Q50.** Trace the output:
```c
int x = 10;
if (x > 5)
    if (x > 15)
        printf("A");
    else
        printf("B");
printf("C");
```
**(4 marks)**

---

## Section F — Loops (Q51–Q60)

**Q51.** Write the syntax of a `while` loop and a program that prints 1 to 5.
**(4 marks)**

**Q52.** Differentiate between `while` and `do-while`. Give one situation where
`do-while` is the better choice. **(4 marks)**

**Q53.** Write the syntax of a `for` loop and a program that prints the sum of
1 to n, where n is entered by the user. **(5 marks)**

**Q54.** Write a program to calculate the factorial of a number n. **(5 marks)**

**Q55.** Write a program to reverse the digits of an integer (e.g. 1234 → 4321).
**(5 marks)**

**Q56.** Write a program to count the digits and find the sum of the digits of an
integer. **(6 marks)**

**Q57.** Write a program to check whether a number is prime. **(6 marks)**

**Q58.** Write a program to print the multiplication table of a number from 1 to 10.
**(4 marks)**

**Q59.** Write a program using nested loops to print:
```
*
**
***
****
*****
```
**(5 marks)**

**Q60.** (a) Trace the output:
```c
for (i = 1; i <= 3; i++) {
    for (j = 1; j <= i; j++)
        printf("%d", j);
    printf("\n");
}
```
(b) State two differences between `break` and `continue`. **(6 marks)**

---

## Section G — Functions and recursion (Q61–Q70)

**Q61.** Define a function. State four advantages of using functions. **(5 marks)**

**Q62.** Differentiate between a function prototype, a function definition and a
function call. Write a complete program using a function `max(a, b)`. **(6 marks)**

**Q63.** Differentiate between actual parameters and formal parameters. **(4 marks)**

**Q64.** Describe the four categories of functions, giving one example of each.
**(8 marks)**

**Q65.** Differentiate between call by value and call by reference. Write a function
that swaps two integers using pointers. **(6 marks)**

**Q66.** Explain local, global and static variables with respect to scope, lifetime
and default value. **(6 marks)**

**Q67.** Define recursion. State the two essential parts of a recursive function and
write a recursive factorial function. **(6 marks)**

**Q68.** Trace the calls made by `factorial(4)` and state the final value.
**(5 marks)**

**Q69.** Write a recursive function for the nth Fibonacci number. Explain why the
naive recursive version is inefficient. **(6 marks)**

**Q70.** Write a recursive function to find the sum of the digits of a number
(e.g. 1234 → 10). **(5 marks)**

---

## Section H — Arrays and strings (Q71–Q80)

**Q71.** Define an array. Write the declaration and initialisation of an array of
five integers. What is the index of the first and last element? **(5 marks)**

**Q72.** Write a program to read 10 integers into an array and print them in reverse.
**(5 marks)**

**Q73.** Write a program to find the sum, average, maximum and minimum of an array.
**(7 marks)**

**Q74.** Explain linear search. Write a program to search for a value in an array and
print its position (or "not found"). **(6 marks)**

**Q75.** Explain bubble sort. Write a program to sort an array in ascending order and
trace it on `{5, 1, 4, 2, 8}`. **(8 marks)**

**Q76.** Write the declaration and initialisation of a 3×4 two-dimensional array.
Write nested loops to read and print it. **(5 marks)**

**Q77.** Write a program to add two 2×2 matrices. **(6 marks)**

**Q78.** Write a program to find the transpose of a 2×3 matrix. **(6 marks)**

**Q79.** Explain how a string is stored in C. Why does `"Hello"` occupy 6 bytes but
have length 5? **(5 marks)**

**Q80.** Write functions to find string length, copy a string, concatenate two strings
and compare two strings **without** using `<string.h>`. **(8 marks)**

---

## Section I — Pointers (Q81–Q86)

**Q81.** Define a pointer. Write the declaration and initialisation of a pointer to an
integer, and explain the operators `&` and `*`. **(5 marks)**

**Q82.** Draw a memory diagram and state the output:
```c
int x = 5;
int *p = &x;
*p = 10;
printf("%d %d", x, *p);
```
**(5 marks)**

**Q83.** Explain pointer arithmetic. If `int *p` points to `a[0]`, what is `p + 2`?
How many bytes does `p + 1` move on a machine where `int` is 4 bytes? **(5 marks)**

**Q84.** Explain the relationship between arrays and pointers. Show that `a[i]` is
equivalent to `*(a + i)`. **(4 marks)**

**Q85.** Write a program that uses a function and pointers to swap two integers.
Explain why call by value alone cannot do this. **(6 marks)**

**Q86.** Explain `malloc`, `calloc`, `realloc` and `free`. Write code to allocate an
array of 5 integers dynamically and free it. **(6 marks)**

---

## Section J — Structures, unions, files and formatting (Q87–Q96)

**Q87.** Define a structure. Write the declaration of a `Student` structure with
name, age and marks, and initialise one variable. **(5 marks)**

**Q88.** Write a program using an array of `Student` structures to read 3 students and
print the student with the highest marks. **(7 marks)**

**Q89.** Explain `typedef` and the `->` operator. Rewrite `(*p).name` using `->`.
**(4 marks)**

**Q90.** Differentiate between a structure and a union. How is the size of each
determined? **(5 marks)**

**Q91.** What is an enumeration? Give an example and state one advantage. **(4 marks)**

**Q92.** Explain the steps of file handling in C: declare a file pointer, open, read/
write, and close. List four file opening modes. **(6 marks)**

**Q93.** Write a program to write three student records to a text file and then read
them back and display them. **(8 marks)**

**Q94.** Predict the output:
```c
printf("[%5d]\n", 42);
printf("[%-5d]\n", 42);
printf("[%05d]\n", 42);
printf("[%.2f]\n", 3.14159);
printf("[%8.2f]\n", 3.14159);
printf("[%.3s]\n", "Hello");
```
**(6 marks)**

**Q95.** State four common `scanf` mistakes and how to fix each. **(4 marks)**

**Q96.** Design a formatted report that prints a table with columns `Name`, `Age` and
`Fee`, using widths and alignment. Write the `printf` statements and one sample row.
**(5 marks)**

---

**Total: 96 questions.** Aim to answer at least 60 before the exam. The starred
high-yield questions are Q1–Q10, Q17, Q25–Q28, Q32–Q38, Q41–Q48, Q51–Q57,
Q61–Q68, Q71–Q75 and Q79–Q80.
