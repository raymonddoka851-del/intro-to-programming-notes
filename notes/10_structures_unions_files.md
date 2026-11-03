# Note 10 — Structures, Unions, Enums and Files

> **Covers outline Week 12** (unions and structures) plus file handling from the course description.

---

## 1. Structures

A **structure** (`struct`) groups variables of **different types** under one name. It is used to model a real-world object.

Example: a student has a name (string), an age (int) and a fee (float). A struct keeps them together.

```c
struct Student
{
    char name[50];
    int age;
    float fee;
};
```

### 1.1 Defining a structure

```c
struct tag_name
{
    type member1;
    type member2;
    ...
};          /* semicolon is required */
```

The `struct` definition creates a **new type**, but allocates no memory until you declare variables.

### 1.2 Declaring structure variables

```c
struct Student s1;                  /* one variable */
struct Student s2, s3;              /* several */
struct Student class_list[50];      /* array of structs */
```

Or combine definition and declaration:

```c
struct Student
{
    char name[50];
    int age;
    float fee;
} s1, s2;
```

### 1.3 `typedef` (cleaner names)

```c
typedef struct
{
    char name[50];
    int age;
    float fee;
} Student;

Student s1;         /* no need to write "struct" every time */
```

`typedef` creates an **alias**, not a new type.

### 1.4 Accessing members

Use the **dot operator** `.`:

```c
strcpy(s1.name, "Alice");
s1.age = 20;
s1.fee = 45000.50;

printf("Name: %s\n", s1.name);
printf("Age : %d\n", s1.age);
printf("Fee : %.2f\n", s1.fee);
```

### 1.5 Initialisation

```c
struct Student s1 = {"Alice", 20, 45000.50};

/* Designated initialisers (C99) */
struct Student s2 = {.name = "Bob", .age = 21, .fee = 42000.00};
```

The order of values must match the order of members.

### 1.6 Assigning structs

```c
struct Student s1 = {"Alice", 20, 45000.50};
struct Student s2;

s2 = s1;            /* copies all members */
```

Unlike arrays, structs **can** be assigned with `=`.

### 1.7 Array of structures

```c
#include <stdio.h>
#include <string.h>

typedef struct
{
    char name[50];
    int age;
    float fee;
} Student;

int main(void)
{
    Student s[3];
    int i;

    for (i = 0; i < 3; i++)
    {
        printf("Student %d name: ", i + 1);
        scanf("%49s", s[i].name);
        printf("Age: ");
        scanf("%d", &s[i].age);
        printf("Fee: ");
        scanf("%f", &s[i].fee);
    }

    printf("\n%-15s %5s %10s\n", "Name", "Age", "Fee");
    for (i = 0; i < 3; i++)
        printf("%-15s %5d %10.2f\n", s[i].name, s[i].age, s[i].fee);

    return 0;
}
```

### 1.8 Nested structures

```c
struct Date
{
    int day, month, year;
};

struct Student
{
    char name[50];
    struct Date dob;        /* nested struct */
    float fee;
};

struct Student s1 = {"Alice", {15, 8, 2005}, 45000.50};

printf("Born: %d/%d/%d\n", s1.dob.day, s1.dob.month, s1.dob.year);
```

### 1.9 Pointers to structures and `->`

```c
struct Student s1 = {"Alice", 20, 45000.50};
struct Student *p = &s1;

printf("%s\n", (*p).name);      /* dereference then dot */
printf("%s\n", p->name);        /* arrow: cleaner and standard */
```

`p->member` is shorthand for `(*p).member`.

### 1.10 Structures and functions

**Pass by value** — the function gets a copy (cannot change the original):

```c
void print_student(struct Student s)
{
    printf("%s %d %.2f\n", s.name, s.age, s.fee);
}
```

**Pass by pointer** — the function can modify the original and avoids copying large structs:

```c
void update_fee(struct Student *s, float new_fee)
{
    s->fee = new_fee;
}

update_fee(&s1, 50000.00);
```

**Return a struct:**

```c
struct Student make_student(const char *name, int age, float fee)
{
    struct Student s;
    strcpy(s.name, name);
    s.age = age;
    s.fee = fee;
    return s;
}
```

### 1.11 Size of a struct

The size is at least the sum of the members, but the compiler may add **padding** for alignment.

```c
struct Example
{
    char c;      /* 1 byte */
    int i;       /* 4 bytes */
};
```

`sizeof(struct Example)` is often **8**, not 5, because of 3 padding bytes.

