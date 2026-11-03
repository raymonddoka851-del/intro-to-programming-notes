# Note 08 — Arrays and Strings

> **Covers outline Week 9** (one-, two- and multi-dimensional arrays) plus strings from the course description.

---

## 1. What is an array?

An **array** is a collection of a **fixed number** of elements of the **same data type**, stored in **contiguous memory**, and accessed by an **index**.

```c
int marks[5];       /* 5 integers */
```

```
Index:    0     1     2     3     4
        ┌─────┬─────┬─────┬─────┬─────┐
marks:  │     │     │     │     │     │
        └─────┴─────┴─────┴─────┴─────┘
Address: 1000  1004  1008  1012  1016   (if int = 4 bytes)
```

**Key facts**

- The **first element is at index 0**.
- The last element of `a[n]` is at index **n − 1**.
- C does **not** check array bounds. Accessing `a[5]` in a 5-element array is **undefined behaviour**.
- The array name represents the **address of the first element** (except in `sizeof` and `&`).

**Why arrays?** Instead of 100 separate variables (`mark1`, `mark2`, ...), you use one array and a loop:

```c
int marks[100];
for (int i = 0; i < 100; i++)
    scanf("%d", &marks[i]);
```

---

## 2. One-dimensional arrays

### 2.1 Declaration

```c
data_type array_name[size];
```

```c
int numbers[10];
float prices[5];
char letters[26];
```

- `size` must be a positive integer constant (or, in C99, a variable-length array).
- Memory allocated = `size × sizeof(element)` bytes.

### 2.2 Initialisation

```c
int a[5] = {10, 20, 30, 40, 50};     /* all five */
int b[5] = {1, 2};                   /* b = {1, 2, 0, 0, 0} */
int c[5] = {0};                      /* all zeros */
int d[]  = {1, 2, 3, 4};             /* size inferred = 4 */
char vowels[] = {'a', 'e', 'i', 'o', 'u'};
```

**Not allowed after declaration:**

```c
int a[5];
a = {1, 2, 3, 4, 5};        /* ERROR */
a[0] = 1; a[1] = 2;          /* correct: assign element by element */
```

C99 designated initialisers (may appear in modern courses):

```c
int a[5] = {[0] = 1, [3] = 7};   /* {1, 0, 0, 7, 0} */
```

### 2.3 Access and assignment

```c
a[0] = 100;              /* first element */
a[4] = 500;              /* last element of a[5] */
printf("%d", a[2]);      /* third element */
```

The index can be a variable or expression:

```c
for (i = 0; i < 5; i++)
    printf("%d ", a[i]);
```

### 2.4 Input and output

```c
#include <stdio.h>

int main(void)
{
    int a[5], i;

    printf("Enter 5 integers:\n");
    for (i = 0; i < 5; i++)
        scanf("%d", &a[i]);          /* note the & */

    printf("You entered: ");
    for (i = 0; i < 5; i++)
        printf("%d ", a[i]);
    printf("\n");

    return 0;
}
```

### 2.5 Size of an array

```c
int a[10];
int n = sizeof(a) / sizeof(a[0]);    /* 10 */
```

`sizeof(a)` = total bytes; `sizeof(a[0])` = bytes per element.

---

## 3. Standard array operations

### 3.1 Sum and average

```c
int a[5] = {10, 20, 30, 40, 50};
int i, sum = 0;
float average;

for (i = 0; i < 5; i++)
    sum += a[i];

average = (float)sum / 5;
printf("Sum = %d, Average = %.2f\n", sum, average);
```

**Output:** `Sum = 150, Average = 30.00`

### 3.2 Maximum and minimum

```c
int a[5] = {12, 45, 7, 89, 23};
int i, max = a[0], min = a[0];

for (i = 1; i < 5; i++)
{
    if (a[i] > max) max = a[i];
    if (a[i] < min) min = a[i];
}

printf("Max = %d, Min = %d\n", max, min);
```

**Output:** `Max = 89, Min = 7`

