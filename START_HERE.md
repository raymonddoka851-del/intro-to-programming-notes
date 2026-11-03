# STA 121 / CSC 112 — Introduction to Programming
## Complete Exam Revision Pack

This pack was built from:

- `STA 121 COURSE OUTLINE.odt` (the official course map)
- `csc 112 week 1.docx` — programming languages, program development, algorithms
- `csc 112 week 2.docx` — algorithms, flowcharts, pseudocode, decision tables, DFDs
- `WEEK 3 NOTES.docx` — C program structure, variables, data types, operators, I/O
- `week 4 a dn 6.docx` — formatted I/O, operators, control statements, loops, functions
- `week 7 notes.docx` — functions and arrays

The weekly outline stops at structures/unions, but the course description also mentions **number systems, strings, recursion and files**. I have covered those too, because examiners often set them.

> **Language:** All examples are in **C**, because that is the language used throughout your notes and the outline ("C programming format and structure").

---

## 1. What is in this pack

| Folder | File | Use it for |
|---|---|---|
| — | `OPEN_NOTES.bat` | **Start here:** opens the formatted, clickable version of every note in your browser |
| `docs/` | `index.html` | The styled notes site (tables, code colouring, search, print to PDF) |
| — | `START_HERE.md` | Study plan, exam strategy, checklist |
| — | `YOUR_14_DAY_PLAN.md` | Detailed day-by-day plan with minimum pass paths |
| — | `SETUP_AND_RUN.md` | Install or use a C compiler; compile and run programs |
| `notes/` | `01_programming_fundamentals.md` | Definitions, language levels, program development, algorithms, flowcharts, errors |
| `notes/` | `02_c_basics_and_compilation.md` | C structure, compilation, identifiers, comments, first programs |
| `notes/` | `03_data_types_and_number_systems.md` | Bits/bytes, binary/octal/hex, 2's complement, int/float/char, ASCII, casting |
| `notes/` | `04_operators_and_expressions.md` | All operator types, precedence, prefix/postfix, evaluation |
| `notes/` | `05_control_statements.md` | if, if-else, else-if, nested if, switch |
| `notes/` | `06_loops.md` | while, do-while, for, nested loops, break/continue/goto |
| `notes/` | `07_functions_and_recursion.md` | Prototypes, parameters, call by value/reference, scope, recursion |
| `notes/` | `08_arrays_and_strings.md` | 1D/2D arrays, searching, sorting, strings, `string.h` |
| `notes/` | `09_pointers.md` | Addresses, dereferencing, pointer arithmetic, pass-by-reference, dynamic memory |
| `notes/` | `10_structures_unions_files.md` | struct, union, enum, file handling |
| `notes/` | `11_formatted_io_and_reports.md` | `printf`/`scanf` formatting, display/report design |
| — | `CHEAT_SHEET.md` | One-page syntax reference for the last day |
| `code/` | `*.c` | Complete, compilable example programs |
| `practice/` | `ACTUAL_QUIZ_ANSWERS.md` | Model answers to the e-learning quiz questions |
| `practice/` | `QUESTION_BANK.md` | 96 questions by topic |
| `practice/` | `ANSWER_KEY.md` | Answers and explanations |
| `practice/` | `LAB_TASKS.md` | 25 programs to write yourself, easy → hard |
| `practice/` | `MOCK_EXAM_1.md` | Full 70-mark practice paper |
| `practice/` | `MOCK_EXAM_1_MARKING_SCHEME.md` | Marking scheme and model answers |
| `practice/` | `MOCK_EXAM_2.md` | Second full paper |
| `practice/` | `MOCK_EXAM_2_MARKING_SCHEME.md` | Marking scheme and model answers |
| — | `PROGRESS_TRACKER.md` | Tick off topics as you master them |

---

## 2. Course map: outline week → what to master