**Exam answer:** "The size may be greater than the sum of the members because of memory alignment/padding."

### 1.12 Self-referential structures (linked lists)

A struct can contain a pointer to its own type:

```c
struct Node
{
    int data;
    struct Node *next;
};
```

This is the basis of linked lists, trees and graphs. (You only need the idea for an intro course.)

---

## 2. Unions

A **union** is like a struct, but all members **share the same memory**. Only **one member can hold a valid value at a time**.

```c
union Value
{
    int i;
    float f;
    char c;
};
```

Memory layout:

```
union Value (size = largest member, e.g. 4 bytes)
┌─────────────────────────────┐
│  i / f / c all use these    │
│  same 4 bytes               │
└─────────────────────────────┘
```

### 2.1 Example

```c
#include <stdio.h>

union Value
{
    int i;
    float f;
    char c;
};

int main(void)
{
    union Value v;

    v.i = 65;
    printf("i = %d\n", v.i);        /* 65 */

    v.c = 'A';
    printf("c = %c\n", v.c);        /* A — overwrites part of the same memory */

    v.f = 3.14f;
    printf("f = %.2f\n", v.f);      /* 3.14 */

    printf("Size of union = %zu\n", sizeof(union Value));  /* 4 typically */

    return 0;
}
```

Changing one member **overwrites** the memory used by the others.

### 2.2 `struct` vs `union`

| `struct` | `union` |
|---|---|
| Members have **separate** memory | Members **share** memory |
| Size ≥ sum of member sizes (+ padding) | Size = size of the **largest** member |
| All members can be valid at once | Only **one** member valid at a time |
| Used to group related data | Used to save memory when only one of several types is needed |
| Access any member at any time | Accessing a different member reinterprets the bytes |

**When to use a union:** a variable that can hold an integer **or** a float **or** a string, but never more than one at a time; memory-constrained systems; interpreting the same bytes in different ways.

### 2.3 Size examples

```c
struct S { int i; float f; char c; };   /* 4 + 4 + 1 + 3 padding = 12 typically */
union  U { int i; float f; char c; };   /* max(4,4,1) = 4 typically */
```

---

## 3. Enumerations (`enum`)

An `enum` creates a type whose values are named integer constants.

```c
enum Day
{
    MON, TUE, WED, THU, FRI, SAT, SUN
};
```

- `MON = 0`, `TUE = 1`, ... by default.
- You can assign explicit values:

```c
enum Status { LOW = 1, MEDIUM = 5, HIGH = 10 };
```

- Enums make code readable:

```c
enum Day today = WED;
if (today == WED)
    printf("Midweek\n");
```

`enum` values are integers, so they can be used in `switch`.

---

## 4. Files

So far, data disappears when the program ends. **Files** store data permanently on disk.

### 4.1 The `FILE` type

C uses a `FILE *` (file pointer) to refer to an open file. Include `<stdio.h>`.

```c
FILE *fp;
```

### 4.2 Opening a file: `fopen`

```c
fp = fopen("data.txt", "r");
```

**Modes**

| Mode | Meaning | If the file exists | If it does not exist |
|---|---|---|---|
| `"r"` | Read only | Opens it | Returns `NULL` |
| `"w"` | Write only | **Erases** the contents | Creates it |
| `"a"` | Append | Writes at the end | Creates it |
| `"r+"` | Read and write | Opens it | Returns `NULL` |
| `"w+"` | Read and write | **Erases** the contents | Creates it |
| `"a+"` | Read and append | Writes at the end | Creates it |
| `"rb"`, `"wb"`, `"ab"` | Binary modes | Same as above, binary | — |

**Always check whether `fopen` succeeded:**

```c
fp = fopen("data.txt", "r");
if (fp == NULL)
{
    printf("Could not open file\n");
    return 1;
}
```

### 4.3 Closing a file: `fclose`

```c
fclose(fp);
```

Always close files. It flushes buffers and releases the file handle.

### 4.4 Writing to a text file

```c
#include <stdio.h>

int main(void)
{
    FILE *fp = fopen("students.txt", "w");

    if (fp == NULL)
    {
        printf("Error opening file\n");
        return 1;
    }

    fprintf(fp, "Alice 20 45000.50\n");
    fprintf(fp, "Bob 21 42000.00\n");

    fclose(fp);
    printf("Data written\n");
    return 0;
}
```

- `fprintf` works like `printf`, but writes to a file.
- `fputs("Hello\n", fp)` writes a string.
- `fputc('A', fp)` writes one character.

### 4.5 Reading from a text file

