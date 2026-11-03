# Actual E-Learning Quiz — Model Answers

> These are the questions visible in your CSC 112 e-learning quiz screenshots
> (University of Embu, Semester 1 2026/2027). The quiz uses **highest grade**, so you
> can retry it. Learn these answers word-for-word first — they are the cheapest marks
> in the whole unit.

**How to use this file:** cover the answer, say it aloud, then check. Aim for 2–3
sentences per answer: a definition + an example. Do not write an essay in a quiz box.

---

## 1. What is programming?

**Programming** is the process of designing, writing, testing and maintaining a set of
instructions that tells a computer how to perform a task. It includes understanding the
problem, planning the steps (algorithm), writing the code, and fixing errors — not just
typing code.

*Example:* writing a C program that reads two numbers and prints their sum.

> Memory hook: **programming = planning + coding + testing**, not only coding.

---

## 2. What is a computer program?

A **computer program** is a finite set of sequenced (ordered) instructions that a
computer follows to carry out a particular task.

*Example:* a calculator program that reads two numbers and displays their product.

> Memory hook: **program = recipe**; the computer is the cook.

---

## 3. What is a programming language?

A **programming language** is an artificial/formal language with defined syntax
(grammar) and semantics (meaning), used to write instructions that a computer can
execute.

*Examples:* C, C++, Java, Python, Pascal, Visual Basic.

> Memory hook: it is how humans **communicate instructions** to a machine.

---

## 4. Give two examples of high-level programming languages.

**C** and **Python** (also acceptable: C++, Java, Pascal, Visual Basic, COBOL,
FORTRAN, JavaScript).

High-level languages are machine-independent, easy to read and written in
English-like statements. They must be translated by a compiler or interpreter.

---

## 5. What is a compiler?

A **compiler** is a translator program that converts an entire source program into
machine/object code **before** the program is run. It scans the whole program and
reports all syntax errors at once (at the end of compilation).

*Example:* the C compiler converts `program.c` into `program.obj`/`program.o`, which
is then linked into an executable.

> Memory hook: **compiler = whole book translated at once**.

---

## 6. What is an interpreter?

An **interpreter** is a translator program that translates and executes a program
**one statement at a time**. It stops when it reaches the first error, so debugging is
easier, but execution is slower.

*Examples:* Python, Ruby and JavaScript are commonly interpreted.

> Memory hook: **interpreter = live translator, sentence by sentence**.

---

## 7. What is the difference between source code and object code?

| Source code | Object code |
|---|---|
| Human-readable program written by the programmer | Machine-readable code produced by the compiler |
| Written in a high-level language, e.g. C | Usually binary/machine code (`.o` / `.obj`) |
| File ends in `.c` | File ends in `.o` or `.obj` |
| Can be edited and understood | Not easily read or edited by humans |
| Must be translated before running | Still needs linking before it becomes an executable |

*Example:* `hello.c` is source code; `hello.o` is its object code; `hello.exe` is the
linked executable.

---

## 8. What is debugging?

**Debugging** is the process of finding, locating and correcting errors (bugs) in a
program so that it produces the expected output.

*Techniques:* reading the code, adding temporary `printf` statements, using a
debugger with breakpoints, and testing with sample data.

> Debugging = **find + fix** errors. Testing = **discover** them.

---

## 9. What is an algorithm?

An **algorithm** is a finite, ordered and unambiguous set of steps that solves a
problem or performs a task.

**Features:** input, output, definiteness (clear steps), finiteness (must end) and
effectiveness (each step is doable).

*Example — largest of two numbers:*
1. Start.
2. Read A and B.
3. If A > B, print A; otherwise print B.
4. Stop.

---

## 10. What is a variable?

A **variable** is a named memory location whose value can change while the program is
running. It must be declared with a data type before use.

```c
int age = 20;      /* 'age' is a variable of type int */
age = 21;          /* its value can change */
```

> Memory hook: a variable is a **labelled box** in memory.

---

## 11. What is a constant?

A **constant** is a value that cannot change during program execution.

```c
const float PI = 3.14159;   /* const constant */
#define MAX 100             /* preprocessor constant */
```

*Examples:* `3.14`, `'A'`, `100` are literal constants.

---

## 12. What are data types?

**Data types** specify the kind of data a variable can hold, how much memory it uses,
its range of values, and which operations can be performed on it.

*Examples:* `int` (whole numbers), `float`/`double` (decimals), `char` (single
character), `char[]` (string).

---

## 13. Give two examples of numeric data types.

**`int`** (whole numbers, e.g. 25) and **`float`** (decimal numbers, e.g. 3.14).

Also acceptable: `double`, `short`, `long`, `unsigned int`.

---

## 14. What is a string?

A **string** is a sequence of characters stored in a character array and terminated by
the null character `'\0'`.

```c
char name[] = "John";   /* J o h n \0  → 5 bytes */
```

The length of `"John"` is 4, but it occupies 5 bytes including `'\0'`.

---

## 15. What is type casting?

**Type casting** is the explicit conversion of a value from one data type to another.

```c
int a = 5, b = 2;
float result = (float)a / b;   /* 2.5, not 2 */
int x = (int)3.99;             /* x = 3 (fraction discarded) */
```