| Week | Outline topic | Read | You must be able to… |
|---|---|---|---|
| 1 | Introduction to programming methodology | Note 01 | Define program/programming/language; classify languages; list characteristics of a good program; list the 8 development phases; write an algorithm and pseudocode |
| 2 | Compilation; C format and structure | Note 02 | Write and explain the parts of a C program; describe preprocessor → compiler → assembler → linker → loader; list syntax/runtime/logical errors |
| 3–4 | Data types | Note 03 | Convert between number systems; explain bits/bytes/words; signed vs unsigned; `int`, `float`, `double`, `char`; ASCII; casting |
| 5 | CAT ONE | — | Revise weeks 1–4 |
| 6 | Operators | Note 04 | Use arithmetic, relational, logical, bitwise, assignment, increment/decrement, conditional; apply precedence; evaluate expressions |
| 7 | Control statements | Note 05 | Write if, if-else, else-if ladder, nested if, switch; trace output |
| 8 | Looping | Note 06 | Write while, do-while, for, nested loops; use break/continue/goto; trace loops |
| 9 | Arrays | Note 08 | Declare/initialise 1D, 2D and multi-dimensional arrays; search, sort, sum, average, matrix operations |
| 10 | CAT TWO | — | Revise weeks 6–9 |
| 11 | Pointers | Note 09 | Use `&` and `*`; pointer arithmetic; pass by reference; swap; explain pointer–array link |
| 12 | Unions and structures | Note 10 | Define/use structs and unions; array of structs; `typedef`; `->`; file handling basics |

**Also examinable from the course description:** number systems, character codes, strings, recursion, functions, parameter passing, files, report/display design.

---

## 3. The 14-day plan (2–3 hours per day)

If your exam is about two weeks away, follow this. Each day has **read → recall → code → questions**.

| Day | Focus | Tasks |
|---|---|---|
| 1 | Fundamentals | Read Note 01. Memorise the 8 development phases and 6+ characteristics of a good program. Write pseudocode and draw a flowchart for "largest of three numbers". Do Q1–Q10 in the question bank. |
| 2 | C basics + compilation | Read Note 02. Get a compiler working (see §7). Type and run `hello.c`, `add_two.c`, `area_circle.c`. Learn the compilation pipeline. Do Q11–Q20. |
| 3 | Data types + number systems | Read Note 03. Practise 10 decimal↔binary conversions and 5 two's-complement conversions. Run `data_types.c`. Do Q21–Q30. |
| 4 | Operators | Read Note 04. Copy the precedence table from memory. Run `operators.c`. Do Q31–Q40. |
| 5 | Control statements | Read Note 05. Write even/odd, largest of 3, grade program, calculator with `switch`. Do Q41–Q50. |
| 6 | Loops | Read Note 06. Write sum 1..n, factorial, reverse digits, prime check, multiplication table, star triangle. Do Q51–Q60. |
| 7 | Review + mini-test | Re-do every wrong question from days 1–6. Do Sections A–F (Q1–Q60) of `QUESTION_BANK.md` under timed conditions. |
| 8 | Functions | Read Note 07 (first half). Write a function for max of two, factorial, prime check. Learn the four function categories. Do Q61–Q66. |
| 9 | Recursion + parameter passing | Read Note 07 (second half). Trace factorial(5) and Fibonacci(5) by hand. Write swap with pointers. Do Q67–Q70. |
| 10 | 1D arrays | Read Note 08 (first half). Write array input/output, sum/average, max/min, reverse, linear search. Run `array_stats.c` and `bubble_sort.c`. Do Q71–Q75. |
| 11 | 2D arrays + strings | Read Note 08 (second half). Write matrix addition and transpose. Write string length, copy, compare without `string.h`. Do Q76–Q80. |
| 12 | Pointers | Read Note 09. Draw memory diagrams for `int x = 5; int *p = &x;`. Write swap and array traversal with pointers. Do Q81–Q86. |
| 13 | Structures, unions, files, reports | Read Notes 10 and 11. Write a student struct program and a file write/read program. Learn the `union` vs `struct` size question and the report-formatting question. Do Q87–Q96. |
| 14 | Full mock + review | Sit `MOCK_EXAM_1.md` in 2 hours without notes. Mark it with the scheme. Re-do every missed question, then re-read the cheat sheet and your weak notes. |

### If you only have 5 days