**Using `fscanf` (formatted):**

```c
#include <stdio.h>

int main(void)
{
    FILE *fp = fopen("students.txt", "r");
    char name[50];
    int age;
    float fee;

    if (fp == NULL)
    {
        printf("Error opening file\n");
        return 1;
    }

    while (fscanf(fp, "%49s %d %f", name, &age, &fee) == 3)
        printf("%s %d %.2f\n", name, age, fee);

    fclose(fp);
    return 0;
}
```

**Using `fgets` (line by line):**

```c
char line[200];

while (fgets(line, sizeof(line), fp) != NULL)
    printf("%s", line);
```

**Using `fgetc` (character by character):**

```c
int ch;
while ((ch = fgetc(fp)) != EOF)
    putchar(ch);
```

### 4.6 End of file

- `EOF` is a special negative value returned by input functions when the end is reached.
- `fgetc` returns `EOF`.
- `fgets` returns `NULL`.
- `fscanf` returns the number of items successfully read (or `EOF`).

**Do not use `while (!feof(fp))`** — it often processes the last line twice. Use the return value of the read function instead.

### 4.7 `fprintf` vs `printf`, `fscanf` vs `scanf`

| Console | File |
|---|---|
| `printf(...)` | `fprintf(fp, ...)` |
| `scanf(...)` | `fscanf(fp, ...)` |
| `fgets`/`fputs` | same, with `fp` |
| `fgetc`/`fputc` | same, with `fp` |

### 4.8 Counting lines, words and characters

```c
#include <stdio.h>

int main(void)
{
    FILE *fp = fopen("data.txt", "r");
    int ch, lines = 0, words = 0, chars = 0;
    int in_word = 0;

    if (fp == NULL)
    {
        printf("Cannot open file\n");
        return 1;
    }

    while ((ch = fgetc(fp)) != EOF)
    {
        chars++;

        if (ch == '\n')
            lines++;

        if (ch == ' ' || ch == '\n' || ch == '\t')
            in_word = 0;
        else if (!in_word)
        {
            in_word = 1;
            words++;
        }
    }

    fclose(fp);
    printf("Lines = %d, Words = %d, Characters = %d\n", lines, words, chars);
    return 0;
}
```

### 4.9 Writing and reading structs

```c
typedef struct
{
    char name[50];
    int age;
    float fee;
} Student;

/* Write */
Student s = {"Alice", 20, 45000.50};
FILE *fp = fopen("student.dat", "wb");
fwrite(&s, sizeof(Student), 1, fp);
fclose(fp);

/* Read */
fp = fopen("student.dat", "rb");
fread(&s, sizeof(Student), 1, fp);
fclose(fp);
```

`fwrite`/`fread` are used for **binary** files. They are fast but not human-readable and are platform-dependent.

### 4.10 Other useful file functions

| Function | Purpose |
|---|---|
| `fopen`, `fclose` | Open/close |
| `fprintf`, `fscanf` | Formatted text I/O |
| `fgets`, `fputs` | Line/string I/O |
| `fgetc`, `fputc` | Character I/O |
| `fread`, `fwrite` | Binary block I/O |
| `feof(fp)` | Non-zero if end-of-file indicator is set |
| `ferror(fp)` | Non-zero if an error occurred |
| `rewind(fp)` | Go back to the beginning |
| `fseek(fp, offset, whence)` | Move to a position |
| `ftell(fp)` | Current position |
| `remove("file")` | Delete a file |
| `rename("old", "new")` | Rename a file |

---

## 5. Worked exam program: student records

```c
#include <stdio.h>
#include <string.h>

typedef struct
{
    char name[50];
    int age;
    float fee;
} Student;

void print_student(const Student *s)
{
    printf("%-15s %5d %10.2f\n", s->name, s->age, s->fee);
}

int main(void)
{
    Student list[3] = {
        {"Alice", 20, 45000.50},
        {"Bob",   21, 42000.00},
        {"Carol", 19, 47000.75}
    };
    int i;
    FILE *fp;

    printf("%-15s %5s %10s\n", "Name", "Age", "Fee");
    printf("---------------------------------\n");
    for (i = 0; i < 3; i++)
        print_student(&list[i]);

    fp = fopen("students.txt", "w");
    if (fp == NULL)
    {
        printf("Cannot create file\n");
        return 1;
    }

    for (i = 0; i < 3; i++)
        fprintf(fp, "%s %d %.2f\n", list[i].name, list[i].age, list[i].fee);

    fclose(fp);
    printf("Saved to students.txt\n");
    return 0;
}
```

