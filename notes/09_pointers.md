# Note 09 — Pointers

> **Covers outline Week 11** (pointers — overview). Pointers are also essential for call by reference, arrays, strings and dynamic memory.

---

## 1. The idea of a pointer

Every variable lives at a **memory address**. A **pointer** is a variable that stores the **address** of another variable.

```
Memory (illustrative)
Address     Variable     Value
0x1000      x            25
0x1004      p            0x1000   ← p points to x
```

```c
int x = 25;
int *p = &x;      /* p stores the address of x */
```

- `&x` → "address of x" (0x1000)
- `p` → 0x1000
- `*p` → "value at the address in p" → 25

**Analogy:** a pointer is like a house address written on paper. The paper is not the house, but it tells you where the house is.

---

## 2. Declaring and using pointers

### 2.1 Declaration

```c
data_type *pointer_name;
```

```c
int *p;         /* pointer to int */
float *f;       /* pointer to float */
char *c;        /* pointer to char */
double *d;      /* pointer to double */
```

The `*` in a declaration means "pointer to", not multiplication.

```c
int *p, q;      /* p is int*, q is int — be careful! */
int *p, *q;     /* both are pointers */
```

### 2.2 Initialisation

```c
int x = 10;
int *p = &x;    /* valid */
```

or

```c
int *p;         /* uninitialised — dangerous */
p = &x;         /* now valid */
```

### 2.3 The two operators

| Operator | Name | Meaning | Example |
|---|---|---|---|
| `&` | Address-of | Gives the address of a variable | `&x` |
| `*` | Dereference / indirection | Gives the value stored at an address | `*p` |

```c
int x = 10;
int *p = &x;

printf("%d\n", x);      /* 10 */
printf("%p\n", (void *)&x);  /* address of x */
printf("%p\n", (void *)p);   /* same address */
printf("%d\n", *p);     /* 10 */
```

### 2.4 Changing a value through a pointer

```c
int x = 10;
int *p = &x;

*p = 20;            /* changes x to 20 */
printf("%d\n", x);  /* 20 */
```

This is the basis of **call by reference**.

### 2.5 Pointer types matter

A pointer's type tells the compiler:

1. How many bytes to read/write when dereferenced.
2. How far `p + 1` moves.

```c
int *ip;
char *cp;
double *dp;

/* On a typical machine: */
sizeof(*ip) = 4
sizeof(*cp) = 1
sizeof(*dp) = 8
```

Do not assign an `int *` to a `double *` without a cast — the types are incompatible.

### 2.6 The `NULL` pointer

`NULL` (from `<stddef.h>` / `<stdio.h>`) is a special value meaning "points to nothing".

```c
int *p = NULL;

if (p != NULL)
    printf("%d\n", *p);     /* safe: only dereference if not NULL */
else
    printf("p is null\n");
```

**Never dereference a NULL pointer** — it crashes the program (segmentation fault).

### 2.7 Uninitialised and wild pointers

```c
int *p;         /* wild pointer: contains garbage address */
*p = 10;        /* undefined behaviour — may crash */
```

Always initialise:

```c
int *p = NULL;
```

---

## 3. Pointer arithmetic

Arithmetic on pointers is scaled by the size of the pointed-to type.

```c
int a[5] = {10, 20, 30, 40, 50};
int *p = a;             /* p points to a[0] */

p++;                    /* moves forward by sizeof(int) = 4 bytes → a[1] */
printf("%d\n", *p);     /* 20 */
```

| Expression | Meaning |
|---|---|
| `p + 1` | Address of the next element |
| `p - 1` | Address of the previous element |
| `p++` / `++p` | Move to the next element |
| `*p` | Value at the current element |
| `p1 - p2` | Number of elements between two pointers (same array) |
| `p == q` | Do the pointers point to the same address? |

**Example**