### 3.3 Reverse an array (in place)

```c
int a[5] = {1, 2, 3, 4, 5};
int i, temp;

for (i = 0; i < 5 / 2; i++)
{
    temp = a[i];
    a[i] = a[4 - i];
    a[4 - i] = temp;
}
/* a = {5, 4, 3, 2, 1} */
```

### 3.4 Print in reverse order (without changing the array)

```c
for (i = 4; i >= 0; i--)
    printf("%d ", a[i]);
```

### 3.5 Linear search

Check each element until the target is found.

```c
int a[5] = {12, 45, 7, 89, 23};
int target = 89, i, position = -1;

for (i = 0; i < 5; i++)
{
    if (a[i] == target)
    {
        position = i;
        break;
    }
}

if (position != -1)
    printf("Found at index %d\n", position);
else
    printf("Not found\n");
```

**Time complexity:** O(n) — in the worst case you check every element.

### 3.6 Binary search (sorted array only)

Repeatedly halve the search range.

```c
int a[8] = {2, 5, 8, 12, 16, 23, 38, 56};
int target = 23;
int low = 0, high = 7, mid, found = -1;

while (low <= high)
{
    mid = (low + high) / 2;

    if (a[mid] == target)
    {
        found = mid;
        break;
    }
    else if (a[mid] < target)
        low = mid + 1;
    else
        high = mid - 1;
}

printf("Found at index %d\n", found);    /* 5 */
```

**Time complexity:** O(log n). **The array must be sorted first.**

### 3.7 Bubble sort

Repeatedly compare adjacent elements and swap them if they are in the wrong order.

```c
int a[6] = {5, 1, 4, 2, 8, 3};
int i, j, temp;

for (i = 0; i < 6 - 1; i++)
{
    for (j = 0; j < 6 - 1 - i; j++)
    {
        if (a[j] > a[j + 1])
        {
            temp = a[j];
            a[j] = a[j + 1];
            a[j + 1] = temp;
        }
    }
}
/* a = {1, 2, 3, 4, 5, 8} */
```

**Trace (first pass):**

```
5 1 4 2 8 3
1 5 4 2 8 3   (swap 5,1)
1 4 5 2 8 3   (swap 5,4)
1 4 2 5 8 3   (swap 5,2)
1 4 2 5 8 3   (no swap 5,8)
1 4 2 5 3 8   (swap 8,3)
```

After each pass, the largest remaining element "bubbles" to the end.

### 3.8 Frequency count

```c
int a[10] = {1, 2, 2, 3, 3, 3, 4, 4, 4, 4};
int i, j, count;

for (i = 0; i < 10; i++)
{
    count = 1;
    for (j = i + 1; j < 10; j++)
        if (a[j] == a[i])
            count++;

    /* print only the first occurrence */
    int first = 1;
    for (j = 0; j < i; j++)
        if (a[j] == a[i])
            first = 0;

    if (first)
        printf("%d occurs %d times\n", a[i], count);
}
```

For sorted arrays, a simpler single pass works.

---

## 4. Arrays and functions

Pass the array **and its size**:

```c
#include <stdio.h>

void print_array(int arr[], int n)
{
    for (int i = 0; i < n; i++)
        printf("%d ", arr[i]);
    printf("\n");
}

int sum_array(int arr[], int n)
{
    int sum = 0;
    for (int i = 0; i < n; i++)
        sum += arr[i];
    return sum;
}

int main(void)
{
    int a[5] = {10, 20, 30, 40, 50};

    print_array(a, 5);
    printf("Sum = %d\n", sum_array(a, 5));

    return 0;
}
```

**Important facts**

- `int arr[]` in a parameter is the same as `int *arr`.
- The function receives a **pointer**, so it can modify the original array.
- `sizeof(arr)` inside the function gives the **pointer size**, not the array size — always pass `n`.
- You do not use `&` when passing an array name.

---

## 5. Two-dimensional arrays

A 2D array is an **array of arrays**, useful for tables, matrices, grids and images.