---

## 6. Common errors

| Error | Explanation | Fix |
|---|---|---|
| Forgetting `;` after `struct { ... }` | Syntax error | Add `;` |
| Using `struct Student` as a type without `struct` | Unless `typedef` | `struct Student s;` or use `typedef` |
| `s.name = "Alice";` | Arrays are not assignable | `strcpy(s.name, "Alice");` |
| `p.name` when `p` is a pointer | Needs `->` | `p->name` |
| `sizeof(struct)` assumes sum of members | Padding may increase it | Explain padding |
| Union: reading a member you did not last write | Reinterprets bytes | Access only the active member |
| `fopen` result not checked | Crash on missing file | `if (fp == NULL)` |
| Wrong mode (`"w"` for reading) | Fails or erases data | Use `"r"` to read |
| Forgetting `fclose` | Data may not be flushed; file handle leak | Always close |
| `while (!feof(fp))` | Last record processed twice | Use the read function's return value |
| `scanf` instead of `fscanf` on a file | Reads from keyboard | Use `fscanf(fp, ...)` |
| File path wrong | `NULL` returned | Check the working directory |

---

## 7. Rapid revision

- `struct` groups different types; access with `.`, pointer access with `->`.
- `typedef struct { ... } Name;` lets you write `Name s;`.
- Array of structs: `Student list[50];`
- Nested struct: `s.dob.day`.
- Struct assignment copies all members.
- Pass large structs by pointer (`const Student *s`) to avoid copying.
- `union` members share memory; size = largest member; one active member.
- `enum` gives named integer constants.
- `FILE *fp = fopen("file", "mode");` — check for `NULL`.
- `"r"` read, `"w"` write (erases), `"a"` append.
- `fprintf`/`fscanf` for formatted file I/O; `fgets` for lines; `fgetc` for characters.
- Always `fclose(fp)`.

---

## 8. Self-test (answers below)

1. Define a structure. How is it different from an array?
2. Write a struct to store a book's title, author and price.
3. What is the difference between `.` and `->`?
4. What is `typedef` used for?
5. How do you declare an array of 30 students?
6. What is a nested structure? Give an example.
7. What is a union? How does its size compare with a struct's?
8. State three differences between a struct and a union.
9. What is an enum? Give an example.
10. What does `fopen` return if the file cannot be opened?
11. List the modes for opening a file and explain each.
12. What is the difference between `"w"` and `"a"`?
13. Why should you check the return value of `fopen`?
14. What is `EOF`?
15. Why is `while (!feof(fp))` discouraged?
16. Write a program to write 5 integers to a file and read them back.
17. What is the output?
    ```c
    struct Point { int x, y; };
    struct Point p = {3, 4};
    struct Point *q = &p;
    printf("%d %d\n", p.x, q->y);
    ```
18. What is the size of `union U { char c; int i; double d; };` typically?

### Answers

1. A user-defined type that groups variables of different types under one name. An array holds many elements of the **same** type; a struct holds **different** types.
2. `struct Book { char title[100]; char author[50]; float price; };`
3. `.` accesses a member of a struct variable; `->` accesses a member through a pointer to a struct.
4. To create an alias for a type, so you can write `Student s;` instead of `struct Student s;`.
5. `Student list[30];` (or `struct Student list[30];`).
6. A struct whose member is another struct, e.g. `struct Student { struct Date dob; ... };`.
7. A user-defined type whose members share the same memory. Its size is the size of the largest member (plus alignment), whereas a struct's size is at least the sum of its members.
8. Struct: separate memory, all members valid, size ≥ sum. Union: shared memory, one member valid, size = largest member.
9. A type with named integer constants: `enum Day { MON, TUE, WED };`.
10. `NULL`.
11. `"r"` read; `"w"` write (erase/create); `"a"` append (create); `"r+"` read/write existing; `"w+"` read/write (erase/create); `"a+"` read/append. Add `b` for binary.
12. `"w"` erases existing contents and starts from the beginning; `"a"` keeps existing contents and writes at the end.
13. Because `fopen` returns `NULL` on failure; using a `NULL` file pointer causes a crash.
14. A special value returned by input functions when the end of the file is reached.
15. The EOF indicator is set only **after** a read attempts to go past the end, so the loop body may run once more with stale data.
16. See the examples in §4.4 and §4.5.
17. `3 4`
18. **8 bytes** (the largest member is `double`).

---

**Next:** `11_formatted_io_and_reports.md`
