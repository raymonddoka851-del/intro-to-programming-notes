# Lab Tasks — 25 Programs to Write Yourself

> **Rules**
>
> - Write each program in C from scratch. Do not copy the notes.
> - Compile with warnings on: `gcc -Wall -Wextra task.c -o task`.
> - Test with the sample input **and** with boundary/invalid input.
> - Keep every program in its own file: `task01.c`, `task02.c`, …
> - Mark yourself with the rubric at the end.
>
> **Difficulty:** Tasks 1–5 beginner · 6–10 loops · 11–15 functions/arrays · 16–20 strings/pointers/structs · 21–25 integrated.

---

## Level 1 — Getting started

### Task 1 — Profile card (10 marks)
**Goal:** practise `printf`, escape sequences and layout.

Write a program that prints a card exactly like this (replace the details with your own):

```text
+----------------------------+
| Name : Ada Lovelace        |
| Course: STA 121            |
| Level : 100                |
| Quote: "First, solve it."  |
+----------------------------+
```

**Requirements:** use `\n`, `\t` and `\"`; the border must line up.
**Hint:** count the characters inside the border; use a fixed width for every line.

---

### Task 2 — Rectangle calculator (10 marks)
**Goal:** input, arithmetic, formatted output.

Read the length and width of a rectangle (decimals allowed). Print:

```text
Enter length and width: 7.5 3
Area      = 22.50
Perimeter = 21.00
```

**Requirements:** use `double`; print 2 decimal places; label the output.
**Hint:** area = length × width; perimeter = 2 × (length + width).

---

### Task 3 — Temperature converter (10 marks)
**Goal:** formulas and float precision.

Read a Celsius temperature and print Fahrenheit and Kelvin:

```text
Celsius: 37
Fahrenheit: 98.60
Kelvin: 310.15
```

**Requirements:** F = C × 9/5 + 32; K = C + 273.15. Use `9.0/5.0`, not `9/5`.
**Hint:** test with 0, 100 and −40 (where F = C).

---

### Task 4 — Even, odd and sign (10 marks)
**Goal:** `if-else` and `%`.

Read an integer and print whether it is even or odd, positive, negative or zero:

```text
Enter an integer: -7
-7 is odd
-7 is negative
```

**Requirements:** handle zero correctly; do not print "positive" for zero.
**Hint:** `n % 2 == 0`; check sign separately.

---

### Task 5 — Grade classifier (10 marks)
**Goal:** `else-if` ladder and validation.

Read a score from 0 to 100 and print the grade (A 70+, B 60–69, C 50–59, D 45–49, E 40–44, F below 40). Reject scores outside 0–100.

```text
Enter score: 67
Grade: B
```

**Requirements:** validate input; print an error for −1 or 120.
**Hint:** test the highest boundary first.

---

## Level 2 — Decisions and loops

### Task 6 — Simple calculator (10 marks)
**Goal:** `switch` and division-by-zero handling.

Read an expression `number operator number` and print the result:

```text
Enter expression: 12.5 * 4
Result = 50.00
```

**Requirements:** support `+ - * /`; reject an unknown operator; handle division by zero.
**Hint:** read with `scanf("%lf %c %lf", &a, &op, &b)`.

---

### Task 7 — Sum and average (10 marks)
**Goal:** `for` loop and accumulation.

Read `n`, then print the sum and average of 1 to `n`:

```text
n = 10
Sum = 55
Average = 5.50
```

**Requirements:** reject `n < 1`; use a loop (do not use the formula).
**Hint:** cast the sum to `double` before dividing.

---

### Task 8 — Multiplication table (10 marks)
**Goal:** nested loops and alignment.

Read `n` and print its table from 1 to 12 in aligned columns:

```text
 7 x  1 =   7
 7 x  2 =  14
 ...
 7 x 12 =  84
```

**Requirements:** right-align the numbers using `%2d` and `%3d`.
**Hint:** one loop is enough for a single table; use two loops to print tables 1–12 side by side (bonus).

---

### Task 9 — Reverse and palindrome (10 marks)
**Goal:** digit extraction with `%` and `/`.

Read a positive integer. Print its reverse and whether it is a palindrome:

```text
Enter a number: 12321
Reverse: 12321
12321 is a palindrome
```

**Requirements:** reject negative input; 120 → reverse 21.
**Hint:** `digit = n % 10; reversed = reversed * 10 + digit; n /= 10;`

---

### Task 10 — Primes in a range (10 marks)
**Goal:** nested loops, flags and `break`.

Read two integers `low` and `high` and print all primes between them, 10 per line:

```text
Range: 10 30
11 13 17 19 23 29
Count = 6
```

**Requirements:** handle `low < 2`; count the primes; print "None" if there are none.
**Hint:** write `is_prime(n)` and call it inside a loop.

---

## Level 3 — Functions and arrays