```c
int a[5] = {10, 20, 30, 40, 50};
int *p = a;

printf("%d\n", *p);         /* 10 */
printf("%d\n", *(p + 2));   /* 30 */
printf("%d\n", p[3]);       /* 40 — pointer indexing works too */
```

**Pointer arithmetic is only valid within the same array (or one past the end).** Anything else is undefined behaviour.

### 3.1 The `*p++` family (exam favourite)

Postfix `++` has higher precedence than `*`.

| Expression | Meaning | Effect |
|---|---|---|
| `*p++` | `*(p++)` | Read `*p`, then move `p` to the next element |
| `(*p)++` | Increment the value pointed to | `*p = *p + 1`; pointer unchanged |
| `*++p` | `*(++p)` | Move `p` first, then read the new element |
| `++*p` | `++(*p)` | Increment the value pointed to |

```c
int a[3] = {10, 20, 30};
int *p = a;

printf("%d\n", *p++);    /* prints 10; p now points to a[1] */
printf("%d\n", (*p)++);  /* prints 20; a[1] becomes 21 */
printf("%d\n", *p);      /* prints 21 */
```

---

## 4. Pointers and arrays

An array name, in most expressions, **decays** to a pointer to its first element.

```c
int a[5] = {10, 20, 30, 40, 50};
int *p = a;              /* same as &a[0] */
```

These are equivalent:

```c
a[i]        ≡   *(a + i)
&a[i]       ≡   a + i
p[i]        ≡   *(p + i)
```

**Example**

```c
for (int i = 0; i < 5; i++)
    printf("%d ", *(a + i));     /* same as a[i] */
```

**But an array is not a pointer:**

```c
int a[5];
printf("%zu\n", sizeof(a));      /* 20 bytes (5 × 4) */
printf("%zu\n", sizeof(p));      /* 8 bytes (pointer size) */
```

Also, an array name is **not assignable**:

```c
int a[5], b[5];
a = b;          /* ERROR */
```

### 4.1 Passing an array to a function

```c
void print_array(int *arr, int n)      /* or int arr[] */
{
    for (int i = 0; i < n; i++)
        printf("%d ", arr[i]);
}
```

The function receives a pointer, so it can modify the caller's array.

---

## 5. Pointers and functions

### 5.1 Call by reference: swap

```c
#include <stdio.h>

void swap(int *a, int *b)
{
    int temp = *a;
    *a = *b;
    *b = temp;
}

int main(void)
{
    int x = 50, y = 25;

    printf("Before: %d %d\n", x, y);
    swap(&x, &y);
    printf("After : %d %d\n", x, y);

    return 0;
}
```

**Output**

```
Before: 50 25
After : 25 50
```

**Trace**

- `a` points to `x`, `b` points to `y`.
- `temp = *a` → 50.
- `*a = *b` → x becomes 25.
- `*b = temp` → y becomes 50.

### 5.2 Returning more than one value

C functions return only one value, but pointers let you "return" several through parameters:

```c
void min_max(int a, int b, int *min, int *max)
{
    if (a < b)
    {
        *min = a;
        *max = b;
    }
    else
    {
        *min = b;
        *max = a;
    }
}

int main(void)
{
    int lo, hi;
    min_max(7, 3, &lo, &hi);
    printf("min=%d max=%d\n", lo, hi);   /* min=3 max=7 */
    return 0;
}
```

### 5.3 Modifying a variable through a function

```c
void increment(int *n)
{
    (*n)++;          /* parentheses are essential: *n++ would be wrong */
}

int main(void)
{
    int x = 5;
    increment(&x);
    printf("%d\n", x);   /* 6 */
    return 0;
}
```

---

## 6. Pointers and strings

A string can be accessed through a `char *`:

```c
char s[] = "Hello";
char *p = s;

while (*p != '\0')
{
    putchar(*p);
    p++;
}
```

Output: `Hello`

**String literals and pointers**

