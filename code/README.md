# Code Examples

All programs are standard C (C99 or later) and compile with:

```bash
gcc -Wall -Wextra program.c -o program
```

Run:

```bash
./program          # Linux / macOS
program.exe        # Windows
```

Or paste any file into <https://www.onlinegdb.com/online_c_compiler> and press **Run**.

## Index

| File | Topic | What it demonstrates |
|---|---|---|
| `hello.c` | C basics | Minimal program, `printf`, `return 0` |
| `add_two.c` | Input/output | `scanf`, `&`, integer addition |
| `area_circle.c` | Data types | `double`, `#define`, formatted output |
| `data_types.c` | Data types | Sizes, ranges, ASCII, integer division, `sizeof` |
| `operators.c` | Operators | Arithmetic, relational, logical, bitwise, prefix/postfix |
| `largest3.c` | Selection | `if-else if`, logical AND |
| `grade_switch.c` | Selection | `switch`, `break`, `default` |
| `sum_n.c` | Loops | `for`, accumulation |
| `factorial.c` | Loops | `for`, `long long` |
| `reverse_number.c` | Loops | `while`, `%`, `/` |
| `prime_check.c` | Loops | `for`, `break`, flag |
| `star_pyramid.c` | Nested loops | Rows, spaces, stars |
| `functions.c` | Functions | Prototypes, four categories, parameters |
| `recursion.c` | Recursion | Factorial, Fibonacci, digit sum, GCD, power |
| `array_stats.c` | 1D arrays | Input, sum, average, max, min, reverse |
| `bubble_sort.c` | Arrays | Bubble sort, swapping |
| `matrix_ops.c` | 2D arrays | Addition, multiplication, transpose |
| `string_demo.c` | Strings | Length, reverse, palindrome, vowels, uppercase |
| `pointer_swap.c` | Pointers | Call by value vs call by reference, pointer arithmetic |
| `struct_student.c` | Structures | `typedef struct`, array of structs, `->` |
| `file_records.c` | Files | `fopen`, `fprintf`, `fscanf`, `fclose` |
| `report_table.c` | Formatting | Width, precision, aligned report, totals |

## Suggested order

1. `hello.c` → `add_two.c` → `area_circle.c`
2. `data_types.c` → `operators.c`
3. `largest3.c` → `grade_switch.c`
4. `sum_n.c` → `factorial.c` → `reverse_number.c` → `prime_check.c` → `star_pyramid.c`
5. `functions.c` → `recursion.c`
6. `array_stats.c` → `bubble_sort.c` → `matrix_ops.c` → `string_demo.c`
7. `pointer_swap.c` → `struct_student.c`
8. `file_records.c` → `report_table.c`

For every program: **predict the output first**, then run it, then change one thing and predict again.
