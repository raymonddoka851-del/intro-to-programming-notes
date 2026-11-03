# Your 14-Day CSC 112 / STA 121 Plan (from zero)

**Start:** Wednesday 4 November 2026 (Day 1)
**Assumed exam window:** from Wednesday 18 November 2026
**Daily time:** 2 hours 15 minutes core + 30 minutes optional coding
**Rule:** if a day goes badly, do the **Minimum Pass Path** at the bottom of that day.
Never skip two days in a row.

> If your exam date is different, keep the **order** of the days and compress or
> stretch the review days. Do not skip Days 1–6: they carry most of the easy marks.

---

## How every day works

| Block | Time | What you do |
|---|---|---|
| **1. Learn** | 40 min | Read the day's note with a pen. Write the headings and key words in a rough notebook. |
| **2. Do** | 55 min | Type and run the day's programs. Change values and predict the output before running. |
| **3. Recall** | 30 min | Close everything. Write the day's definitions/syntax from memory. Then do the questions and mark yourself. |
| **4. Optional** | 30 min | Rewrite one program on paper, without the computer. This is what the exam actually tests. |

**Materials each day:** this pack, a notebook, a pen, and a C compiler
(see `SETUP_AND_RUN.md`). If the compiler fails, use
<https://www.onlinegdb.com/online_c_compiler> — do not lose time installing things.

---

## Day 1 — What programming is + the quiz answers

**Goal:** answer every question in the e-learning quiz confidently.

- [ ] Read `practice/ACTUAL_QUIZ_ANSWERS.md` (all 24 answers). Say each answer aloud.
- [ ] Read `notes/01_programming_fundamentals.md` sections 1–4.
- [ ] In your notebook, write from memory: program, programming, programming
      language, compiler, interpreter, algorithm.
- [ ] Write the **8 phases of program development** in order, from memory.
- [ ] Do the rapid self-test table at the end of `ACTUAL_QUIZ_ANSWERS.md`.
- [ ] Attempt the e-learning quiz. Screenshot any question you did not know.

**You pass the day if:** you score 18/24 or better on the self-test.

**Minimum pass path:** learn answers 1–9 and 10–15 only. Those are the most likely
quiz questions.

---

## Day 2 — Your first C program + how code becomes a program

**Goal:** compile and run a program without help, and explain the compilation pipeline.

- [ ] Read `notes/02_c_basics_and_compilation.md` sections 1–7.
- [ ] Follow `SETUP_AND_RUN.md` and run `code/hello.c`.
- [ ] Type `code/add_two.c` yourself (do not copy-paste) and run it. Then change it to
      multiply the two numbers.
- [ ] Run `code/area_circle.c`. Break it on purpose: remove a semicolon, compile, read
      the error message, then fix it.
- [ ] Write the pipeline from memory:
      `.c → preprocessor → compiler → assembler → object file → linker → .exe → loader`.
- [ ] Learn the difference between **syntax**, **runtime** and **logical** errors with
      one example of each.
- [ ] Do Question Bank Q11–Q20.

**You pass the day if:** you can write the skeleton of a C program from memory
(`#include`, `main`, braces, `printf`, `return 0;`) and name the 5 pipeline stages.

**Minimum pass path:** run `hello.c`; memorise the program skeleton and the three
error types.

---

## Day 3 — Data types and number systems

**Goal:** choose the right type for a variable and convert between number bases.

- [ ] Read `notes/03_data_types_and_number_systems.md` sections 1–4 and 6–7.
- [ ] Run `code/data_types.c`. Write down the size in bytes of `char`, `int`, `float`,
      `double` on your machine.
- [ ] Convert these to binary by hand: 13, 25, 50, 100, 127. Check with a calculator.
- [ ] Convert these to hexadecimal: 10, 15, 16, 31, 255.
- [ ] Write −5 in 8-bit two's complement (invert bits, add 1 → `11111011`).
- [ ] Learn ASCII: `'A'`=65, `'a'`=97, `'0'`=48, `'\0'`=0, `'\n'`=10.
- [ ] Do Question Bank Q21–Q30.

**You pass the day if:** you can explain `int`, `float`, `double`, `char` (size,
format specifier, example) and do 5 decimal→binary conversions without help.

**Minimum pass path:** learn the four basic types and ASCII values; do 3 conversions.

---

## Day 4 — Operators and expression evaluation

**Goal:** evaluate any expression the examiner gives you, including `++`/`--`.

- [ ] Read `notes/04_operators_and_expressions.md` sections 1–8 and 10.
- [ ] Copy the precedence table into your notebook **from memory**, then check.
- [ ] Run `code/operators.c`. Before running, predict every line.
- [ ] Do these by hand, then check:
      `5 + 3 * 2`, `(5 + 3) * 2`, `7 / 2`, `7 / 2.0`, `7 % 2`, `10 > 5 && 3 < 2`,
      `!0`, `5 & 3`, `5 | 3`, `5 ^ 3`, `5 << 1`.