### Task 11 — Star pyramid (10 marks)
**Goal:** nested loops and pattern logic.

Read the number of rows and print a centred pyramid:

```text
Rows: 4
   *
  ***
 *****
*******
```

**Requirements:** row `i` has `rows - i` spaces and `2*i - 1` stars.
**Hint:** three inner loops (spaces, stars, newline) or two with clever widths.

---

### Task 12 — Function toolkit (10 marks)
**Goal:** prototypes, parameters and return values.

Write and test these functions:

```c
int max3(int a, int b, int c);
long long factorial(int n);
double power(double base, int exp);
int is_even(int n);
```

**Requirements:** each function must have a prototype and a comment; `main` must call each one with at least two test cases.
**Hint:** factorial(0) = 1; power(base, 0) = 1; power(base, −n) = 1 / power(base, n).

---

### Task 13 — Recursive warm-up (10 marks)
**Goal:** base cases and recursive calls.

Write recursive functions for:

1. `sum_digits(n)` — `sum_digits(1234)` → 10
2. `gcd(a, b)` — `gcd(48, 18)` → 6
3. `fib(n)` — `fib(10)` → 55

**Requirements:** each function must have a base case; print a trace for `sum_digits(1234)` in a comment.
**Hint:** `gcd(a,b) = gcd(b, a % b)` with `gcd(a,0) = a`.

---

### Task 14 — Array statistics (10 marks)
**Goal:** 1D arrays and functions.

Read `n` integers (max 100). Print sum, average, maximum, minimum and the array in reverse.

```text
How many? 5
Enter: 12 7 30 5 18
Sum = 72
Average = 14.40
Max = 30
Min = 5
Reversed: 18 5 30 7 12
```

**Requirements:** use separate functions `sum`, `average`, `max`, `min`, `print_reverse`; pass the array **and** its length.
**Hint:** do not use `sizeof` inside a function to find the length.

---

### Task 15 — Search comparison (10 marks)
**Goal:** linear and binary search.

Read a sorted array of `n` integers and a target. Search with **both** algorithms and print the index and number of comparisons:

```text
Array: 2 5 8 12 16 23 38 56
Target: 23
Linear: found at index 5 after 6 comparisons
Binary: found at index 5 after 3 comparisons
```

**Requirements:** report "not found" correctly; binary search must keep `low`, `high`, `mid`.
**Hint:** count a comparison each time you test `a[mid]` or `a[i]`.

---

### Task 16 — Sort and median (10 marks)
**Goal:** bubble sort, swapping and median.

Read `n` integers, sort them with bubble sort, then print the sorted array, the median and the number of swaps.

```text
How many? 6
Enter: 5 1 4 2 8 3
Sorted: 1 2 3 4 5 8
Median: 3.50
Swaps: 9
```

**Requirements:** for even `n`, the median is the average of the two middle values; for odd `n`, it is the middle value.
**Hint:** `median = (a[n/2 - 1] + a[n/2]) / 2.0` for even `n`.

---

## Level 4 — Strings, matrices, pointers, structs

### Task 17 — String toolbox (10 marks)
**Goal:** string traversal without relying only on library functions.

Read a line of text (spaces allowed) and print:

```text
Text: Hello World
Length: 11
Reversed: dlroW olleH
Vowels: 3
Words: 2
Palindrome: No
Uppercase: HELLO WORLD
```

**Requirements:** write your own `my_strlen`, `reverse` and `count_words`; use `fgets`; strip the newline.
**Hint:** for the palindrome, ignore spaces and compare case-insensitively.

---

### Task 18 — Matrix menu (10 marks)
**Goal:** 2D arrays and functions.

Read two 2 × 2 matrices and display:

1. their sum
2. the transpose of the first
3. their product

```text
A:
1 2
3 4
B:
5 6
7 8
A + B:
 6  8
10 12
Transpose of A:
1 3
2 4
A x B:
19 22
43 50
```

**Requirements:** use functions for printing; print each matrix as a table.
**Hint:** product: `c[i][j] += a[i][k] * b[k][j];` with three loops.

---

### Task 19 — Pointer practice (10 marks)
**Goal:** `&`, `*`, pointer arithmetic and pass by reference.

Write a program that:

1. reads two integers and swaps them using a `swap(int *a, int *b)` function;
2. stores 5 integers in an array and prints them using only a pointer (no `a[i]`);
3. prints the sum using a pointer.

```text
Before: x = 10, y = 20
After : x = 20, y = 10
Array : 10 20 30 40 50
Sum   : 150
```

**Requirements:** no array indexing in the traversal; use `*(p + i)` or `*p++`.
**Hint:** after the loop, reset `p = a` before computing the sum.

---

### Task 20 — Student records (10 marks)
**Goal:** `struct`, array of structs and functions.

Define a `Student` structure (name, age, score). Read `n` students and print a table plus the class average and the best student.

