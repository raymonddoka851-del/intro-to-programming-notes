# Note 07 — Functions, Parameter Passing & Recursion

> **Covers the functions part of the course description and your Week 7 notes** (Module 7, Unit 1). Recursion is also in the course description.

---

## 1. Why functions?

A **function** is a named block of code that performs one specific task. It can be called (invoked) whenever that task is needed.

```c
int add(int a, int b)       /* function definition */
{
    return a + b;
}

int main(void)
{
    int sum = add(5, 3);    /* function call */
    printf("%d\n", sum);    /* 8 */
    return 0;
}
```

### 1.1 Monolithic vs modular programming

| Monolithic programming | Modular programming |
|---|---|
| One large `main()` for the whole program | Program split into functions/modules |
| Single thread of execution | Each module developed and tested separately |
| Hard to read, test, debug and maintain | Easier to read, test, debug and reuse |
| Code is specific to one problem | Code can be reused in other programs |
| Errors are hard to isolate | Errors are isolated to a module |
| Linker not needed for structure | Linker combines modules into one program |

**Advantages of functions / modularity**

1. **Reusability** — write once, call many times.
2. **Readability** — meaningful names explain the program.
3. **Maintainability** — fix a bug in one place.
4. **Testability** — test each function separately.
5. **Abstraction** — hide implementation details.
6. **Divide and conquer** — break a big problem into small ones.
7. **Avoids repetition** (DRY: Don't Repeat Yourself).
8. **Teamwork** — different programmers can work on different functions.

**Disadvantages / costs**

- Function call overhead (small).
- Too many tiny functions can obscure the overall flow.
- Needs careful interface design (parameters and return types).

---

## 2. The three parts of a user-defined function

Every user-defined function has:

1. **Declaration (prototype)** — tells the compiler the function's name, return type and parameter types.
2. **Definition** — the actual body/code.
3. **Call** — using the function.

### 2.1 Function prototype (declaration)

```c
return_type function_name(type1 parameter1, type2 parameter2, ...);
```

```c
int add(int a, int b);
float average(float x, float y);
void greet(void);
```

- Ends with a **semicolon**.
- Parameter names are optional in a prototype: `int add(int, int);`
- The prototype must appear **before** the first call (usually at the top of the file or in a header).
- If the function is defined **before** `main`, a separate prototype is not needed.

### 2.2 Function definition

```c
return_type function_name(type1 parameter1, type2 parameter2, ...)
{
    /* local declarations */
    /* statements */
    return value;        /* omit if return_type is void */
}
```

```c
int add(int a, int b)
{
    int sum = a + b;
    return sum;
}
```

**Rules**
- A function cannot be defined inside another function.
- `return` ends the function and sends a value back.
- A `void` function may use `return;` to exit early, but returns no value.
- If a non-`void` function reaches the end without `return`, the result is undefined.
- Local variables inside a function are destroyed when it ends.

### 2.3 Function call

```c
function_name(argument1, argument2, ...);
```

```c
int result = add(5, 3);
```

- The number, order and types of arguments must match the parameters.
- The call can appear in an expression: `printf("%d", add(2, 3));`
- A `void` function is called as a statement: `greet();`

---

## 3. A complete example

```c
#include <stdio.h>

/* Prototypes */
int add(int a, int b);
int max_of_two(int a, int b);
void print_line(void);

int main(void)
{
    int x, y;

    printf("Enter two integers: ");
    scanf("%d %d", &x, &y);

    print_line();
    printf("Sum   = %d\n", add(x, y));
    printf("Max   = %d\n", max_of_two(x, y));
    print_line();

    return 0;
}

/* Definitions */
int add(int a, int b)
{
    return a + b;
}

int max_of_two(int a, int b)
{
    if (a > b)
        return a;
    else
        return b;
}

void print_line(void)
{
    printf("----------------\n");
}
```

**Output (input 4 9)**

```
----------------
Sum   = 13
Max   = 9
----------------
```

---

## 4. The four categories of functions

| Category | Arguments? | Return value? | Example |
|---|---|---|---|
| 1. No arguments, no return value | No | No | `void greet(void)` |
| 2. No arguments, returns a value | No | Yes | `int read_number(void)` |
| 3. Arguments, no return value | Yes | No | `void print_sum(int a, int b)` |
| 4. Arguments, returns a value | Yes | Yes | `int add(int a, int b)` |

### 4.1 No arguments, no return value

```c
void greet(void)
{
    printf("Hello, student!\n");
}

int main(void)
{
    greet();
    return 0;
}
```

No data goes in or out. The function reads/prints independently.

### 4.2 No arguments, returns a value

```c
int read_number(void)
{
    int n;
    printf("Enter a number: ");
    scanf("%d", &n);
    return n;
}

int main(void)
{
    int x = read_number();
    printf("You entered %d\n", x);
    return 0;
}
```

### 4.3 Arguments, no return value

```c
void print_sum(int a, int b)
{
    printf("Sum = %d\n", a + b);
}

int main(void)
{
    print_sum(3, 4);
    return 0;
}
```

### 4.4 Arguments, returns a value

```c
int add(int a, int b)
{
    return a + b;
}

int main(void)
{
    int s = add(3, 4);
    printf("Sum = %d\n", s);
    return 0;
}
```

This is the most flexible and most common category.

---

## 5. Actual vs formal parameters

```c
int add(int a, int b)       /* a and b are FORMAL parameters */
{
    return a + b;
}

int main(void)
{
    int x = 5, y = 3;
    int s = add(x, y);      /* x and y are ACTUAL arguments */
    return 0;
}
```

| Actual arguments | Formal parameters |
|---|---|
| Appear in the function **call** | Appear in the function **definition** |
| Are the real values passed by the caller | Are local variables that receive copies |
| Can be constants, variables or expressions | Must be declared with a type |
| Exist in the calling function | Exist only while the called function runs |
| — | Created when the call starts, destroyed when it ends |

The order, number and type of actual arguments must match the formal parameters.

---

## 6. Parameter passing: call by value vs call by reference

### 6.1 Call by value (the default in C)

The **value** of the argument is copied into the parameter. Changes inside the function affect only the copy.

```c
void swap(int a, int b)
{
    int temp = a;
    a = b;
    b = temp;
}

int main(void)
{
    int x = 50, y = 25;
    swap(x, y);
    printf("%d %d\n", x, y);    /* 50 25 — unchanged */
    return 0;
}
```

**Why unchanged?** `a` and `b` are copies. Swapping copies does not swap the originals.

### 6.2 Call by reference (using pointers)

The **address** of the argument is passed. The function can modify the original variable through the pointer.

```c
void swap(int *a, int *b)
{
    int temp = *a;
    *a = *b;
    *b = temp;
}

int main(void)
{
    int x = 50, y = 25;
    swap(&x, &y);
    printf("%d %d\n", x, y);    /* 25 50 — swapped */
    return 0;
}
```

### 6.3 Comparison

| Call by value | Call by reference |
|---|---|
| Passes a copy of the value | Passes the address |
| Original cannot be changed | Original can be changed |
| Safer (no accidental modification) | More powerful but riskier |
| Default in C | Requires pointers (`&`, `*`) |
| Syntax: `f(x)` | Syntax: `f(&x)` |

**Exam note:** C is strictly **call by value**. "Call by reference" is simulated by passing addresses (pointers). Some textbooks still call this call by reference/address.

### 6.4 Arrays as parameters

When an array is passed to a function, what is actually passed is a **pointer to its first element**. The function can therefore modify the original array.

```c
void double_all(int arr[], int n)
{
    for (int i = 0; i < n; i++)
        arr[i] *= 2;
}

int main(void)
{
    int a[5] = {1, 2, 3, 4, 5};
    double_all(a, 5);           /* no & needed */
    for (int i = 0; i < 5; i++)
        printf("%d ", a[i]);    /* 2 4 6 8 10 */
    return 0;
}
```

**Important:** inside the function, `sizeof(arr)` gives the size of a pointer (e.g., 8), **not** the array. Always pass the length as a separate parameter.

---

## 7. Scope and lifetime

| Kind | Where declared | Visible where | Lifetime |
|---|---|---|---|
| **Local (automatic)** | Inside a function/block | That block only | Until the block ends |
| **Global** | Outside all functions | Whole file (and other files with `extern`) | Entire program |
| **Static local** | Inside a function with `static` | That block only | Entire program (value persists between calls) |
| **Formal parameter** | In the function header | That function only | Until the function returns |
| **Register** | `register int x;` | That block | Same as automatic (hint to CPU) |

### 7.1 Local variables

```c
void f(void)
{
    int x = 10;     /* local to f */
}

int main(void)
{
    int x = 20;     /* different x */
    f();
    printf("%d\n", x);   /* 20 */
    return 0;
}
```

Local variables **shadow** globals with the same name.

### 7.2 Global variables

```c
#include <stdio.h>
int counter = 0;         /* global */

void increment(void)
{
    counter++;
}

int main(void)
{
    increment();
    increment();
    printf("%d\n", counter);   /* 2 */
    return 0;
}
```

Globals are convenient but make programs harder to debug; prefer parameters and return values.

### 7.3 Static local variables

```c
#include <stdio.h>

void count_calls(void)
{
    static int calls = 0;   /* initialised only once */
    calls++;
    printf("Called %d time(s)\n", calls);
}

int main(void)
{
    count_calls();
    count_calls();
    count_calls();
    return 0;
}
```

**Output**

```
Called 1 time(s)
Called 2 time(s)
Called 3 time(s)
```

Without `static`, `calls` would reset to 0 on every call.

---

## 8. Recursion

**Recursion** is when a function calls **itself** to solve a smaller version of the same problem.

Every recursive function needs:

1. **Base case** — a condition where the function returns without calling itself. This stops the recursion.
2. **Recursive case** — the function calls itself with a smaller/simpler input, moving toward the base case.

```
factorial(n)
   │
   ├── if n == 0 or 1 → return 1        (base case)
   └── otherwise → return n * factorial(n-1)   (recursive case)
```

### 8.1 How the call stack works

For `factorial(4)`:

```
factorial(4) = 4 * factorial(3)
                  factorial(3) = 3 * factorial(2)
                                    factorial(2) = 2 * factorial(1)
                                                      factorial(1) = 1  ← base case
                                    factorial(2) = 2 * 1 = 2
                  factorial(3) = 3 * 2 = 6
factorial(4) = 4 * 6 = 24
```

Each call is stacked until the base case is reached, then the results are returned back up.

### 8.2 Factorial (iterative and recursive)

```c
/* Iterative */
long long factorial_iter(int n)
{
    long long result = 1;
    for (int i = 1; i <= n; i++)
        result *= i;
    return result;
}

/* Recursive */
long long factorial_rec(int n)
{
    if (n <= 1)             /* base case */
        return 1;
    return n * factorial_rec(n - 1);   /* recursive case */
}
```

### 8.3 Fibonacci

```c
int fib(int n)
{
    if (n <= 1)             /* base cases: fib(0)=0, fib(1)=1 */
        return n;
    return fib(n - 1) + fib(n - 2);
}
```

**Sequence:** 0, 1, 1, 2, 3, 5, 8, 13, 21, ...

**Warning:** naive recursive Fibonacci is very inefficient — it recomputes the same values many times (exponential time). An iterative version is better for large `n`.

### 8.4 Sum of digits

```c
int sum_digits(int n)
{
    if (n == 0)
        return 0;
    return (n % 10) + sum_digits(n / 10);
}
```

`sum_digits(1234) = 4 + 3 + 2 + 1 = 10`.

### 8.5 Power

```c
long long power(int base, int exp)
{
    if (exp == 0)
        return 1;
    return base * power(base, exp - 1);
}
```

`power(2, 5) = 32`.

### 8.6 GCD (Euclid)

```c
int gcd(int a, int b)
{
    if (b == 0)
        return a;
    return gcd(b, a % b);
}
```

`gcd(48, 18) → gcd(18, 12) → gcd(12, 6) → gcd(6, 0) → 6`.

### 8.7 Tower of Hanoi

```c
void hanoi(int n, char from, char to, char aux)
{
    if (n == 1)
    {
        printf("Move disk 1 from %c to %c\n", from, to);
        return;
    }
    hanoi(n - 1, from, aux, to);
    printf("Move disk %d from %c to %c\n", n, from, to);
    hanoi(n - 1, aux, to, from);
}
```

For `n = 3`, it takes `2³ − 1 = 7` moves.

### 8.8 Recursion vs iteration

| Recursion | Iteration |
|---|---|
| Function calls itself | Uses `for`/`while` |
| Needs a base case | Needs a terminating condition |
| Elegant for tree/divide-and-conquer problems | Usually faster and uses less memory |
| Uses the call stack (risk of stack overflow) | Uses constant extra memory |
| Can be harder to debug | Usually easier to trace |
| Example: factorial, Fibonacci, Hanoi | Example: factorial, Fibonacci, sum |

**Use recursion when** the problem is naturally self-similar (trees, graphs, divide and conquer, backtracking). **Use iteration when** a simple loop is clearer and more efficient.

### 8.9 Recursion dangers

- **Missing base case** → infinite recursion → **stack overflow** (program crashes).
- **Base case never reached** (wrong update) → same.
- **Deep recursion** can overflow the stack even with a base case.
- **Repeated computation** (naive Fibonacci) is slow.

---

## 9. Worked exam traces

### Trace 1: `factorial_rec(5)`

```
factorial_rec(5) = 5 * factorial_rec(4)
                 = 5 * 4 * factorial_rec(3)
                 = 5 * 4 * 3 * factorial_rec(2)
                 = 5 * 4 * 3 * 2 * factorial_rec(1)
                 = 5 * 4 * 3 * 2 * 1
                 = 120
```

### Trace 2: what is printed?

```c
void mystery(int n)
{
    if (n == 0)
        return;
    printf("%d ", n);
    mystery(n - 1);
}

int main(void)
{
    mystery(3);
    return 0;
}
```

**Output:** `3 2 1`

### Trace 3: what is printed?

```c
void mystery(int n)
{
    if (n == 0)
        return;
    mystery(n - 1);
    printf("%d ", n);
}

int main(void)
{
    mystery(3);
    return 0;
}
```

**Output:** `1 2 3`

The `printf` happens **after** the recursive call returns, so the order reverses.

### Trace 4: what is printed?

```c
int f(int n)
{
    if (n <= 1)
        return 1;
    return n * f(n - 1);
}

int main(void)
{
    printf("%d\n", f(4) + f(2));
    return 0;
}
```

`f(4) = 24`, `f(2) = 2` → **26**.

---

## 10. Common errors

| Error | Explanation | Fix |
|---|---|---|
| Missing prototype | Compiler does not know the function before the call | Declare it before `main` or define it first |
| Wrong number/type of arguments | The call does not match the definition | Match exactly |
| Missing `return` in a non-`void` function | Undefined result | Return a value on every path |
| Returning a local variable's address | The variable is destroyed when the function ends | Return a value or use `static`/`malloc` |
| Defining a function inside another | Not allowed in C | Move it outside |
| Expecting call by value to change the caller | Only copies are changed | Pass pointers |
| Forgetting `&` in `scanf` | `scanf` needs the address | `scanf("%d", &x)` |
| Recursion without a base case | Infinite recursion / stack overflow | Add a base case |
| Base case never reached | The argument does not move toward it | Change the recursive argument |
| `void` function used in an expression | It has no value | Do not assign its result |
| Name clash with a library function | Linker/compiler conflict | Rename your function |

---

## 11. Rapid revision

- Function = reusable block of code for one task.
- Prototype: `return_type name(types);` — ends with `;`.
- Definition: header + body; no `;` after the header.
- Call: `name(arguments);`.
- Four categories: (no args/no return), (no args/return), (args/no return), (args/return).
- Actual arguments are in the call; formal parameters are in the definition.
- C is call by value; use pointers for call by reference.
- Arrays decay to pointers when passed; pass the size separately.
- Local variables die at block end; `static` locals persist; globals are visible everywhere.
- Recursion = base case + recursive case.
- Missing base case → stack overflow.
- Recursion is elegant but often slower and memory-hungry than iteration.

---

## 12. Self-test (answers below)

1. Define a function. State four advantages of using functions.
2. Differentiate monolithic and modular programming.
3. Write the syntax of a function prototype and a function definition.
4. List the four categories of functions with one example each.
5. Differentiate actual and formal arguments.
6. Explain call by value and call by reference. Why does the call-by-value swap fail?
7. What is the output?
   ```c
   void change(int x) { x = 100; }
   int main(void) {
       int a = 5;
       change(a);
       printf("%d\n", a);
       return 0;
   }
   ```
8. What is the output?
   ```c
   void change(int *x) { *x = 100; }
   int main(void) {
       int a = 5;
       change(&a);
       printf("%d\n", a);
       return 0;
   }
   ```
9. Differentiate local, global and static local variables.
10. What is recursion? What two parts must every recursive function have?
11. Write a recursive function to compute the sum of the first N natural numbers.
12. Write a recursive function to compute `x^n`.
13. What is the output?
    ```c
    int f(int n) {
        if (n == 0) return 0;
        return n + f(n - 1);
    }
    int main(void) {
        printf("%d\n", f(4));
        return 0;
    }
    ```
14. What happens if a recursive function has no base case?
15. Why is recursive Fibonacci inefficient?

### Answers

1. A named block of code that performs a specific task and can be called repeatedly. Advantages: reusability, readability, maintainability, testability, abstraction, divide and conquer.
2. Monolithic = one large function/program; modular = split into functions/modules. Modular is easier to test, debug, reuse and maintain.
3. Prototype: `int add(int a, int b);` Definition: `int add(int a, int b) { return a + b; }`
4. (i) `void greet(void)`; (ii) `int read(void)`; (iii) `void show(int x)`; (iv) `int add(int a, int b)`.
5. Actual arguments appear in the call and supply values; formal parameters appear in the definition and receive copies. Actual exist in the caller; formal exist only during the call.
6. Call by value copies the value; call by reference passes the address. In `swap(int a, int b)`, `a` and `b` are copies, so swapping them does not affect the caller's variables.
7. **5** — the function changes only its local copy.
8. **100** — the pointer lets the function modify the original.
9. Local: declared in a block, visible only there, lifetime = block. Global: declared outside all functions, visible throughout the file, lifetime = program. Static local: declared with `static` inside a function, visible only there but retains its value between calls.
10. A function calling itself. It must have a base case (stopping condition) and a recursive case that moves toward the base case.
11. `int sum(int n) { if (n == 0) return 0; return n + sum(n - 1); }`
12. `long long power(int x, int n) { if (n == 0) return 1; return x * power(x, n - 1); }`
13. **10** (4+3+2+1+0).
14. It calls itself forever, exhausting the call stack → **stack overflow** / crash.
15. Because it recomputes the same subproblems many times (e.g., `fib(5)` computes `fib(3)` twice, `fib(2)` three times), giving exponential time complexity.

---

**Next:** `08_arrays_and_strings.md`
