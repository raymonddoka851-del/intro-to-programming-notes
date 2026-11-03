# Note 04 — Operators and Expressions

> **Covers outline Week 6** (types of operators). This is one of the most examinable topics because it appears inside every other question.

---

## 1. What is an operator?

An **operator** is a symbol that tells the compiler to perform a specific mathematical, relational or logical operation on one or more **operands**.

```
5 + 3
│   │
│   └── operand
└────── operator
```

- **Unary** operator: one operand (`-x`, `++i`, `sizeof(x)`).
- **Binary** operator: two operands (`a + b`).
- **Ternary** operator: three operands (`a ? b : c`).

**Expression:** a combination of constants, variables, operators and function calls that produces a value. A **statement** is an expression terminated by a semicolon.

---

## 2. Arithmetic operators

| Operator | Meaning | Example (`a=10, b=3`) | Result |
|---|---|---|---|
| `+` | Addition | `a + b` | 13 |
| `-` | Subtraction | `a - b` | 7 |
| `*` | Multiplication | `a * b` | 30 |
| `/` | Division | `a / b` | 3 (integer division) |
| `%` | Modulus (remainder) | `a % b` | 1 |
| `-` (unary) | Negation | `-a` | −10 |

### 2.1 Integer division

If **both operands are integers**, the result is an integer and the fractional part is **truncated toward zero**.

```c
7 / 2      → 3
-7 / 2     → -3      (C99; older C could give -4)
7 / 2.0    → 3.5
7.0 / 2    → 3.5
```

If either operand is floating-point, the other is converted and the result is floating-point.

### 2.2 Modulus

`a % b` gives the **remainder** after dividing `a` by `b`.

```c
17 % 5     → 2
12 % 3     → 0
5 % 2      → 1
-7 % 3     → -1      (sign follows the dividend in C99)
```

**Rules**
- `%` works **only with integers** (`int`, `char`, `long`). `7.5 % 2` is a compile error.
- `b` must not be zero (runtime error / undefined behaviour).
- Common uses: even/odd (`n % 2 == 0`), last digit (`n % 10`), divisibility, converting units, hashing.

### 2.3 Division by zero

```c
int a = 5, b = 0;
printf("%d", a / b);      /* runtime error / undefined behaviour */
```

Always check:

```c
if (b != 0)
    result = a / b;
else
    printf("Cannot divide by zero\n");
```

---

## 3. Relational operators

Used to **compare** two values. The result is always **1 (true)** or **0 (false)** in C.

| Operator | Meaning | Example (`a=10, b=20`) | Result |
|---|---|---|---|
| `==` | Equal to | `a == b` | 0 |
| `!=` | Not equal to | `a != b` | 1 |
| `>` | Greater than | `a > b` | 0 |
| `<` | Less than | `a < b` | 1 |
| `>=` | Greater than or equal | `a >= b` | 0 |
| `<=` | Less than or equal | `a <= b` | 1 |

**Very important:** `=` assigns; `==` compares.

```c
if (x = 5)     /* assigns 5 to x; condition is 5 (true) — WRONG */
if (x == 5)    /* compares — CORRECT */
```

Some compilers warn ("suggest parentheses around assignment used as truth value"), but do not rely on that.

---

## 4. Logical operators

Used to combine conditions.

| Operator | Name | Meaning | Example (`a=1, b=0`) | Result |
|---|---|---|---|---|
| `&&` | Logical AND | True only if **both** are true | `a && b` | 0 |
| `\|\|` | Logical OR | True if **at least one** is true | `a \|\| b` | 1 |
| `!` | Logical NOT | Reverses truth value | `!a` | 0 |

**Truth table**

| `a` | `b` | `a && b` | `a \|\| b` | `!a` |
|---|---|---|---|---|
| 0 | 0 | 0 | 0 | 1 |
| 0 | 1 | 0 | 1 | 1 |
| 1 | 0 | 0 | 1 | 0 |
| 1 | 1 | 1 | 1 | 0 |

**In C, any non-zero value is true; zero is false.**

```c
if (5)      /* true */
if (-3)     /* true — negative is non-zero */
if (0)      /* false */
```

### 4.1 Short-circuit evaluation

- `a && b`: if `a` is false, `b` is **not evaluated**.
- `a || b`: if `a` is true, `b` is **not evaluated**.

This is useful for guarding errors:

```c
if (b != 0 && a / b > 2)   /* safe: division only happens if b != 0 */
    printf("ok\n");
```

But it can hide side effects:

```c
int i = 0;
if (0 && i++) { }          /* i++ never runs, i stays 0 */
```

### 4.2 `&&` vs `&`

| `&&` | `&` |
|---|---|
| Logical AND | Bitwise AND |
| Works on whole values | Works bit by bit |
| Short-circuits | Does not short-circuit |
| Result 0 or 1 | Result is an integer |