```text
How many? 3
Name age score: Alice 20 85
Name age score: Bob 21 62
Name age score: Carol 22 90

NAME             AGE  SCORE
Alice             20  85.00
Bob               21  62.00
Carol             22  90.00
Class average: 79.00
Best: Carol (90.00)
```

**Requirements:** use `typedef`; pass the array to functions; use `->` in at least one function.
**Hint:** return the **index** of the best student, not just the score.

---

## Level 5 — Integrated tasks

### Task 21 — File-backed records (10 marks)
**Goal:** text files with structures.

Extend Task 20:

1. write all records to `students.txt`;
2. close the file;
3. reopen it and read the records back;
4. search for a name entered by the user and print "Found" or "Not found".

**Requirements:** check every `fopen` for `NULL`; use `"w"` then `"r"`; print the number of records read.
**Hint:** write one record per line: `fprintf(fp, "%s %d %.2f\n", ...)`.

---

### Task 22 — Results report (10 marks)
**Goal:** formatted reports.

Read records containing a name and three test scores. Compute total, average and grade. Print a report with a title, underlined headers, aligned columns, a class average and the best student.

```text
            STA 121 RESULTS
----------------------------------------
NAME          T1    T2    T3   TOTAL   AVG  GRADE
Alice         78    85    90     253 84.33      A
Bob           55    62    48     165 55.00      C
...
----------------------------------------
Class average: 68.83
Best student : Charlie (275)
```

**Requirements:** use `%-12s`, `%5d`, `%8.2f`; draw the separator with a loop or a string; use a `grade_of` function.
**Hint:** decide column widths **before** writing the header so everything lines up.

---

### Task 23 — Bank account menu (10 marks)
**Goal:** menu loop, validation and state.

Implement a menu-driven program with an initial balance of 0:

```text
1. Deposit
2. Withdraw
3. Balance
4. Exit
Choice: 2
Amount: 500
Insufficient funds. Balance = 0.00
```

**Requirements:** loop until Exit; reject negative amounts; reject withdrawals larger than the balance; print the balance after every successful operation.
**Hint:** use `do-while` with `switch`; `break` inside `switch` only exits the switch — use a flag or `return` to exit the program.

---

### Task 24 — Inventory manager (10 marks)
**Goal:** struct array with search and totals.

Define an `Item` (name, quantity, unit price). Read up to 50 items, then:

- print all items and the total value of the inventory;
- search for an item by name;
- find the item with the highest total value (`quantity × price`).

**Requirements:** use functions; handle an empty inventory; format money to 2 decimal places.
**Hint:** total value = Σ `quantity * price`; keep the best index.

---

### Task 25 — Mini project: quiz results (10 marks)
**Goal:** combine everything.

Build a program that:

1. stores 5 questions with 4 options each (use arrays of strings);
2. asks the user for a name and the 5 answers (A–D);
3. calculates the score and percentage;
4. assigns a grade;
5. writes the result to `results.txt`;
6. reads the file and prints a small report of all attempts.

**Requirements:** validate answers; use at least three functions; use a structure for one attempt; print a formatted report; free of global variables (except constants).
**Hint:** `char questions[5][100]`, `char options[5][4][50]`, `char key[5] = {'A','C','B','D','A'};`.

---

## Marking rubric (use for every task)

| Criterion | Marks |
|---|---|
| Program compiles without errors or warnings | 2 |
| Correct input and output for the sample | 2 |
| Correct logic, including boundary cases | 3 |
| Readable: names, indentation, comments | 1 |
| Validation / error handling | 1 |
| `return 0;` and clean structure | 1 |
| **Total** | **10** |

### Self-check questions after each task

- [ ] Does it work for the smallest valid input (0, 1, empty)?
- [ ] Does it work for the largest valid input?
- [ ] Does it reject invalid input without crashing?
- [ ] Did you test a negative number where one is not allowed?
- [ ] Is every `scanf` checked or at least every `&` present?
- [ ] Are all loop bounds correct (`<`, not `<=`)?
- [ ] Did you free any dynamic memory?
- [ ] Did you close every file?

### Progress log

| Task | Date | Marks /10 | What went wrong | Redo date |
|---|---|---|---|---|
| 1 | | | | |
| 2 | | | | |
| 3 | | | | |
| 4 | | | | |
| 5 | | | | |
| 6 | | | | |
| 7 | | | | |
| 8 | | | | |
| 9 | | | | |
| 10 | | | | |
| 11 | | | | |
| 12 | | | | |
| 13 | | | | |
| 14 | | | | |
| 15 | | | | |
| 16 | | | | |
| 17 | | | | |
| 18 | | | | |
| 19 | | | | |
| 20 | | | | |
| 21 | | | | |
| 22 | | | | |
| 23 | | | | |
| 24 | | | | |
| 25 | | | | |
