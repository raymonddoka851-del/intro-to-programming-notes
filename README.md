<div align="center">

# Introduction to Programming

### CSC 112 / STA 121 — complete revision pack

**11 illustrated notes · 22 runnable C programs · 96 practice questions · 2 mock exams**

[![Read online](https://img.shields.io/badge/%F0%9F%93%96_Read_online-2456d6?style=for-the-badge)](https://raymonddoka851-del.github.io/intro-to-programming-notes/)
[![14-day plan](https://img.shields.io/badge/%F0%9F%97%93_14--day_plan-6d4aff?style=for-the-badge)](https://raymonddoka851-del.github.io/intro-to-programming-notes/YOUR_14_DAY_PLAN.html)

![Language](https://img.shields.io/badge/language-C-00599C?style=flat-square&logo=c&logoColor=white)
![Course](https://img.shields.io/badge/course-CSC%20112%20%2F%20STA%20121-2456d6?style=flat-square)
![Notes](https://img.shields.io/badge/notes-11-0f7b4f?style=flat-square)
![Programs](https://img.shields.io/badge/programs-22-0f7b4f?style=flat-square)
![Questions](https://img.shields.io/badge/questions-96-0f7b4f?style=flat-square)

</div>

---

## Why this exists

I started this course with **zero programming experience**. These are the notes I
wished someone had handed me: plain-language explanations, worked examples in C,
and the exact questions that come up in the e-learning quiz and the final paper.

Everything is written for a beginner — no "obviously" and no skipped steps.

## Read it online (nothing to install)

👉 **<https://raymonddoka851-del.github.io/intro-to-programming-notes/>**

The site has search, a sidebar, dark mode and print-to-PDF. It works on a phone,
which is the point: revise on the bus.

## What is inside

| Folder | What you get |
|---|---|
| `notes/` | 11 notes covering every outline week, with diagrams, tables and C examples |
| `code/` | 22 complete programs — every one compiles with `-Wall -Wextra` and runs |
| `practice/` | 96-question bank, full answer key, 25 lab tasks, 2 mock exams + marking schemes |
| `docs/` | The formatted HTML site that GitHub Pages serves |
| `CHEAT_SHEET.md` | One-page syntax reference for the last day |
| `YOUR_14_DAY_PLAN.md` | Day-by-day plan with a minimum-pass path for bad days |

## Start in three steps

1. **Read the plan** — [`YOUR_14_DAY_PLAN.md`](YOUR_14_DAY_PLAN.md). It is 14 days,
   about 2 hours a day, and it tells you exactly what to do each day.
2. **Learn the quiz answers first** —
   [`practice/ACTUAL_QUIZ_ANSWERS.md`](practice/ACTUAL_QUIZ_ANSWERS.md). The
   e-learning quiz keeps your highest grade, so these are the cheapest marks.
3. **Compile something today** — open `code/hello.c`, build it, change it, break it.

```bash
gcc -std=c11 -Wall -Wextra code/hello.c -o hello
./hello
```

On Windows there is a one-click `RUN_CODE.bat`, and `SETUP_AND_RUN.md` explains the
whole toolchain (including the online compiler if GCC is not installed).

## Topics covered

| Week | Topic | Note |
|---|---|---|
| 1 | Programming languages, program development, algorithms | [01](notes/01_programming_fundamentals.md) |
| 2 | Compilation, C program structure, errors | [02](notes/02_c_basics_and_compilation.md) |
| 3 | Data types, number systems, ASCII, casting | [03](notes/03_data_types_and_number_systems.md) |
| 4 | Operators, precedence, expressions | [04](notes/04_operators_and_expressions.md) |
| 5–6 | Selection: `if`, `else-if`, `switch` | [05](notes/05_control_statements.md) |
| 7 | Iteration: `while`, `do-while`, `for`, `goto` | [06](notes/06_loops.md) |
| 8 | Functions, scope, recursion | [07](notes/07_functions_and_recursion.md) |
| 9 | Arrays (1D/2D), searching, sorting, strings | [08](notes/08_arrays_and_strings.md) |
| 10 | Pointers, pointer arithmetic, dynamic memory | [09](notes/09_pointers.md) |
| 11 | Structures, unions, enums, files | [10](notes/10_structures_unions_files.md) |
| — | Formatted I/O and report design | [11](notes/11_formatted_io_and_reports.md) |

## Repository layout

```text
.
├── notes/            11 Markdown notes (the source of truth)
├── code/             22 C programs, one per idea
├── practice/         question bank, answer key, labs, mock exams
├── docs/             generated HTML site (GitHub Pages)
│   └── _build.ps1    regenerates docs/ from the Markdown
├── RUN_CODE.bat      compile + run any .c file on Windows
└── OPEN_NOTES.bat    open the formatted notes locally
```

The Markdown files are the source. `docs/` is generated from them, so the website
and the notes can never disagree.

## Rebuilding the site

```powershell
powershell -ExecutionPolicy Bypass -File ".\docs\_build.ps1"
```

It reads every `.md` file and rewrites `docs/` in about 15 seconds. No dependencies:
no Node, no Python, no Pandoc.

### Publishing an update

Edit a `.md` file, rebuild the site, then push. The live site refreshes about a
minute after the push.

```powershell
powershell -ExecutionPolicy Bypass -File ".\docs\_build.ps1"
git add -A
git commit -m "docs: fix a typo in note 06"
git push
```

If `git` is not on your `PATH`, use the full path to `git.exe`, or open the folder
in VS Code and use the Source Control panel (the branch icon in the sidebar):
type a message, press **Commit**, then **Sync Changes**.

## Contributing

Found a mistake? Open an issue or send a pull request — corrections to the notes and
extra practice questions are welcome. If you are in the same course, your past
papers are gold.

---

<div align="center">
<sub>Written while learning the same material. If it helped you, star the repo ⭐</sub>
</div>