`5 && 3` = 1 (both true); `5 & 3` = 1 (binary 101 & 011 = 001).

---

## 5. Bitwise operators

Operate on the **individual bits** of integer types (`int`, `char`, `long`). They do **not** work on `float` or `double`.

| Operator | Name | Example (`a=60`, `b=13`) | Result |
|---|---|---|---|
| `&` | Bitwise AND | `a & b` | 12 |
| `\|` | Bitwise OR | `a \| b` | 61 |
| `^` | Bitwise XOR | `a ^ b` | 49 |
| `~` | Bitwise NOT (one's complement) | `~a` | −61 |
| `<<` | Left shift | `a << 2` | 240 |
| `>>` | Right shift | `a >> 2` | 15 |

**Working (8-bit view):**

```
a = 60 = 0011 1100
b = 13 = 0000 1101

a & b  = 0000 1100 = 12
a | b  = 0011 1101 = 61
a ^ b  = 0011 0001 = 49
~a     = 1100 0011 = 195 (unsigned) or -61 (signed 8-bit)
a << 2 = 1111 0000 = 240
a >> 2 = 0000 1111 = 15
```

**Truth tables**

| `x` | `y` | `x & y` | `x \| y` | `x ^ y` |
|---|---|---|---|---|---|
| 0 | 0 | 0 | 0 | 0 |
| 0 | 1 | 0 | 1 | 1 |
| 1 | 0 | 0 | 1 | 1 |
| 1 | 1 | 1 | 1 | 0 |

**Uses**
- `x & 1` tests whether `x` is odd.
- `x & (1 << n)` tests bit *n*.
- `x | (1 << n)` sets bit *n*.
- `x & ~(1 << n)` clears bit *n*.
- `x ^ (1 << n)` toggles bit *n*.
- `x << 1` multiplies by 2; `x >> 1` divides by 2 (for positive integers).
- Bitwise operators are common in hardware, graphics and embedded systems.

**Caution:** shifting by a negative number or by ≥ the width of the type is undefined behaviour.

---

## 6. Assignment operators

| Operator | Example | Equivalent |
|---|---|---|
| `=` | `x = 5` | Assign 5 to x |
| `+=` | `x += 5` | `x = x + 5` |
| `-=` | `x -= 5` | `x = x - 5` |
| `*=` | `x *= 5` | `x = x * 5` |
| `/=` | `x /= 5` | `x = x / 5` |
| `%=` | `x %= 5` | `x = x % 5` |
| `&=` | `x &= 5` | `x = x & 5` |
| `\|=` | `x \|= 5` | `x = x \| 5` |
| `^=` | `x ^= 5` | `x = x ^ 5` |
| `<<=` | `x <<= 2` | `x = x << 2` |
| `>>=` | `x >>= 2` | `x = x >> 2` |

**Assignment is an expression** and evaluates to the assigned value:

```c
x = y = z = 13;      /* z=13, y=13, x=13 */
```

**Compound assignment and precedence**

```c
j *= 3 + x;          /* means j = j * (3 + x), not (j * 3) + x */
```

The right-hand side is evaluated first as a whole because `+` binds tighter than `*=`.

---

## 7. Increment and decrement

`++` adds 1; `--` subtracts 1.

| Form | Name | Meaning |
|---|---|---|
| `++i` | Prefix | Increment first, then use the new value |
| `i++` | Postfix | Use the current value, then increment |
| `--i` | Prefix | Decrement first, then use |
| `i--` | Postfix | Use current value, then decrement |

**Standalone, they are the same:**

```c
i++;        /* i = i + 1 */
++i;        /* i = i + 1 */
```

**Inside a larger expression, they differ:**

```c
int i = 5, a;
a = i++;        /* a = 5, then i = 6 */
a = ++i;        /* i = 7, then a = 7 */
```

**Worked examples**

```c
int m = 0, n = 0, a;
a = ++m + ++n;      /* m=1, n=1, a=2 */
```

```c
int m = 0, n = 0, a;
a = m++ + n++;      /* a=0, then m=1, n=1 */
```

```c
int c = 2;
printf("%d\n", c++);   /* prints 2, c becomes 3 */
printf("%d\n", ++c);   /* c becomes 4, prints 4 */
```

**Warning:** do not modify the same variable more than once in a single expression:

```c
i = 5;
j = i++ + ++i;      /* UNDEFINED BEHAVIOUR — never write this */
```

---

## 8. Conditional (ternary) operator

```c
condition ? expression_if_true : expression_if_false
```

```c
int x = 9, y;
y = (x > 5) ? 1 : 4;        /* y = 1 */
```

Equivalent:

```c
if (x > 5)
    y = 1;
else
    y = 4;
```

**More examples**

```c
int a = 10, b = 20;
int max = (a > b) ? a : b;              /* 20 */
printf("%s\n", (n % 2 == 0) ? "Even" : "Odd");
```

Use it for short, simple choices. For complex logic, `if-else` is clearer.

---

## 9. Other operators

| Operator | Name | Example | Meaning |
|---|---|---|---|
| `sizeof` | Size-of | `sizeof(int)` | Size in bytes |
| `&` | Address-of (unary) | `&x` | Address of x |
| `*` | Dereference (unary) | `*p` | Value at address p |
| `.` | Member access | `s.age` | Struct member |
| `->` | Pointer member access | `p->age` | Member through pointer |
| `,` | Comma | `x = (a=1, b=2);` | Evaluate left to right; value is the last |
| `(type)` | Cast | `(float)a` | Convert type |

`&` and `*` are covered fully in Note 09.

---

## 10. Operator precedence and associativity

**Precedence** decides which operator is evaluated first. **Associativity** decides the order when two operators have the same precedence.

### 10.1 Table (high → low)

| Level | Operators | Associativity |
|---|---|---|
| 1 (highest) | `()` `[]` `.` `->` postfix `++` `--` | Left → right |
| 2 | Unary `+` `-` `!` `~` `++` `--` `*` `&` `sizeof` `(type)` | Right → left |
| 3 | `*` `/` `%` | Left → right |
| 4 | `+` `-` | Left → right |
| 5 | `<<` `>>` | Left → right |
| 6 | `<` `<=` `>` `>=` | Left → right |
| 7 | `==` `!=` | Left → right |
| 8 | `&` | Left → right |
| 9 | `^` | Left → right |
| 10 | `\|` | Left → right |
| 11 | `&&` | Left → right |
| 12 | `\|\|` | Left → right |
| 13 | `?:` | Right → left |
| 14 | `=` `+=` `-=` `*=` `/=` `%=` etc. | Right → left |
| 15 (lowest) | `,` | Left → right |

**Memory trick:** *Please Excuse My Dear Aunt Sally* covers `()`, unary, `* / %`, `+ -`. Then comparisons, then bitwise, then logical, then assignment.

### 10.2 Worked evaluations

| Expression | Evaluation steps | Result |
|---|---|---|
| `7 + 3 * 2` | `3*2=6`, `7+6` | **13** |
| `(7 + 3) * 2` | `10*2` | **20** |
| `10 - 4 - 3` | left-to-right: `6-3` | **3** |
| `20 / 4 * 2` | left-to-right: `5*2` | **10** |
| `2 + 3 > 4` | `5 > 4` | **1** |
| `5 > 3 && 2 < 1` | `1 && 0` | **0** |
| `5 > 3 \|\| 2 < 1` | `1 \|\| 0` | **1** |
| `!0` | not false | **1** |
| `!5` | not true | **0** |
| `5 & 3` | `101 & 011 = 001` | **1** |
| `5 \| 3` | `101 \| 011 = 111` | **7** |
| `5 ^ 3` | `101 ^ 011 = 110` | **6** |
| `~5` | invert all bits of 000...101 | **−6** |
| `5 << 1` | multiply by 2 | **10** |
| `5 >> 1` | divide by 2 | **2** |
| `x = 5 + 3 * 2` | `x = 11` | **11** |
| `a = b = c = 5` | right-to-left | all **5** |

### 10.3 Precedence traps

**Trap 1: `&` is lower than `==`**

```c
if (x & 1 == 0)         /* parsed as x & (1 == 0) → x & 0 → always 0 */
if ((x & 1) == 0)       /* correct: test even */
```

**Trap 2: assignment in a condition**

```c
if (x = 0)              /* assigns 0, condition false */
if (x == 0)             /* compares */
```

**Trap 3: `!` binds tightly**

```c
!a == b                 /* means (!a) == b */
```

**Trap 4: `*` is both multiplication and dereference**

```c
int y = *p * 2;         /* dereference p, then multiply by 2 */
```

**Trap 5: integer division before conversion**

```c
float f = 5 / 2;        /* 2.0, not 2.5 */
float g = (float)5 / 2; /* 2.5 */
```

**Trap 6: `a+++b`**

```c
a+++b                   /* tokenised as (a++) + b */
```

---

## 11. Worked exam question: evaluate step by step

**Given `int a = 5, b = 3, c = 2;` evaluate:**

```
result = a++ * b-- + ++c;
```

| Step | Operation | `a` | `b` | `c` | Value |
|---|---|---|---|---|---|
| Start | | 5 | 3 | 2 | |
| `a++` | use 5, then a=6 | 6 | 3 | 2 | 5 |
| `b--` | use 3, then b=2 | 6 | 2 | 2 | 5×3 = 15 |
| `++c` | c becomes 3, use 3 | 6 | 2 | 3 | 15+3 = 18 |
| End | `result = 18` | 6 | 2 | 3 | **18** |

> Avoid writing code like this in real programs. It is fine as an exam exercise.

---

## 12. Practice drills (answers below)

Assume `int a = 10, b = 3, c = 2;` unless stated.

1. `a / b`
2. `a % b`
3. `a / 4.0`
4. `a > b && b > c`
5. `a > b || b < c`
6. `!(a > b)`
7. `a & b`
8. `a | b`
9. `a ^ b`
10. `a << 2`
11. `a >> 1`
12. `b++ + ++c`
13. `a > b ? a : b`
14. `10 - 2 * 3 + 4`
15. `(10 - 2) * (3 + 4)`
16. `20 / 3 * 3`
17. `20.0 / 3 * 3`
18. `1 + 2 > 2 && 3 == 3`
19. `!0 + !5`
20. `5 + 3 * 2 % 4`

### Answers

1. **3** (integer division)
2. **1**
3. **2.5**
4. **1**
5. **1** (10>3 is true; short-circuits)
6. **0**
7. `1010 & 0011` = **2**
8. `1010 | 0011` = **11**
9. `1010 ^ 0011` = **9**
10. **40**
11. **5**
12. `3 + 3` = **6**; afterwards `b=4`, `c=3`
13. **10**
14. `10-6+4` = **8**
15. `8*7` = **56**
16. `(20/3)=6`, `6*3` = **18**
17. `6.666...*3` = **20.0**
18. `3>2` true, `3==3` true → **1**
19. `1 + 0` = **1**
20. `3*2=6`, `6%4=2`, `5+2` = **7**

---

## 13. Rapid revision

- `+ - * / %`; integer division truncates; `%` only for integers.
- Relational operators return **1** or **0**.
- `&&`/`||` short-circuit; non-zero is true.
- Bitwise `& | ^ ~ << >>` work bit by bit on integers.
- `=` assigns, `==` compares.
- Prefix increments before use; postfix after use.
- `?:` is a compact `if-else`.
- Precedence: `()` → unary → `* / %` → `+ -` → shifts → comparisons → bitwise → logical → `?:` → assignment → comma.
- Assignment is right-associative; most others are left-associative.
- When in doubt, **use parentheses**.

---

## 14. Self-test (answers below)

1. List the eight types of operators in C.
2. Differentiate `=` and `==`.
3. What is the difference between `&&` and `&`?
4. What is short-circuit evaluation? Give an example.
5. Evaluate `8 + 2 * 5 - 6 / 2`.
6. Evaluate `(8 + 2) * (5 - 6) / 2`.
7. What is `17 % 5`? What is `17 / 5`?
8. What is printed?
   ```c
   int i = 3;
   printf("%d %d %d\n", i++, ++i, i);
   ```
   (Note: this is undefined behaviour in C — explain why.)
9. Rewrite `if (x > 5) y = 1; else y = 0;` using `?:`.
10. What does `x << 3` do to a positive integer?
11. What is the value of `5 & 3`, `5 | 3`, `5 ^ 3`?
12. Why is `if (x = 5)` dangerous?
13. What is the result of `(int)7.9 + 1`?
14. Explain why `5 / 2 * 2` is not 5.
15. Write the precedence order from highest to lowest for `+`, `*`, `=`, `&&`, `()`.

### Answers

1. Arithmetic, relational, logical, bitwise, assignment, increment/decrement, conditional, miscellaneous (`sizeof`, comma, address, dereference).
2. `=` assigns a value; `==` compares two values and returns 1 or 0.
3. `&&` is logical AND on whole values and short-circuits; `&` is bitwise AND on each bit and does not short-circuit.
4. `&&` stops if the left side is false; `||` stops if the left side is true. Example: `if (b != 0 && a / b > 1)` avoids division by zero.
5. `8 + 10 - 3` = **15**.
6. `10 * (-1) / 2` = **−5**.
7. `17 % 5 = 2`; `17 / 5 = 3`.
8. **Undefined behaviour.** The order of evaluation of function arguments is unspecified, and `i` is modified more than once without a sequence point. Do not write such code.
9. `y = (x > 5) ? 1 : 0;`
10. Multiplies it by 2³ = 8 (for positive integers, ignoring overflow).
11. `5 & 3 = 1`; `5 | 3 = 7`; `5 ^ 3 = 6`.
12. It assigns 5 to `x` and the condition becomes true (5), so the branch always runs; the programmer probably meant `==`.
13. `7 + 1 = 8` (cast truncates first).
14. `5/2` is integer division → 2; `2*2` = 4. Use `5.0/2*2` to get 5.
15. `()` → `*` → `+` → `&&` → `=`.

---

**Next:** `05_control_statements.md`