```c
char *msg = "Hello";        /* pointer to a read-only string literal */
msg[0] = 'J';               /* UNDEFINED BEHAVIOUR — may crash */
```

If you need to modify it, use an array:

```c
char msg[] = "Hello";
msg[0] = 'J';               /* OK */
```

Use `const char *` when you do not intend to modify:

```c
const char *msg = "Hello";
```

---

## 7. Pointer to pointer

A pointer can point to another pointer.

```c
int x = 10;
int *p = &x;
int **pp = &p;

printf("%d\n", **pp);       /* 10 */
```

```
pp ──► p ──► x ──► 10
```

Used for dynamic 2D arrays, modifying a pointer inside a function, and arrays of strings.

```c
void allocate(int **p, int n)
{
    *p = malloc(n * sizeof(int));
}
```

---

## 8. Dynamic memory allocation

So far, arrays have a fixed size decided at compile time. **Dynamic memory** is allocated at runtime from the **heap**.

Include `<stdlib.h>`.

| Function | Purpose |
|---|---|
| `malloc(size)` | Allocates `size` bytes, uninitialised |
| `calloc(n, size)` | Allocates `n × size` bytes, zero-initialised |
| `realloc(ptr, new_size)` | Resizes a previously allocated block |
| `free(ptr)` | Releases the memory |

### 8.1 `malloc`

```c
#include <stdio.h>
#include <stdlib.h>

int main(void)
{
    int n = 5;
    int *a = malloc(n * sizeof(int));

    if (a == NULL)
    {
        printf("Memory allocation failed\n");
        return 1;
    }

    for (int i = 0; i < n; i++)
        a[i] = i * 10;

    for (int i = 0; i < n; i++)
        printf("%d ", a[i]);

    free(a);            /* release the memory */
    a = NULL;           /* avoid a dangling pointer */
    return 0;
}
```

**Output:** `0 10 20 30 40`

### 8.2 `calloc`

```c
int *a = calloc(5, sizeof(int));    /* all elements are 0 */
```

### 8.3 `realloc`

```c
int *bigger = realloc(a, 10 * sizeof(int));
if (bigger == NULL)
{
    /* realloc failed; original a is still valid */
}
else
{
    a = bigger;
}
```

### 8.4 `free`

```c
free(a);
a = NULL;
```

**Rules**

- Every `malloc`/`calloc`/`realloc` must have exactly one matching `free`.
- Do not use memory after freeing it (**use-after-free**).
- Do not free the same block twice (**double free**).
- `free(NULL)` is safe and does nothing.
- Forgetting to free causes a **memory leak**.

> Dynamic memory is beyond the basic outline, but it is often mentioned in exams as "what is malloc used for?"

---

## 9. Worked memory diagrams

### Example 1

```c
int x = 5;
int *p = &x;
*p = 8;
```

```
Before:  x = 5      p = &x
After:   x = 8      p = &x
```

### Example 2

```c
int a[3] = {1, 2, 3};
int *p = a;
p++;
printf("%d", *p);
```

```
a: [1] [2] [3]
     ↑   ↑
     a   p (after p++)
```

**Output:** `2`

### Example 3

```c
int a = 10, b = 20;
int *p = &a, *q = &b;
*p = *q;
printf("%d %d\n", a, b);
```

`a` becomes 20, `b` stays 20. **Output:** `20 20`

### Example 4

```c
int a[4] = {10, 20, 30, 40};
int *p = &a[1];
printf("%d %d\n", *p, *(p + 2));
```

`p` points to `a[1]` = 20; `p+2` points to `a[3]` = 40. **Output:** `20 40`

---

## 10. Common errors

