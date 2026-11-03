# Note 03 — Data Types, Number Systems & Information Storage

> **Covers outline Weeks 3–4** (data types) plus the number-systems and storage part of the course description.

---

## 1. How computers store information

### 1.1 Units

| Unit | Size | Notes |
|---|---|---|
| **Bit** | 1 binary digit (0 or 1) | Smallest unit |
| **Nibble** | 4 bits | One hexadecimal digit |
| **Byte** | 8 bits | Smallest addressable unit; stores one character |
| **Word** | CPU-dependent (16, 32 or 64 bits) | The natural unit the CPU processes at once |
| **Kilobyte (KB)** | 1024 bytes = 2¹⁰ | In strict computing terms |
| **Megabyte (MB)** | 1024 KB = 2²⁰ bytes | |
| **Gigabyte (GB)** | 1024 MB = 2³⁰ bytes | |
| **Terabyte (TB)** | 1024 GB = 2⁴⁰ bytes | |

> **Exam note:** drive manufacturers often use 1 KB = 1000 bytes, which is why a "500 GB" disk shows less in Windows. In this course, use **1024**.

### 1.2 Why binary?

A computer's circuits have two stable states: **on/off**, **high/low voltage**, **1/0**. Binary maps directly onto this. Everything — numbers, text, images, sound — is ultimately stored as bits.

---

## 2. Number systems

| System | Base | Digits | C prefix | Example |
|---|---|---|---|---|
| Binary | 2 | 0, 1 | `0b` (C23/GCC extension) | `0b1011` |
| Octal | 8 | 0–7 | `0` (leading zero) | `013` = 11 decimal |
| Decimal | 10 | 0–9 | none | `13` |
| Hexadecimal | 16 | 0–9, A–F | `0x` or `0X` | `0xD` = 13 decimal |

**Why octal and hex?** They are compact shorthand for binary: 1 octal digit = 3 bits; 1 hex digit = 4 bits.

### 2.1 Positional notation

In base *b*, the value of a digit string is:

```
dₙ × bⁿ + ... + d₂ × b² + d₁ × b¹ + d₀ × b⁰
```

**Example:** `1011₂ = 1×8 + 0×4 + 1×2 + 1×1 = 11₁₀`

### 2.2 Binary → decimal

Multiply each bit by its place value (powers of 2 from the right), then add.

```
1 0 1 1 0 1
│ │ │ │ │ └── 1 × 2⁰ = 1
│ │ │ │ └──── 0 × 2¹ = 0
│ │ │ └────── 1 × 2² = 4
│ │ └──────── 1 × 2³ = 8
│ └────────── 0 × 2⁴ = 0
└──────────── 1 × 2⁵ = 32
Total = 45
```

**With a fractional part:** `1011.101₂`

```
1×8 + 0×4 + 1×2 + 1×1 + 1×0.5 + 0×0.25 + 1×0.125
= 8 + 0 + 2 + 1 + 0.5 + 0 + 0.125
= 11.625₁₀
```

### 2.3 Decimal → binary (repeated division by 2)

Divide by 2 repeatedly; record the remainders; read **bottom to top**.

**Example: 45**

| Division | Quotient | Remainder |
|---|---|---|
| 45 ÷ 2 | 22 | **1** |
| 22 ÷ 2 | 11 | **0** |
| 11 ÷ 2 | 5 | **1** |
| 5 ÷ 2 | 2 | **1** |
| 2 ÷ 2 | 1 | **0** |
| 1 ÷ 2 | 0 | **1** |

Read upwards: **101101₂**.

**Fractional part: repeated multiplication by 2**

0.625 × 2 = **1**.25 → digit 1
0.25 × 2 = **0**.50 → digit 0
0.50 × 2 = **1**.00 → digit 1
→ `0.101₂`

So `45.625 = 101101.101₂`.

### 2.4 Binary ↔ octal (group 3 bits)

From the decimal point outward, group bits in threes:

```
101101₂ → 101 101 → 5 5 → 55₈
```

Reverse: each octal digit becomes 3 bits. `734₈ → 111 011 100 → 111011100₂`.

### 2.5 Binary ↔ hexadecimal (group 4 bits)

```
101101₂ → 0010 1101 → 2 D → 2D₁₆
```

Reverse: each hex digit becomes 4 bits. `0x2F → 0010 1111 → 00101111₂`.

### 2.6 Decimal ↔ hexadecimal

Repeated division by 16, or convert via binary.

**Example: 305**

| Division | Quotient | Remainder |
|---|---|---|
| 305 ÷ 16 | 19 | **1** |
| 19 ÷ 16 | 1 | **3** |
| 1 ÷ 16 | 0 | **1** |