### 5.1 Declaration

```c
data_type name[rows][columns];
```

```c
int matrix[3][4];       /* 3 rows, 4 columns = 12 elements */
```

Memory is stored **row by row** (row-major order):

```
matrix[0][0] matrix[0][1] matrix[0][2] matrix[0][3]
matrix[1][0] matrix[1][1] matrix[1][2] matrix[1][3]
matrix[2][0] matrix[2][1] matrix[2][2] matrix[2][3]
```

### 5.2 Initialisation

```c
int a[2][3] = {
    {1, 2, 3},
    {4, 5, 6}
};

int b[2][3] = {1, 2, 3, 4, 5, 6};   /* same, row by row */
int c[3][3] = {0};                   /* all zeros */
int d[][2] = {{1, 2}, {3, 4}};       /* 2 rows inferred */
```

### 5.3 Input and output

```c
int a[3][3], i, j;

for (i = 0; i < 3; i++)
    for (j = 0; j < 3; j++)
        scanf("%d", &a[i][j]);

for (i = 0; i < 3; i++)
{
    for (j = 0; j < 3; j++)
        printf("%4d", a[i][j]);
    printf("\n");
}
```

### 5.4 Matrix addition

```c
int a[2][2] = {{1, 2}, {3, 4}};
int b[2][2] = {{5, 6}, {7, 8}};
int c[2][2], i, j;

for (i = 0; i < 2; i++)
    for (j = 0; j < 2; j++)
        c[i][j] = a[i][j] + b[i][j];

/* c = {{6, 8}, {10, 12}} */
```

### 5.5 Matrix transpose

Swap rows and columns: `transpose[j][i] = a[i][j]`.

```c
int a[2][3] = {{1, 2, 3}, {4, 5, 6}};
int t[3][2], i, j;

for (i = 0; i < 2; i++)
    for (j = 0; j < 3; j++)
        t[j][i] = a[i][j];

/* t = {{1, 4}, {2, 5}, {3, 6}} */
```

### 5.6 Matrix multiplication

For `A (m × n)` and `B (n × p)`, the result `C` is `m × p`:

```
C[i][j] = Σ (A[i][k] × B[k][j])   for k = 0..n-1
```

```c
int a[2][3] = {{1, 2, 3}, {4, 5, 6}};
int b[3][2] = {{7, 8}, {9, 10}, {11, 12}};
int c[2][2] = {0};
int i, j, k;

for (i = 0; i < 2; i++)
    for (j = 0; j < 2; j++)
        for (k = 0; k < 3; k++)
            c[i][j] += a[i][k] * b[k][j];

/* c = {{58, 64}, {139, 154}} */
```

Check: `c[0][0] = 1*7 + 2*9 + 3*11 = 7 + 18 + 33 = 58`. ✓

### 5.7 Diagonal sum

```c
int a[3][3], i, sum = 0;
for (i = 0; i < 3; i++)
    sum += a[i][i];          /* main diagonal */
```

### 5.8 2D arrays and functions

You must specify the number of columns (so the compiler can calculate offsets):

```c
void print_matrix(int a[][3], int rows)
{
    for (int i = 0; i < rows; i++)
    {
        for (int j = 0; j < 3; j++)
            printf("%4d", a[i][j]);
        printf("\n");
    }
}
```

---

## 6. Multi-dimensional arrays

C supports more than two dimensions:

```c
int cube[2][3][4];      /* 2 × 3 × 4 = 24 elements */
```

```c
cube[1][2][3] = 99;

for (i = 0; i < 2; i++)
    for (j = 0; j < 3; j++)
        for (k = 0; k < 4; k++)
            printf("%d ", cube[i][j][k]);
```

3D arrays are used for volumetric data, 3D graphics, simulations and multi-dimensional tables. In practice, most exam questions use 1D and 2D.

---

## 7. Strings in C

### 7.1 What is a string?

A **string** is a sequence of characters stored in a `char` array and terminated by the **null character** `'\0'` (ASCII 0).

