# Predict the Output

Cover the answer, work it out on paper, then click **Show answer**. If you get it wrong, find the rule in the matching note before moving on. These are the same small traces the written exam uses.

> Tip: draw a variable table for anything with a loop, pointer or recursive call.

## Note 01

Topic: programming fundamentals, algorithms and the C skeleton.

Q> What does this print? `int main(void) { printf("CSC 112"); return 0; }`
A> `CSC 112` with no newline after it.

Q> What is printed? `SET total = 0`, then `FOR i = 1 TO 4` do `total = total + i`, then `PRINT total`.
A> `10` (1 + 2 + 3 + 4).

Q> A program is saved with `int x = "hi";`. Does it compile, and does it print anything?
A> It fails at compile time (type error), so there is no output at all.

Q> Which phase finds a missing semicolon: compilation, linking or execution?
A> Compilation. The compiler reports a syntax error before the program can run.

## Note 02

Topic: C basics, headers, macros and compilation.

Q> What does this print? `printf("A\nB\n");`
A> `A` on the first line and `B` on the second line.

Q> What does `printf("%%d");` print?
A> `%d` — the doubled percent sign prints one literal percent character.

Q> With `#define N 3`, what does `printf("%d", N * N);` print?
A> `9`. The preprocessor substitutes text before the compiler sees it.

Q> What does this print? `int main(void) { printf("Hi"); }`
A> `Hi`. In C99 and later, reaching the end of `main` returns 0 implicitly.

## Note 03

Topic: data types, conversion and number systems.

Q> What is printed by `printf("%d", (int)3.9);`?
A> `3`. Casting to `int` truncates towards zero; it does not round.

Q> What is printed by `char c = 'A'; printf("%d", c);`?
A> `65` — the ASCII code of `A`.

Q> What is printed by `printf("%.2f", 2.0 / 3);`?
A> `0.67`. The division is floating-point because one operand is `2.0`.

Q> What is printed by `unsigned char x = 255; x++; printf("%d", x);`?
A> `0`. An unsigned 8-bit value wraps round to zero.

## Note 04

Topic: operators, precedence, increment and bitwise operations.

Q> After `int a = 5; int b = a++;`, what does `printf("%d %d", a, b);` print?
A> `6 5`. Postfix returns the old value, then `a` is incremented.

Q> What is printed by `printf("%d", 2 + 3 * 4);`?
A> `14`. Multiplication binds tighter than addition.

Q> What is printed by `printf("%d", 5 > 3 && 2 > 4);`?
A> `0`. The first comparison is true but the second is false.

Q> What is printed by `printf("%d", 6 & 3);`?
A> `2`. In binary: `110 & 011 = 010`.

## Note 05

Topic: if, if-else, switch and the conditional operator.

Q> What does this print? `int x = 5; if (x = 0) printf("yes"); else printf("no");`
A> `no`. The assignment stores 0, which is false. This is the classic `=` vs `==` bug.

Q> What does this print? `int x = 2; switch (x) { case 1: printf("A"); break; case 2: printf("B"); case 3: printf("C"); break; default: printf("D"); }`
A> `BC`. Case 2 has no `break`, so execution falls through into case 3.

Q> What is printed by `printf("%d", 10 > 5 ? 1 : 2);`?
A> `1`.

Q> What does this print? `int x = 3; if (x > 2); printf("ok");`
A> `ok`. The semicolon makes the `if` body empty, so the `printf` always runs.

## Note 06

Topic: for, while and do-while loops, break and continue.

Q> What does this print? `for (int i = 0; i < 3; i++) printf("%d", i);`
A> `012`.

Q> What does this print? `int i = 0; while (i < 3) { printf("%d", i); i++; }`
A> `012`.

Q> What does this print? `int i = 0; do { printf("%d", i); i++; } while (i < 0);`
A> `0`. A do-while always runs its body at least once.

Q> What does this print? `for (int i = 0; i < 5; i++) { if (i == 2) continue; printf("%d", i); }`
A> `0134`. `continue` skips only the rest of that iteration.

## Note 07

Topic: functions, parameters, scope, static storage and recursion.

Q> What does this print? `void f(int x) { x = 9; } int main(void) { int a = 1; f(a); printf("%d", a); }`
A> `1`. C passes arguments by value; `f` changes its own copy.

Q> What does `fact(3)` return for `int fact(int n) { return n <= 1 ? 1 : n * fact(n - 1); }`?
A> `6` (3 x 2 x 1).

Q> What does this print? `void f(void) { static int n = 0; n++; printf("%d", n); } int main(void) { f(); f(); }`
A> `12`. A `static` local keeps its value between calls.

Q> What does this print? `int f(void); int main(void) { printf("%d", f()); } int f(void) { return 4; }`
A> `4`. The prototype lets `main` call `f` before its definition.

## Note 08

Topic: one-dimensional arrays, two-dimensional arrays and strings.

Q> What is printed by `int a[3] = {1, 2, 3}; printf("%d", a[1]);`?
A> `2`. Array indexing starts at 0.

Q> What is printed by `char s[] = "C"; printf("%d", (int)strlen(s));`?
A> `1`. `strlen` counts characters before the terminating `'\0'`.

Q> What is printed by `char s[5] = "abcd"; printf("%d", s[4]);`?
A> `0`. The fifth byte holds the null terminator.

Q> What is printed by `int a[3] = {1, 2}; printf("%d", a[2]);`?
A> `0`. Remaining elements of a partly initialised array are zero.

## Note 09

Topic: addresses, pointers, dereferencing and pointer arithmetic.

Q> What does this print? `int a = 5; int *p = &a; *p = 7; printf("%d", a);`
A> `7`. `*p` names the same memory as `a`.

Q> What is printed by `int a[3] = {10, 20, 30}; int *p = a; printf("%d", *(p + 1));`?
A> `20`. Pointer arithmetic moves in units of the pointed-to type.

Q> What does this print? `void swap(int x, int y) { int t = x; x = y; y = t; } int main(void) { int a = 1, b = 2; swap(a, b); printf("%d %d", a, b); }`
A> `1 2`. Swapping the copies does not change the originals; pass addresses to fix it.

Q> What is printed by `int a = 3; int *p = &a; printf("%d", *p + 1);`?
A> `4`. Dereference first, then add one.

## Note 10

Topic: structures, unions and files.

Q> What does this print? `struct P { int x; }; struct P p = {5}; struct P *q = &p; q->x = 8; printf("%d", p.x);`
A> `8`. `q->x` is the same member as `p.x`.

Q> With `union U { int i; char c; }; union U u; u.c = 'A';`, what does `printf("%d", u.i);` show on this machine?
A> `65` on a little-endian machine: the first byte of the union holds `'A'`.

Q> What does this print? `FILE *f = fopen("x.txt", "w"); if (!f) printf("no"); else { printf("yes"); fclose(f); }`
A> `yes` if the folder is writable; `no` if `fopen` fails.

Q> With `struct S { int n; } a[2] = {{1}, {2}};`, what is `a[1].n`?
A> `2`.

## Note 11

Topic: formatted input/output, field widths and reports.

Q> What is printed by `printf("%5d|", 42);`?
A> `   42|` — the number is right-aligned in a field five characters wide.

Q> What is printed by `printf("%-5d|", 42);`?
A> `42   |` — the minus sign left-aligns the field.

Q> What is printed by `printf("%.3f", 3.14159);`?
A> `3.142` — three digits after the decimal point, rounded.

Q> What is printed by `printf("%04d", 7);`?
A> `0007` — zero-padded to four characters.