Read upwards: **0x131** = 1×256 + 3×16 + 1 = 305. ✓

**Hex digits:** 0–9 then A=10, B=11, C=12, D=13, E=14, F=15.

### 2.7 Quick conversion table (memorise 0–15)

| Decimal | Binary | Octal | Hex |
|---|---|---|---|
| 0 | 0000 | 0 | 0 |
| 1 | 0001 | 1 | 1 |
| 2 | 0010 | 2 | 2 |
| 3 | 0011 | 3 | 3 |
| 4 | 0100 | 4 | 4 |
| 5 | 0101 | 5 | 5 |
| 6 | 0110 | 6 | 6 |
| 7 | 0111 | 7 | 7 |
| 8 | 1000 | 10 | 8 |
| 9 | 1001 | 11 | 9 |
| 10 | 1010 | 12 | A |
| 11 | 1011 | 13 | B |
| 12 | 1100 | 14 | C |
| 13 | 1101 | 15 | D |
| 14 | 1110 | 16 | E |
| 15 | 1111 | 17 | F |

### 2.8 Binary arithmetic

**Addition rules**

```
0+0=0   0+1=1   1+0=1   1+1=10 (write 0, carry 1)   1+1+1=11 (write 1, carry 1)
```

**Example:** `1011 + 0110`

```
  1 0 1 1
+ 0 1 1 0
──────────
1 0 0 0 1   = 17
```

**Subtraction** is done by adding the two's complement of the subtrahend.

---

## 3. Signed integer representation

Three methods are used to represent negative numbers in binary.

### 3.1 Sign-and-magnitude

The leftmost bit is the sign (0 = positive, 1 = negative); the rest is the magnitude.

`-5` in 8 bits = `1000 0101`

Problems: two zeros (`+0 = 00000000`, `-0 = 10000000`), and arithmetic is awkward.

### 3.2 One's complement

Positive numbers are normal; negative numbers are formed by **inverting every bit**.

`+5 = 0000 0101` → `-5 = 1111 1010`

Problems: still two zeros, and addition needs an end-around carry.

### 3.3 Two's complement (the standard)

Negative number = **invert all bits, then add 1**.

**Example: −5 in 8 bits**

```
+5       0000 0101
invert   1111 1010
+1       1111 1011   ← this is −5 (0xFB)
```

**Check:** `1111 1011` as unsigned = 251. `251 − 256 = −5`. ✓

**Why two's complement?** It has only one zero, and addition/subtraction use the same hardware.

**Negating a two's-complement number:** invert all bits and add 1 (same operation).

### 3.4 Ranges (memorise)

For **n** bits:

- Unsigned range: `0` to `2ⁿ − 1`
- Signed two's-complement range: `−2ⁿ⁻¹` to `2ⁿ⁻¹ − 1`

| Bits | Unsigned range | Signed range |
|---|---|---|
| 4 | 0 to 15 | −8 to 7 |
| 8 | 0 to 255 | −128 to 127 |
| 16 | 0 to 65,535 | −32,768 to 32,767 |
| 32 | 0 to 4,294,967,295 | −2,147,483,648 to 2,147,483,647 |
| 64 | 0 to 1.8 × 10¹⁹ | −9.2 × 10¹⁸ to 9.2 × 10¹⁸ |

**Worked exam question:** "What is the range of a signed 8-bit integer?"
→ `−2⁷` to `2⁷ − 1` = **−128 to +127**.

**Overflow:** if you add 1 to 127 in a signed 8-bit integer, you get −128 (wrap-around in practice; in C, signed overflow is undefined behaviour). Unsigned arithmetic wraps modulo 2ⁿ.

---

## 4. C's basic data types

C has four basic types (plus modifiers):

| Type | Typical size | Format specifier | Example | Range (typical) |
|---|---|---|---|---|
| `char` | 1 byte | `%c` | `'A'` | −128 to 127 (signed) or 0 to 255 (unsigned) |
| `short` / `short int` | 2 bytes | `%hd` | `-1000` | −32,768 to 32,767 |
| `int` | 4 bytes | `%d` | `42` | −2,147,483,648 to 2,147,483,647 |
| `unsigned int` | 4 bytes | `%u` | `42u` | 0 to 4,294,967,295 |
| `long` / `long int` | 4 or 8 bytes | `%ld` | `100000L` | Platform-dependent |
| `long long` | 8 bytes | `%lld` | `100000LL` | −9.2×10¹⁸ to 9.2×10¹⁸ |
| `float` | 4 bytes | `%f` | `3.14f` | ±3.4×10⁻³⁸ to ±3.4×10³⁸, ~7 digits |
| `double` | 8 bytes | `%lf` (printf: `%f` also works) | `3.14` | ±1.7×10⁻³⁰⁸ to ±1.7×10³⁰⁸, ~15 digits |
| `long double` | 8–16 bytes | `%Lf` | `3.14L` | Platform-dependent |
| `void` | 0 | — | — | "No type" — used for functions with no return value |