```c
char greeting[] = "Hello";
```

| Index | 0 | 1 | 2 | 3 | 4 | 5 |
|---|---|---|---|---|---|---|
| Value | `'H'` | `'e'` | `'l'` | `'l'` | `'o'` | `'\0'` |

The `'\0'` tells functions like `printf("%s")` where the string ends.

```c
char a[] = "Hello";                      /* 6 bytes, auto null */
char b[6] = {'H','e','l','l','o','\0'};  /* same */
char c[20] = "Hello";                    /* 20 bytes, rest zero */
char d[5] = "Hello";                     /* WRONG: no room for '\0' */
```

### 7.2 Reading strings

**`scanf("%s", ...)`** reads a word (stops at whitespace):

```c
char name[20];
scanf("%19s", name);        /* width limit prevents overflow; no & */
```

**`fgets`** reads a whole line, including spaces, and stores the newline:

```c
char line[100];
fgets(line, sizeof(line), stdin);
```

To remove the newline:

```c
line[strcspn(line, "\n")] = '\0';
```

**`gets` is unsafe and has been removed from modern C. Never use it.**

### 7.3 Printing strings

```c
char name[] = "Alice";
printf("%s\n", name);       /* Alice */
puts(name);                 /* Alice + newline */
```

To print character by character:

```c
for (int i = 0; name[i] != '\0'; i++)
    putchar(name[i]);
```

### 7.4 String length

```c
int len = 0;
while (name[len] != '\0')
    len++;
```

or

```c
#include <string.h>
int len = strlen(name);     /* excludes '\0' */
```

`sizeof(name)` includes `'\0'`.

### 7.5 Copying a string

```c
char source[] = "Hello";
char dest[20];

strcpy(dest, source);           /* unsafe if dest is too small */
strncpy(dest, source, sizeof(dest) - 1);
dest[sizeof(dest) - 1] = '\0';
```

Manual copy:

```c
int i = 0;
while (source[i] != '\0')
{
    dest[i] = source[i];
    i++;
}
dest[i] = '\0';                 /* don't forget! */
```

### 7.6 Concatenating strings

```c
char first[20] = "Hello";
char second[] = " World";

strcat(first, second);          /* first becomes "Hello World" */
strncat(first, second, 5);      /* safer, copies at most 5 chars */
```

### 7.7 Comparing strings

```c
#include <string.h>

if (strcmp(s1, s2) == 0)
    printf("Equal\n");
else if (strcmp(s1, s2) < 0)
    printf("s1 comes before s2\n");
else
    printf("s1 comes after s2\n");
```

`strcmp` returns:

- `0` if equal,
- a negative value if `s1 < s2`,
- a positive value if `s1 > s2`.

**Never compare strings with `==`** — that compares addresses, not contents.

### 7.8 Other `<string.h>` functions

| Function | Purpose |
|---|---|
| `strlen(s)` | Length (excluding `'\0'`) |
| `strcpy(d, s)` | Copy `s` into `d` |
| `strncpy(d, s, n)` | Copy at most `n` characters |
| `strcat(d, s)` | Append `s` to `d` |
| `strncat(d, s, n)` | Append at most `n` characters |
| `strcmp(s1, s2)` | Compare |
| `strncmp(s1, s2, n)` | Compare first `n` characters |
| `strchr(s, c)` | Pointer to first occurrence of `c` |
| `strstr(s, sub)` | Pointer to first occurrence of `sub` |
| `strrev(s)` | Reverse (non-standard, not in all compilers) |

### 7.9 String traversal examples

**Count vowels**

```c
char s[] = "Hello World";
int i, count = 0;

for (i = 0; s[i] != '\0'; i++)
{
    char c = s[i];
    if (c=='a'||c=='e'||c=='i'||c=='o'||c=='u'||
        c=='A'||c=='E'||c=='I'||c=='O'||c=='U')
        count++;
}
printf("Vowels = %d\n", count);     /* 3 */
```