- [ ] Prefix/postfix drill: if `a = 5`, find `a` and `b` for `b = a++` and
      `b = ++a`.
- [ ] Do all 20 evaluation drills in Note 04.

**You pass the day if:** you get 16/20 drills right.

**Minimum pass path:** integer division, `%`, `&&`/`||`, and prefix vs postfix.

---

## Day 5 — Decisions: `if`, `else`, `switch`

**Goal:** write and trace any selection program.

- [ ] Read `notes/05_control_statements.md` sections 2–6.
- [ ] Run `code/largest3.c` and `code/grade_switch.c`.
- [ ] Write from scratch (on paper first, then run):
      1. even or odd;
      2. largest of three numbers;
      3. grade A–F using an `else-if` ladder;
      4. a simple calculator using `switch`.
- [ ] Trace the `switch` example in Note 05 with a variable table. Then remove a
      `break` and predict the new output.
- [ ] Do Question Bank Q41–Q50.

**You pass the day if:** you can write the largest-of-three program on paper with no
notes and trace a nested `if` correctly.

**Minimum pass path:** `if-else` and one `switch`; memorise the `=` vs `==` trap.

---

## Day 6 — Loops

**Goal:** write and trace `while`, `do-while`, `for`, and nested loops.

- [ ] Read `notes/06_loops.md` sections 1–7.
- [ ] Run `code/sum_n.c`, `code/factorial.c`, `code/reverse_number.c`,
      `code/prime_check.c`, `code/star_pyramid.c`.
- [ ] Write from scratch: sum 1..n, factorial, reverse digits, count digits, prime
      check, multiplication table, star triangle.
- [ ] Trace this by hand and write the output:
      `for (i = 1; i <= 3; i++) for (j = 1; j <= i; j++) printf("%d", j);`
- [ ] Learn the difference between `break` and `continue` with one example each.
- [ ] Do Question Bank Q51–Q60.

**You pass the day if:** you can write factorial and reverse-digits from memory and
trace a nested loop without losing count.

**Minimum pass path:** `for` and `while`, sum 1..n, factorial, and the meaning of
`break`.

---

## Day 7 — Review + half mock (this is the turning point)

**Goal:** find out what you actually know before moving to harder topics.

- [ ] Re-do every question you got wrong on Days 1–6.
- [ ] Write the cheat sheet sections 1–6 from memory
      (definitions, C skeleton, data types, operators, selection, loops).
- [ ] Do **Mock Exam 1, Sections A and B only**, in 60 minutes, without notes.
- [ ] Mark it with `practice/MOCK_EXAM_1_MARKING_SCHEME.md`.
- [ ] Write the three topics you are weakest in. They get 20 extra minutes tomorrow.

**Target:** 60% on Sections A and B. Below 50%: repeat Day 6 tomorrow morning before
starting Day 8.

---

## Day 8 — Functions

**Goal:** write, call and explain functions, including parameter passing.

- [ ] Read `notes/07_functions_and_recursion.md` sections 1–7.
- [ ] Run `code/functions.c`.
- [ ] Write from scratch: `max(a,b)`, `isEven(n)`, `factorial(n)` (loop version),
      `power(base, exp)`.
- [ ] Learn the **four categories** of functions (no args/no return, no args/return,
      args/no return, args/return) with one example each.
- [ ] Explain actual vs formal parameters, local vs global vs static variables.
- [ ] Do Question Bank Q61–Q66.

**You pass the day if:** you can write a complete program with a prototype, a
definition and a call, and explain call by value.

**Minimum pass path:** one function that takes arguments and returns a value; the
four categories.

---

## Day 9 — Recursion and call by reference

**Goal:** trace recursive calls and swap two variables with pointers.

- [ ] Read `notes/07_functions_and_recursion.md` section 8.
- [ ] Run `code/recursion.c`.
- [ ] Trace `factorial(5)` and `fibonacci(5)` on paper, showing every call and return.
- [ ] Write the base case and recursive case for factorial, Fibonacci, sum 1..n, and
      power.
- [ ] Run `code/pointer_swap.c`; then write `swap(int *a, int *b)` from memory.
- [ ] Do Question Bank Q67–Q70.

**You pass the day if:** you can trace `factorial(4)` without notes and explain why
recursion needs a base case.

**Minimum pass path:** factorial recursion and the idea of a base case.

---

## Day 10 — One-dimensional arrays

**Goal:** store, read, search, reverse, sum and sort an array.

- [ ] Read `notes/08_arrays_and_strings.md` sections 1–4.
- [ ] Run `code/array_stats.c` and `code/bubble_sort.c`.
- [ ] Write from scratch: read 10 numbers; print sum, average, max, min; print in
      reverse; linear search for a value.
- [ ] Trace bubble sort on `{5, 1, 4, 2, 8}` after each pass.
- [ ] Learn: arrays start at 0; no bounds checking; `sizeof(a)/sizeof(a[0])` gives
      the number of elements.
- [ ] Do Question Bank Q71–Q75.