**Implicit conversion** is done automatically by the compiler (e.g. `int` to
`float`); **explicit casting** is done by the programmer with `(type)`.

---

## 16. What is an array?

An **array** is a collection of a fixed number of elements of the **same data type**,
stored in contiguous memory locations and accessed using a single name and an index.

```c
int marks[5] = {60, 70, 80, 90, 100};
```

`marks[0]` is 60, `marks[4]` is 100.

---

## 17. What is an index in an array?

An **index** (or subscript) is the position number used to access a particular element
of an array. In C, indexing **starts at 0**, so the first element is at index 0 and the
last element of an array of size `n` is at index `n - 1`.

```c
int a[3] = {10, 20, 30};
printf("%d", a[1]);   /* 20 */
```

---

## 18. What is the difference between one-dimensional and two-dimensional arrays?

| One-dimensional (1D) | Two-dimensional (2D) |
|---|---|
| Has **one** index | Has **two** indices: row and column |
| Stores a single list of values | Stores a table/matrix of values |
| `int a[5];` | `int m[3][4];` |
| Accessed as `a[i]` | Accessed as `m[i][j]` |
| One loop is enough to process it | Usually needs nested loops |

*Example:* a list of 30 student marks is 1D; a table of marks for 30 students in 5
subjects is 2D.

---

## 19. What is an element of an array?

An **element** is one individual value stored in an array at a particular index.

```c
int a[3] = {10, 20, 30};
/* 10, 20 and 30 are elements; a[1] is the element 20 */
```

---

## 20. What is a local variable?

A **local variable** is declared inside a function or block and can only be used
within that function or block. It is created when the block is entered and destroyed
when the block ends, and it is **not automatically initialised** (it contains
garbage unless you assign a value).

```c
void demo(void)
{
    int x = 5;   /* local to demo() */
}
```

---

## 21. What is a global variable?

A **global variable** is declared **outside all functions**, so it can be accessed by
all functions in the program (after its declaration). It exists for the whole run of
the program and is automatically initialised to **0**.

```c
int count = 0;          /* global */

void increment(void) { count++; }
```

> Global variables are convenient but make programs harder to debug; prefer local
> variables and parameters.

---

## 22. What is a function call?

A **function call** is a statement or expression that invokes (runs) a function,
passing it the required arguments and receiving its return value.

```c
int add(int a, int b);      /* declaration/prototype */

int main(void)
{
    int sum = add(3, 4);    /* function call; sum = 7 */
    return 0;
}
```

---

## 23. What is string concatenation?

**String concatenation** is joining two strings end-to-end to form one longer string.

```c
char dest[20] = "Hello";
strcat(dest, " World");     /* dest becomes "Hello World" */
```

In C, use `strcat()` (or `strncat()`) from `<string.h>`. The destination array must be
large enough to hold both strings plus `'\0'`.

---

## 24. What is the length of a string?

The **length of a string** is the number of characters it contains, **excluding** the
null terminator `'\0'`.

```c
char s[] = "Hello";
printf("%d", strlen(s));   /* 5 */
```

`"Hello"` occupies 6 bytes in memory but has length 5.

---

## Rapid self-test (cover the answers)

| # | Question | Answer |
|---|---|---|
| 1 | Programming | Designing + writing + testing instructions |
| 2 | Program | Finite ordered set of instructions |
| 3 | Programming language | Formal language with syntax/semantics |
| 4 | Two high-level languages | C, Python |
| 5 | Compiler | Whole program → object code before running |
| 6 | Interpreter | One statement at a time |
| 7 | Source vs object | Human-readable `.c` vs machine `.o` |
| 8 | Debugging | Find and fix errors |
| 9 | Algorithm | Finite, clear steps to solve a problem |
| 10 | Variable | Named memory location; value can change |
| 11 | Constant | Value cannot change |
| 12 | Data types | Kind/size/range/operations of data |
| 13 | Numeric types | `int`, `float` |
| 14 | String | Characters ending in `'\0'` |
| 15 | Type casting | Explicit conversion, `(float)a` |
| 16 | Array | Fixed-size collection of same type |
| 17 | Index | Position, starts at 0 |
| 18 | 1D vs 2D | One index vs row + column |
| 19 | Element | One value at an index |
| 20 | Local variable | Inside a block; dies at block end |
| 21 | Global variable | Outside all functions; lives for whole program |
| 22 | Function call | Invoking a function with arguments |
| 23 | Concatenation | Joining strings with `strcat` |
| 24 | String length | Characters excluding `'\0'` |

---

## Quiz strategy

1. The quizzes use the **highest grade**, so attempt them early and retry after
   studying. Do not fear a low first score.
2. Keep answers short and precise. One definition + one example is enough.
3. Use the exact technical words: *finite*, *sequenced*, *source*, *object*,
   *compiler*, *interpreter*, *index*, *null terminator*.
4. If a question says **"give two examples"**, give exactly two, clearly separated.
5. If a question says **"difference"**, write a two-column table or two clear
   sentences with "whereas".
6. Save/keep a screenshot of every quiz question you meet and add it to this file.