**Palindrome string**

```c
char s[] = "madam";
int i, j = strlen(s) - 1, palindrome = 1;

for (i = 0; i < j; i++, j--)
{
    if (s[i] != s[j])
    {
        palindrome = 0;
        break;
    }
}

printf("%s\n", palindrome ? "Palindrome" : "Not palindrome");
```

**Convert to uppercase**

```c
for (i = 0; s[i] != '\0'; i++)
    if (s[i] >= 'a' && s[i] <= 'z')
        s[i] = s[i] - 32;
```

or `s[i] = toupper(s[i]);` from `<ctype.h>`.

### 7.10 Array of strings

A list of strings is a 2D `char` array (or an array of pointers):

```c
char names[3][20] = {"Alice", "Bob", "Charlie"};

for (int i = 0; i < 3; i++)
    printf("%s\n", names[i]);
```

`names[0]` is a `char[20]`, i.e. the first string.

---

## 8. Common errors

| Error | Explanation | Fix |
|---|---|---|
| `int a[5]; a[5] = 10;` | Out of bounds (valid indices 0–4) | Use `a[4]` |
| `for (i=0; i<=5; i++) a[i]` | One past the end | `i < 5` |
| `int a[5] = {1,2,3,4,5,6};` | Too many initialisers | Match the size |
| `a = {1,2,3};` after declaration | Arrays are not assignable | Initialise at declaration or assign elements |
| `scanf("%s", &name);` | `name` is already an address; `&name` has wrong type | `scanf("%s", name)` |
| `scanf("%s", name)` with long input | Buffer overflow | `scanf("%19s", name)` |
| `char s[5] = "Hello";` | Needs 6 bytes | `char s[6]` |
| `if (s1 == s2)` | Compares addresses | `strcmp(s1, s2) == 0` |
| `strlen` vs `sizeof` | `strlen` excludes `'\0'`; `sizeof` includes it | Use the right one |
| `char *s = "hello"; s[0]='H';` | String literal is read-only | `char s[] = "hello";` |
| `fgets` leaves `'\n'` | Newline stored in the string | Strip it |
| `sizeof(arr)` inside a function | Gives pointer size, not array size | Pass length separately |
| 2D function parameter `int a[][]` | Column count missing | `int a[][3]` |
| `matrix[i][j]` vs `matrix[j][i]` | Wrong element | Check row/column order |

---

## 9. Worked exam questions

### 9.1 "Write a program to find the average of N numbers using an array."

```c
#include <stdio.h>

int main(void)
{
    int n, i, sum = 0;
    int marks[50];

    printf("How many numbers? ");
    scanf("%d", &n);

    if (n <= 0 || n > 50)
    {
        printf("Invalid count\n");
        return 1;
    }

    for (i = 0; i < n; i++)
    {
        printf("Enter number %d: ", i + 1);
        scanf("%d", &marks[i]);
        sum += marks[i];
    }

    printf("Average = %.2f\n", (float)sum / n);
    return 0;
}
```

### 9.2 "Write a program to add two 2×2 matrices."

```c
#include <stdio.h>

int main(void)
{
    int a[2][2], b[2][2], c[2][2];
    int i, j;

    printf("Enter matrix A (4 numbers):\n");
    for (i = 0; i < 2; i++)
        for (j = 0; j < 2; j++)
            scanf("%d", &a[i][j]);

    printf("Enter matrix B (4 numbers):\n");
    for (i = 0; i < 2; i++)
        for (j = 0; j < 2; j++)
            scanf("%d", &b[i][j]);

    for (i = 0; i < 2; i++)
        for (j = 0; j < 2; j++)
            c[i][j] = a[i][j] + b[i][j];

    printf("Sum matrix:\n");
    for (i = 0; i < 2; i++)
    {
        for (j = 0; j < 2; j++)
            printf("%4d", c[i][j]);
        printf("\n");
    }

    return 0;
}
```

### 9.3 "Write a program to check whether a string is a palindrome."