**You pass the day if:** you can write array input/output, max/min and linear search
without notes.

**Minimum pass path:** declare/initialise an array, loop through it, compute the
average.

---

## Day 11 — 2D arrays and strings

**Goal:** handle matrices and C strings.

- [ ] Read `notes/08_arrays_and_strings.md` sections 5–7.
- [ ] Run `code/matrix_ops.c` and `code/string_demo.c`.
- [ ] Write from scratch: matrix addition, matrix transpose, and string length
      **without** `strlen`.
- [ ] Learn `strlen`, `strcpy`, `strcat`, `strcmp` and the `'\0'` terminator.
- [ ] Explain why `"Hello"` occupies 6 bytes but has length 5.
- [ ] Do Question Bank Q76–Q80.

**You pass the day if:** you can write a nested loop for a 2D array and a manual
`strlen` function.

**Minimum pass path:** matrix input/output and `strlen`/`strcpy` usage.

---

## Day 12 — Pointers

**Goal:** use `&` and `*` without fear; explain the pointer–array link.

- [ ] Read `notes/09_pointers.md` sections 1–5.
- [ ] Run `code/pointer_swap.c`.
- [ ] Draw memory diagrams for:
      `int x = 5; int *p = &x; *p = 10;`
- [ ] Write from scratch: print a variable's value and address; change a variable
      through a pointer; traverse an array with `*(a + i)`.
- [ ] Learn: `a[i]` is the same as `*(a + i)`; `p + 1` moves by the size of the type.
- [ ] Do Question Bank Q81–Q86.

**You pass the day if:** you can explain `&`, `*`, and why `swap(&x, &y)` changes
the caller's variables.

**Minimum pass path:** declare a pointer, print `*p`, and pass a pointer to a function.

---

## Day 13 — Structures, unions and files (+ formatting)

**Goal:** define a record, use an array of records, and read/write a text file.

- [ ] Read `notes/10_structures_unions_files.md` sections 1–4.
- [ ] Run `code/struct_student.c` and `code/file_records.c`.
- [ ] Write from scratch: a `Student` struct (name, age, marks); read 3 students;
      print the best student.
- [ ] Learn `struct` vs `union` (memory sharing, size), `.` vs `->`, `typedef`.
- [ ] Learn the file modes `"r"`, `"w"`, `"a"` and the functions `fopen`, `fprintf`,
      `fscanf`, `fgets`, `fclose`; always check `fopen` for `NULL`.
- [ ] Read `notes/11_formatted_io_and_reports.md` sections 2–5; run
      `code/report_table.c`.
- [ ] Do Question Bank Q87–Q96.

**You pass the day if:** you can define a struct and write a complete file
write-then-read program.

**Minimum pass path:** struct definition + one file write/read; `%5d` and `%.2f`.

---

## Day 14 — Full mock, weak spots, cheat sheet

**Goal:** exam conditions, then calm review. No new topics today.

- [ ] Sit `practice/MOCK_EXAM_1.md` (or Mock 2 if you already did Mock 1) in
      2 hours, no notes, no phone.
- [ ] Mark it honestly with the marking scheme. Write your score and lost marks by
      topic.
- [ ] Re-read `CHEAT_SHEET.md` twice.
- [ ] Re-write from memory: the C skeleton, the 8 phases, the precedence table, the
      three loop forms, and the array/string/pointer one-liners.
- [ ] Pack: pen, ruler (for flowcharts), student ID, water. Sleep early.

**Target:** 50/70 (71%). Below 40/70: spend the evening on the two topics where you
lost the most marks — do not start a new topic.

---

## The 10 marks you must never lose

1. Define **program**, **programming**, **algorithm**, **compiler**, **interpreter**.
2. List the **8 phases of program development** in order.
3. Write the **C program skeleton** correctly.
4. Explain **syntax vs runtime vs logical** errors.
5. Convert decimal ↔ binary and do **two's complement**.
6. **Trace** a loop with a variable table.
7. Write **if-else** and **switch** correctly (no `=` for `==`, no `;` after `if`).
8. Write a **for** loop and a **while** loop without an infinite loop.
9. Write a **function** with a prototype, parameters and `return`.
10. Write **array input/output** and compute sum/average/max.

If you can do only these ten, you have a strong pass.

---

## What "understanding" looks like (not just memorising)

For every program, answer these four questions:

1. **What goes in?** (inputs and their types)
2. **What happens to it?** (the logic, step by step)
3. **What comes out?** (exact output, including new lines)
4. **What could go wrong?** (wrong type, divide by zero, index out of bounds,
   missing `&`, missing `break`)

If you can explain a program to a friend without looking, you understand it.

---

## Progress rules

- Tick a day only when you have done the **Recall** block, not just read the note.
- Keep an **error notebook**: every compile error and every wrong answer, with the
  correction. Re-read it on Days 7, 12 and 14.
- A score below 50% is information, not failure. It tells you what to review tonight.
- Sleep is part of revision. Do not study past midnight before an exam.