| Day | Focus |
|---|---|
| 1 | Note 01 + 02; learn all definitions and the compilation pipeline |
| 2 | Note 03 + 04; number conversions and expression evaluation |
| 3 | Note 05 + 06; write and trace if/loops |
| 4 | Note 07 + 08; functions, recursion, arrays, strings |
| 5 | Notes 09–11 + cheat sheet; one mock exam |

### If you have 48 hours

1. Read `CHEAT_SHEET.md` (30 min).
2. Read Notes 01–06 (4 hours).
3. Do the first 50 question-bank questions (2 hours).
4. Read Notes 07–11 (3 hours).
5. Write 8 programs by hand: even/odd, largest of 3, factorial, reverse digits, prime, array average, string length, struct record (3 hours).
6. Sit Mock 1 and mark it (2.5 hours).
7. Re-read weak sections + sleep.

---

## 4. How to study programming (even alone)

For every example program, use the **P.A.C.E.** method:

1. **Predict** — cover the output and predict what the program prints.
2. **Attempt** — write your version from memory before looking.
3. **Compile/Run** — type it exactly and run it.
4. **Explain** — say aloud what every line does. If you cannot explain a line, you do not know it yet.

When you trace code in the exam, always draw a **variable table**:

| Line | `i` | `sum` | Output |
|---|---|---|---|
| `i=1` | 1 | 0 | |
| `sum+=i` | 1 | 1 | |
| `i++` | 2 | 1 | |

This prevents most lost marks.

---

## 5. Exam strategy (70% written paper)

### Question types and how to answer

| Type | What the examiner wants | Technique |
|---|---|---|
| Define | A precise one- or two-sentence definition | Learn definitions word-for-word, then add an example |
| List / state | The required number of points | Number your points; do not write a paragraph |
| Differentiate | A table with at least 3 clear differences | Draw the table even if not asked |
| Explain | Meaning + how it works + example | Use the phrase "This means that… For example…" |
| Trace output | Exact output, including new lines | Variable table; watch `/` and `%`, prefix/postfix, loop bounds |
| Write a program | Correct, complete, readable code | IPO plan → declare → input → process → output → `return 0;` |
| Debug | Identify the error, explain it, correct it | Name the error type (syntax/runtime/logical) |

### Code-writing recipe (use every time)

1. **I**nput: what data comes in? What types?
2. **P**rocess: what formula/logic?
3. **O**utput: exactly what should be printed?
4. Write declarations.
5. Write input with `scanf` (remember `&`).
6. Write logic.
7. Write output with `printf`.
8. Add `return 0;`.
9. Dry-run with a small example.

### Marks per minute

- 70 marks in 120 minutes ≈ **1.7 minutes per mark**.
- Do the **theory definitions first** (fast marks), then tracing, then the long program.
- If a program is 10 marks, spend at most ~15 minutes.
- Never leave a program blank: declarations, `main`, input and output can earn part marks.

### The 10 mistakes that cost the most marks

1. `if (x = 5)` instead of `if (x == 5)`.
2. Semicolon after `if (...)`, `for (...)`, or `while (...)`.
3. Missing `&` in `scanf("%d", x);`.
4. `5/2` when you meant `5.0/2` (integer division).
5. Using `%` with `float`/`double`.
6. Forgetting `break` in `switch` (fall-through).
7. Array index out of bounds; forgetting arrays start at 0.
8. Missing `'\0'` when building a string by hand.
9. Uninitialised variable used in a calculation.
10. Missing `return 0;` / unbalanced braces.

---

## 6. Must-know checklist

Tick each only when you can do it **without notes**.

### Theory
- [ ] Define program, programming, programming language, algorithm, pseudocode, flowchart
- [ ] Classify programming languages (machine, assembly, high-level) with 2 advantages and 2 disadvantages each
- [ ] Explain compiler vs interpreter (4 differences)
- [ ] List 6 characteristics of a good program
- [ ] List the 8 phases of program development in order
- [ ] Explain syntax, runtime and logical errors with examples
- [ ] Explain sequence, selection and repetition
- [ ] Describe the 5 flowchart symbols and 5 algorithm representations
- [ ] Describe the compilation pipeline (preprocessor, compiler, assembler, linker, loader)