> **Sizes are platform-dependent.** Always say "typically" in an exam unless the question states the platform. Use `sizeof` to check.

### 4.1 `int`

Whole numbers, positive or negative.

```c
int age = 20;
int temperature = -5;
unsigned int count = 100;       /* positive only */
```

### 4.2 `float` and `double` (floating-point)

Numbers with fractional parts, and very large/small numbers in scientific notation.

```c
float price = 19.99f;           /* f suffix tells the compiler it's a float */
double pi = 3.141592653589793;
double avogadro = 6.022e23;     /* 6.022 × 10²³ */
```

**Key differences**

| `float` | `double` |
|---|---|
| 4 bytes | 8 bytes |
| ~6–7 significant decimal digits | ~15–16 significant digits |
| Smaller range | Larger range |
| Faster, less memory | More precise |
| `%f` | `%lf` in `scanf`; `%f` or `%lf` in `printf` |

### 4.3 How floating-point is stored (IEEE 754 idea)

A floating-point number is stored in three parts:

```
[ sign ][ exponent ][ mantissa / significand ]
   1 bit   ~8 bits      ~23 bits (float)
```

Value = `(−1)^sign × 1.mantissa × 2^(exponent − bias)`

- **Sign:** 0 = positive, 1 = negative.
- **Exponent:** the power of 2, stored with a bias.
- **Mantissa:** the significant binary digits.

Because the mantissa has limited bits, many decimal fractions cannot be represented exactly. This is why:

```c
#include <stdio.h>
int main(void) {
    float a = 0.1f;
    if (a == 0.1) printf("equal\n");
    else printf("not equal\n");
    printf("%.20f\n", a);
    return 0;
}
```

Typical output:

```
not equal
0.10000000149011611938
```

**Rule:** never compare floats with `==`. Use a tolerance:

```c
#include <math.h>
if (fabs(a - b) < 1e-9) { /* considered equal */ }
```

### 4.4 `char`

Stores a **single character** — technically a small integer (its ASCII code).

```c
char letter = 'A';       /* stored as 65 */
char digit = '7';        /* stored as 55, NOT the number 7 */
char newline = '\n';
```

**Key ASCII codes** (memorise these):

| Character | ASCII | Character | ASCII |
|---|---|---|---|
| `'0'` | 48 | `'A'` | 65 |
| `'9'` | 57 | `'Z'` | 90 |
| space | 32 | `'a'` | 97 |
| newline `\n` | 10 | `'z'` | 122 |
| null `'\0'` | 0 | `'A'` → `'a'` difference | 32 |

**Useful facts**

- `'a' - 'A' = 32`
- `'5' - '0' = 5` (converts digit character to its numeric value)
- `'A' + 1 = 'B'`
- To convert a lowercase letter to uppercase: `c - 32` or `toupper(c)`.

### 4.5 Escape sequences

| Escape | Meaning |
|---|---|
| `\n` | New line |
| `\t` | Horizontal tab |
| `\\` | Backslash |
| `\'` | Single quote |
| `\"` | Double quote |
| `\0` | Null character (end of string) |
| `\a` | Alert / beep |
| `\b` | Backspace |
| `\r` | Carriage return |
| `\f` | Form feed |
| `\v` | Vertical tab |
| `\ooo` | Octal character code |
| `\xhh` | Hexadecimal character code |

### 4.6 Strings

C has no built-in string type. A string is a **`char` array terminated by `'\0'`**.

```c
char name[] = "Alice";
```

Memory:

| Index | 0 | 1 | 2 | 3 | 4 | 5 |
|---|---|---|---|---|---|---|
| Value | `'A'` | `'l'` | `'i'` | `'c'` | `'e'` | `'\0'` |

`sizeof(name)` = **6** bytes; `strlen(name)` = **5** characters (not counting `'\0'`).

```c
char word[10] = "Hi";     /* indexes 2..9 are zero-filled */
```

### 4.7 `void`

- `void function(void)` — takes no arguments, returns nothing.
- `void *p` — a generic pointer (can point to any type).

---

## 5. Constants and literals