| Error | Problem | Fix |
|---|---|---|
| `int *p; *p = 10;` | Wild pointer dereference | `int x; int *p = &x;` |
| `int *p = NULL; *p = 5;` | NULL dereference → crash | Check `if (p != NULL)` |
| `p = 10;` | Assigns an integer to a pointer | `p = &x;` or `*p = 10;` |
| `scanf("%d", p)` when `p` is uninitialised | Writes to a random address | Allocate/point first |
| Returning `&local` from a function | Local dies; dangling pointer | Return a value or use `static`/`malloc` |
| `free(p); *p = 5;` | Use after free | Do not use freed memory |
| `free(p); free(p);` | Double free | Free once; set `p = NULL` |
| Forgetting `free` | Memory leak | Free every allocation |
| `p + 1` on a non-array pointer | Undefined behaviour | Only within an array |
| `*p++` vs `(*p)++` | Different effects | Use parentheses for the value |
| Comparing pointers from different arrays | Undefined behaviour | Compare only within the same array |
| `char *s = "hi"; s[0]='H';` | Modifying a string literal | `char s[] = "hi";` |

---

## 11. Rapid revision

- Pointer = variable that stores an address.
- `&` = address-of; `*` = dereference.
- Declare: `int *p;` Initialise: `p = &x;`
- `*p` reads/writes the value at the address.
- `p++` moves by `sizeof(*p)` bytes.
- `a[i]` is the same as `*(a + i)`.
- Arrays decay to pointers when passed to functions.
- Use pointers for call by reference (swap, multiple outputs).
- `NULL` means "points to nothing"; never dereference it.
- `*p++` = read then move; `(*p)++` = increment the value.
- `malloc`/`calloc` allocate; `free` releases; check for `NULL`.
- Never return the address of a local variable.

---

## 12. Self-test (answers below)

1. What is a pointer? How is it declared?
2. What do `&` and `*` do?
3. What is printed?
   ```c
   int x = 10;
   int *p = &x;
   *p = 25;
   printf("%d %d\n", x, *p);
   ```
4. What is a NULL pointer? Why is it useful?
5. What is a wild pointer?
6. If `int *p` points to `a[0]`, what does `p + 2` point to?
7. What is the difference between `*p++` and `(*p)++`?
8. Rewrite `a[i]` using pointer notation.
9. What is printed?
   ```c
   int a[3] = {5, 10, 15};
   int *p = a;
   printf("%d %d\n", *p, *(p + 2));
   ```
10. Why does the call-by-value swap fail, and how do pointers fix it?
11. What is the output?
    ```c
    void f(int *x) { *x = *x + 5; }
    int main(void) {
        int a = 10;
        f(&a);
        printf("%d\n", a);
        return 0;
    }
    ```
12. What is the difference between `malloc` and `calloc`?
13. Why must every `malloc` be matched with a `free`?
14. What is a dangling pointer?
15. What is wrong?
    ```c
    int *f(void) {
        int x = 10;
        return &x;
    }
    ```

### Answers

1. A variable that stores the address of another variable. `int *p;`
2. `&` gives the address of a variable; `*` gives the value stored at an address (and can assign through it).
3. `25 25`.
4. A pointer that points to nothing (`NULL`). It lets you check whether a pointer is valid before dereferencing, and marks "no address".
5. An uninitialised pointer that contains a garbage address. Dereferencing it is undefined behaviour.
6. The address of `a[2]`.
7. `*p++` reads the value at `p` and then moves `p` to the next element; `(*p)++` increments the value pointed to, leaving `p` unchanged.
8. `*(a + i)`.
9. `5 15`.
10. Call by value copies the variables, so swapping copies does not affect the originals. Passing addresses (`&x`, `&y`) lets the function modify the originals through pointers.
11. `15`.
12. `malloc` allocates uninitialised memory; `calloc` allocates zero-initialised memory and takes two arguments (count and size).
13. To avoid memory leaks — the heap memory remains reserved until freed.
14. A pointer that points to memory that has already been freed or to a variable that no longer exists.
15. It returns the address of a local variable, which is destroyed when the function returns. The caller receives a dangling pointer.

---

**Next:** `10_structures_unions_files.md`
