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

Every program was compiled with `gcc -std=c11 -Wall -Wextra -Werror` and run
with a fixed input. The real output of all 22 programs is in
[VERIFIED_OUTPUT.md](VERIFIED_OUTPUT.md) so you can compare it with what you
see on your own machine.

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

## Common mistakes by program

Read the box before you run the program. Each one is a mark you can lose in the exam.

:::mistakes hello.c
- Missing semicolon after `printf(...)`.
- Writing `Printf` or `PRINTF` — C is case-sensitive.
- Forgetting `#include <stdio.h>` or spelling the header wrong.
:::

:::mistakes add_two.c
- `scanf("%d", x);` — the missing `&` is the most common exam error.
- Using `%f` to read an `int`.
- Printing an uninitialised total instead of the sum of the two inputs.
:::

:::mistakes area_circle.c
- `22 / 7 * r * r` uses integer division; write `22.0 / 7.0`.
- Using `%d` for a `double`; use `%f` or `%.2f`.
- Forgetting that `#define PI 3.14159` has no semicolon and no `=`.
:::

:::mistakes data_types.c
- Printing `sizeof` with `%d`; the correct portable specifier is `%zu`.
- Assuming `int` is always 4 bytes on every machine.
- Overflowing a signed type, which is undefined behaviour.
:::

:::mistakes operators.c
- `if (x = 5)` instead of `if (x == 5)`.
- Expecting `5 / 2` to be `2.5` when both operands are integers.
- Assuming `a++` and `++a` give the same value in the same expression.
:::

:::mistakes largest3.c
- Writing `if (a > b > c)`, which compares a boolean with `c`.
- Omitting braces and letting only the first statement belong to the `if`.
- Using `=` inside the condition.
:::

:::mistakes grade_switch.c
- Omitting `break`, so every later case also runs.
- Switching on a `float` or a string, which C does not allow.
- Forgetting `default`, so unexpected marks produce no output.
:::

:::mistakes sum_n.c
- Using `i <= n` when the loop should stop at `n - 1`.
- Forgetting to initialise `sum` to 0.
- Changing the loop counter inside the body as well as in the `for` header.
:::

:::mistakes factorial.c
- Using `int` for factorials above 12; use `long long`.
- Starting the loop at 0, which makes every answer 0.
- Forgetting that `0!` is 1.
:::

:::mistakes reverse_number.c
- Stopping before the last digit, or looping while `n > 0` after `n` becomes 0.
- Forgetting to multiply the reversed value by 10 before adding the digit.
- Ignoring negative input.
:::

:::mistakes prime_check.c
- Testing divisors up to `n` instead of `n / 2` or `sqrt(n)`.
- Treating 0 and 1 as prime.
- Using `break` without a flag, then reporting the wrong conclusion.
:::

:::mistakes star_pyramid.c
- Printing one space too many or too few per row.
- Forgetting the newline at the end of each row.
- Using the row number where the reverse count is needed.
:::

:::mistakes functions.c
- Calling a function before declaring or defining it.
- Using the return value of a `void` function.
- Swapping the argument order at the call site.
:::

:::mistakes recursion.c
- No base case, so the recursion never stops.
- Forgetting `return` on the recursive branch.
- Using naive Fibonacci recursion for large `n`, which explodes exponentially.
:::

:::mistakes array_stats.c
- Looping `i <= n` on an array of `n` elements; the last index is `n - 1`.
- Initialising `max` to 0 when all values can be negative.
- Computing an average with integer division.
:::

:::mistakes bubble_sort.c
- Using `j < n` instead of `j < n - i - 1`, which reads past the end.
- Swapping without a temporary variable.
- Sorting in the wrong direction because the comparison is reversed.
:::

:::mistakes matrix_ops.c
- Multiplying matrices whose inner dimensions do not match.
- Forgetting to reset the accumulator for each output cell.
- Writing `a[j][i]` when the algorithm needs `a[i][j]`.
:::

:::mistakes string_demo.c
- Writing past the null terminator or beyond the array size.
- Comparing strings with `==` instead of `strcmp`.
- Forgetting `#include <ctype.h>` before `toupper` or `isalpha`.
:::

:::mistakes pointer_swap.c
- Swapping the pointer variables instead of the values they point to.
- Dereferencing an uninitialised or NULL pointer.
- Forgetting `&` when passing the addresses of the two integers.
:::

:::mistakes struct_student.c
- Missing the semicolon after the closing brace of a `struct`.
- Using `.` on a pointer instead of `->`.
- Copying a name with `strcpy` without checking the destination size.
:::

:::mistakes file_records.c
- Using the file pointer without checking whether `fopen` returned `NULL`.
- Forgetting `fclose`, so buffered data is not written.
- Opening with `"w"` when you meant to append with `"a"`; `"w"` erases the file.
:::

:::mistakes report_table.c
- Using `%d` for a `double`; use `%f` with a width and precision.
- Forgetting `\n` between rows.
- Lining up headers by eye instead of using field widths.

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