| Kind | Examples | Notes |
|---|---|---|
| Integer constant | `42`, `-7`, `0x1A`, `075`, `100L`, `42u` | Decimal, hex (`0x`), octal (leading `0`) |
| Floating constant | `3.14`, `2.0e-5`, `1.5f`, `3.0L` | Default type is `double` |
| Character constant | `'A'`, `'\n'`, `'7'` | Single quotes; value is the ASCII code |
| String constant | `"Hello"`, `""`, `"A"` | Double quotes; ends with `'\0'` |
| Symbolic constant | `#define PI 3.14159` or `const float PI = 3.14159;` | Named value |

**Careful:** `'A'` is a character (65), while `"A"` is a string (two bytes: `'A'` and `'\0'`).

---

## 6. Variables, declaration and initialisation

A **variable** is a named memory location whose value can change.

```c
int count;              /* declaration: memory reserved, value uninitialised */
count = 10;             /* assignment */
int total = 0;          /* declaration + initialisation */
float x = 2.5f, y = 7.1f;
char grade = 'A';
```

**Rules**
- Declare before use (C99 allows declarations anywhere in a block; C89 requires them at the top).
- An uninitialised local variable contains **garbage**, not zero.
- Global variables are zero-initialised by default (but do not rely on it for clarity).
- Use meaningful names.

**Multiple assignment**

```c
x = y = z = 13;         /* right-to-left: z=13, then y=13, then x=13 */
```

---

## 7. Type conversion

### 7.1 Implicit conversion (coercion)

C automatically converts operands to a common type, following a rank:

```
char → short → int → unsigned int → long → unsigned long → long long
     → float → double → long double
```

**Examples**

```c
int i = 5;
float f = 2.0;
float result = i / f;        /* i is converted to float before division → 2.5 */

int a = 5, b = 2;
float wrong = a / b;         /* integer division first → 2.0, then converted */
float right = (float)a / b;  /* 2.5 */
```

### 7.2 Explicit conversion (casting)

```c
(type) expression
```

```c
int a = 7, b = 2;
float q = (float)a / b;          /* 3.5 */
int truncated = (int)3.99;       /* 3 — truncation, not rounding */
char c = (char)65;               /* 'A' */
```

**Cast vs round:** `(int)3.99` is **3**, not 4. To round, use `round()` from `math.h`.

### 7.3 Conversion dangers

| Conversion | Result |
|---|---|
| `float` → `int` | Fractional part discarded |
| `double` → `float` | Possible loss of precision |
| `int` → `char` | May wrap if value > 127 |
| Large `int` → `short` | Overflow / implementation-defined |
| `char` → `int` | ASCII code |

---

## 8. `sizeof`

`sizeof` is a compile-time operator that returns the size of a type or variable **in bytes**.

```c
#include <stdio.h>
int main(void) {
    printf("char        = %zu byte(s)\n", sizeof(char));
    printf("short       = %zu byte(s)\n", sizeof(short));
    printf("int         = %zu byte(s)\n", sizeof(int));
    printf("long        = %zu byte(s)\n", sizeof(long));
    printf("long long   = %zu byte(s)\n", sizeof(long long));
    printf("float       = %zu byte(s)\n", sizeof(float));
    printf("double      = %zu byte(s)\n", sizeof(double));
    printf("pointer     = %zu byte(s)\n", sizeof(void *));

    int arr[10];
    printf("array       = %zu byte(s)\n", sizeof(arr));       /* 40 on typical int=4 */
    printf("elements    = %zu\n", sizeof(arr) / sizeof(arr[0])); /* 10 */
    return 0;
}
```

Use `%zu` for `sizeof`. `sizeof` is **not** a function; it does not need parentheses for a variable, but use them for types.

---

## 9. Worked exam questions

### 9.1 "Convert 156 to binary, octal and hexadecimal."

- Binary: 156 = 128 + 16 + 8 + 4 = **10011100₂**
- Octal: group 3 bits → `010 011 100` → **234₈**
- Hex: group 4 bits → `1001 1100` → **9C₁₆**

Check: 9×16 + 12 = 144 + 12 = 156. ✓

### 9.2 "Represent −18 in 8-bit two's complement."

```
+18  = 0001 0010
inv  = 1110 1101
+1   = 1110 1110   (0xEE)
```

Check: 238 − 256 = −18. ✓

### 9.3 "What is the output?"

```c
#include <stdio.h>
int main(void) {
    int a = 5, b = 2;
    float c = 5 / 2;
    float d = 5 / 2.0;
    printf("%.1f %.1f\n", c, d);
    return 0;
}
```

**Output:** `2.0 2.5`

`5 / 2` is integer division → 2, then converted to float for storage. `5 / 2.0` promotes 5 to double → 2.5.

### 9.4 "What is the output?"

