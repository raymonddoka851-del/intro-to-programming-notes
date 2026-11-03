/*
 * pointer_swap.c — call by value vs call by reference
 *
 * Key idea:
 *   swap_by_value receives COPIES, so the caller's variables do not change.
 *   swap_by_pointer receives ADDRESSES, so it can change the originals.
 *
 * Compile: gcc -Wall -Wextra pointer_swap.c -o pointer_swap
 */

#include <stdio.h>

void swap_by_value(int a, int b);
void swap_by_pointer(int *a, int *b);
int sum_array(const int *a, int n);

int main(void)
{
    int x = 10, y = 20;

    printf("Before          : x = %d, y = %d\n", x, y);

    swap_by_value(x, y);
    printf("After by value  : x = %d, y = %d   (unchanged)\n", x, y);

    swap_by_pointer(&x, &y);
    printf("After by pointer: x = %d, y = %d   (swapped)\n", x, y);

    /* An array name is the address of its first element */
    int a[5] = {10, 20, 30, 40, 50};
    int *p = a;                 /* same as &a[0] */

    printf("\nArray through a pointer:\n");
    for (int i = 0; i < 5; i++)
        printf("  *(p + %d) = %d\n", i, *(p + i));

    printf("\nThree ways to reach a[2]:\n");
    printf("  a[2]     = %d\n", a[2]);
    printf("  *(a + 2) = %d\n", *(a + 2));
    printf("  p[2]     = %d\n", p[2]);

    printf("\nsum_array = %d\n", sum_array(a, 5));

    /* Dereferencing lets you change the original variable */
    int value = 99;
    int *q = &value;

    printf("\nvalue = %d, *q = %d\n", value, *q);
    printf("q holds address %p\n", (void *)q);

    *q = 100;
    printf("After *q = 100, value = %d\n", value);

    return 0;
}

/* Copies only: no effect on the caller */
void swap_by_value(int a, int b)
{
    int temp = a;
    a = b;
    b = temp;

    printf("  inside swap_by_value: a = %d, b = %d\n", a, b);
}

/* a and b are pointers to the caller's variables */
void swap_by_pointer(int *a, int *b)
{
    int temp = *a;
    *a = *b;
    *b = temp;
}

/* const promises the function will not modify the array */
int sum_array(const int *a, int n)
{
    int sum = 0;

    for (int i = 0; i < n; i++)
        sum += a[i];

    return sum;
}