### C language
- [ ] Write the structure of a C program from memory
- [ ] List 5 header files and what they provide
- [ ] State the rules for identifiers and list 10 keywords
- [ ] Explain `#define` vs `const`
- [ ] Convert decimal ↔ binary ↔ octal ↔ hex
- [ ] Explain signed vs unsigned, 2's complement, range of 8-bit numbers
- [ ] Explain `int`, `float`, `double`, `char` (size, format specifier, example)
- [ ] State key ASCII codes (`'A'`, `'a'`, `'0'`, space, newline)
- [ ] Explain implicit conversion and casting
- [ ] Use all operator types; state precedence and associativity
- [ ] Evaluate prefix vs postfix expressions
- [ ] Write if, if-else, else-if, nested if, switch
- [ ] Write while, do-while, for, nested loops
- [ ] Use `break`, `continue`, `goto` correctly
- [ ] Define function, prototype, definition, call, return
- [ ] Explain actual vs formal parameters
- [ ] Explain call by value vs call by reference
- [ ] Explain local vs global vs static scope
- [ ] Write a recursive function with a base case
- [ ] Declare/initialise 1D and 2D arrays
- [ ] Search (linear/binary) and sort (bubble) an array
- [ ] Explain how strings are stored; use `strlen`, `strcpy`, `strcat`, `strcmp`
- [ ] Declare pointers, use `&` and `*`, do pointer arithmetic
- [ ] Explain the link between arrays and pointers
- [ ] Define and use a `struct`, array of structs, `typedef`, `->`
- [ ] Explain `struct` vs `union`
- [ ] Open, write, read and close a text file
- [ ] Format output with width and precision; design a simple report

---

## 7. Running C code (already set up for you)

A C compiler (GCC) is **already installed on this computer**. You do not need to
install anything.

**The easy way:** double-click `RUN_CODE.bat` in this folder, type a program name
(for example `hello.c`), and press Enter. You can also drag any `.c` file from the
`code/` folder onto `RUN_CODE.bat`.

Full instructions, terminal commands and fixes for common compiler errors are in
**`SETUP_AND_RUN.md`**.

**If the local compiler ever fails,** use the online compiler:
<https://www.onlinegdb.com/online_c_compiler> — paste the code and press **Run**.

> Do not spend study time installing IDEs. A compiler plus `RUN_CODE.bat` is enough
> for this exam.

---

## 7b. Reading the notes (nicely formatted)

The `.md` files are **Markdown**. If you double-click one, Word or Notepad opens it
as raw text and you see `#`, `**` and `|` symbols — that is normal, but it is not
meant to be read that way.

**Double-click `OPEN_NOTES.bat`** to read everything the way it is supposed to look:
formatted headings, coloured tables, highlighted C code, a sidebar, search, and a
dark mode. Every page can be saved as a PDF with **Ctrl+P**.

The browser version is generated from the same `.md` files, so the two always match.

---

## 8. A note about what is published

This folder is also a public GitHub repository. Only the revision material is
uploaded: notes, programs, practice questions and the formatted HTML site.

Anything personal stays on your computer and is never committed — exam slips,
screenshots, student emails and two-factor backup codes. `.gitignore` blocks the
common accidents (build outputs, `students.txt` written by `file_records.c`).

---

## 9. Suggested daily routine

| Time | Activity |
|---|---|
| 0:00–0:35 | Read one note section actively (underline, write questions in the margin) |
| 0:35–0:45 | Close the note; write the key syntax/table from memory |
| 0:45–1:30 | Type and run 1–2 programs; change values and predict output |
| 1:30–2:00 | Do practice questions; mark yourself |
| 2:00–2:10 | Write 3 things you learned and 1 thing you still do not understand |

**Start here:** open `YOUR_14_DAY_PLAN.md` and do Day 1. Before anything else, learn
`practice/ACTUAL_QUIZ_ANSWERS.md` — those are the exact e-learning quiz questions.