```c
char c = 'A';
printf("%c %d\n", c + 2, c + 2);
```

**Output:** `C 67`

`'A'` is 65, plus 2 = 67, which is `'C'`.

### 9.5 "Why does `printf("%d", 3.7)` give a strange value?"

Because `%d` expects an `int` but `3.7` is a `double`. The bits are misinterpreted — undefined behaviour. Use `%f`.

---

## 10. Common exam traps

1. **`sizeof` vs `strlen`:** `sizeof("Hi")` is 3 (including `'\0'`); `strlen("Hi")` is 2.
2. **`'0'` is not `0`:** `'0'` has ASCII 48. To convert, subtract `'0'`.
3. **Integer division truncates:** `7/2 = 3`, `-7/2 = -3` (C99), not `-4`.
4. **`%` only works on integers.** `7.5 % 2` is a compile error.
5. **`float` is not exact:** never test `==`; use a tolerance.
6. **`int` size is not guaranteed** to be 4 bytes; it is platform-dependent.
7. **Unsigned underflow:** `unsigned int x = 0; x--;` gives 4,294,967,295, not −1.
8. **Signed overflow** is undefined behaviour; do not rely on wrap-around.
9. **`char` may be signed or unsigned** by default — platform-dependent.
10. **A string needs room for `'\0'`:** `char s[5] = "Hello";` is invalid (needs 6).
11. **`%f` in `scanf` for `double` is wrong** — use `%lf`.
12. **`0x` for hex, leading `0` for octal** — `010` is 8, not 10.

---

## 11. Rapid revision

- 1 byte = 8 bits; 1 KB = 1024 bytes.
- Binary/octal/hex: 1 octal digit = 3 bits, 1 hex digit = 4 bits.
- Decimal→binary: divide by 2, read remainders upward.
- Two's complement: invert + 1; 8-bit range −128…127.
- `char` = ASCII integer; `int` = whole; `float`/`double` = fractional.
- `float` 4 bytes ~7 digits; `double` 8 bytes ~15 digits.
- `sizeof` gives bytes; `strlen` counts characters excluding `'\0'`.
- Cast: `(float)a / b`; without it, integer division truncates.
- Never compare floats with `==`.
- `%d` int, `%f` float, `%lf` double in `scanf`, `%c` char, `%s` string, `%u` unsigned.

---

## 12. Self-test (answers below)

1. Convert 37 to binary, octal and hex.
2. Convert `11011011₂` to decimal and hex.
3. Convert `0x3F` to decimal and binary.
4. Represent −25 in 8-bit two's complement.
5. What is the range of a signed 16-bit integer?
6. State the typical size and precision of `float` and `double`.
7. What is the ASCII value of `'A'`, `'a'`, `'0'` and space?
8. What is the difference between `'5'` and `5`?
9. What is printed?
   ```c
   char c = 'a';
   printf("%c %d\n", c - 32, c - 32);
   ```
10. What is printed?
    ```c
    int a = 9, b = 2;
    printf("%d %.2f\n", a / b, (float)a / b);
    ```
11. Why is `char s[5] = "Hello";` wrong?
12. What does `sizeof("Hello")` return?
13. Convert 0.375 to binary.
14. Explain why `0.1 + 0.2 == 0.3` is usually false in C.
15. What is the difference between a signed and an unsigned integer?

### Answers

1. 37 = **100101₂** = **45₈** = **0x25**.
2. `11011011₂` = 219 decimal = **0xDB**.
3. `0x3F` = 63 decimal = **00111111₂**.
4. +25 = `0001 1001` → invert `1110 0110` → +1 = **1110 0111**.
5. **−32,768 to 32,767**.
6. `float`: 4 bytes, ~6–7 significant digits; `double`: 8 bytes, ~15–16 significant digits.
7. 65, 97, 48, 32.
8. `'5'` is a character with ASCII value 53; `5` is the integer five. `'5' - '0' = 5`.
9. `A 65` (97 − 32 = 65).
10. `4 4.50`.
11. "Hello" needs 6 bytes including the terminating `'\0'`; a 5-byte array is too small.
12. **6** (5 letters + `'\0'`).
13. 0.375 × 2 = 0.75 → 0; 0.75 × 2 = 1.5 → 1; 0.5 × 2 = 1.0 → 1 → **0.011₂**.
14. Because 0.1 and 0.2 cannot be represented exactly in binary floating-point; their sum is a value very close to but not exactly 0.3.
15. Signed can hold negative and positive values (one bit is the sign); unsigned holds only zero and positive values, so it has a larger positive range.

---

**Next:** `04_operators_and_expressions.md`