```c
#include <stdio.h>
#include <string.h>

int main(void)
{
    char s[100];
    int i, j, ok = 1;

    printf("Enter a string: ");
    fgets(s, sizeof(s), stdin);

    /* remove newline */
    s[strcspn(s, "\n")] = '\0';

    j = strlen(s) - 1;
    for (i = 0; i < j; i++, j--)
    {
        if (s[i] != s[j])
        {
            ok = 0;
            break;
        }
    }

    printf("%s\n", ok ? "Palindrome" : "Not a palindrome");
    return 0;
}
```

---

## 10. Rapid revision

- Array = fixed-size collection of same-type elements, index starts at 0.
- No bounds checking; `a[n]` has valid indices `0..n-1`.
- Initialise with `{...}` only at declaration.
- `sizeof(a)/sizeof(a[0])` gives the element count.
- Pass arrays to functions with their length.
- 2D array = rows × columns, stored row by row.
- Matrix multiplication needs three nested loops.
- String = `char` array ending in `'\0'`.
- `strlen` excludes `'\0'`; `sizeof` includes it.
- `scanf("%s")` stops at whitespace; `fgets` reads a line.
- Compare strings with `strcmp`, copy with `strcpy`, join with `strcat`.
- String literals are read-only; use a `char` array to modify.

---

## 11. Self-test (answers below)

1. Define an array. State three properties.
2. What is the index of the first and last element of `int a[10]`?
3. What is printed?
   ```c
   int a[5] = {10, 20, 30};
   printf("%d %d %d\n", a[0], a[2], a[4]);
   ```
4. What is wrong?
   ```c
   int a[5];
   a = {1, 2, 3, 4, 5};
   ```
5. Write a loop to read 10 integers into an array and print them in reverse.
6. Write a program to find the largest element in an array.
7. How many elements does `int m[3][4]` have? How are they stored?
8. Write the nested loop to input a 3×3 matrix.
9. What is the output?
   ```c
   int a[2][2] = {{1,2},{3,4}};
   printf("%d\n", a[1][0]);
   ```
10. What is a string in C? How is it terminated?
11. What is the difference between `sizeof("Hi")` and `strlen("Hi")`?
12. Why is `char s[5] = "Hello";` wrong?
13. What is printed?
    ```c
    char s[] = "abc";
    printf("%c %d\n", s[1], s[3]);
    ```
14. Why should you not use `==` to compare strings?
15. Write a program to count the number of vowels in a string.
16. Write a program to reverse a string in place.
17. Write a program to multiply two 2×2 matrices.
18. What is the difference between `scanf("%s", s)` and `fgets(s, 100, stdin)`?

### Answers

1. A collection of a fixed number of elements of the same type stored contiguously and accessed by index. Properties: fixed size, homogeneous type, contiguous memory, zero-based indexing.
2. First index 0; last index **9**.
3. `10 30 0` — missing initialisers are zero.
4. You cannot assign an initialiser list to an array after declaration; initialise at declaration or assign element by element.
5. `for (i=9; i>=0; i--) printf("%d ", a[i]);`
6. See §3.2.
7. **12** elements (3×4); stored **row by row** (row-major).
8. `for (i=0;i<3;i++) for (j=0;j<3;j++) scanf("%d", &m[i][j]);`
9. **3**
10. A `char` array terminated by the null character `'\0'`.
11. `sizeof("Hi")` = **3** (H, i, `'\0'`); `strlen("Hi")` = **2**.
12. "Hello" needs 6 bytes including `'\0'`; a 5-byte array is too small.
13. `b 0` — `s[1]` is `'b'`; `s[3]` is the null terminator, ASCII 0.
14. `==` compares the addresses of the arrays, not their contents. Use `strcmp`.
15. See §7.9.
16. Swap characters from both ends toward the middle.
17. See §5.6.
18. `scanf("%s")` reads one word and stops at whitespace; `fgets` reads an entire line including spaces (and stores the newline).

---

**Next:** `09_pointers.md`
