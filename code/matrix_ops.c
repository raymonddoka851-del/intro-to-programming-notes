/*
 * matrix_ops.c — 2D arrays: addition, transpose and multiplication
 *
 *   A is 2 x 3, B is 2 x 3, C is 3 x 2.
 *   sum     = A + B          (2 x 3)
 *   t       = transpose(A)   (3 x 2)
 *   product = A x C          (2 x 2)
 *
 * Compile: gcc -Wall -Wextra matrix_ops.c -o matrix_ops
 */

#include <stdio.h>

#define ROWS 2
#define COLS 3

void print_2x3(const int m[][COLS], int rows);
void print_3x2(const int m[][2], int rows);

int main(void)
{
    int a[ROWS][COLS] = {{1, 2, 3}, {4, 5, 6}};
    int b[ROWS][COLS] = {{7, 8, 9}, {10, 11, 12}};
    int sum[ROWS][COLS];
    int t[COLS][ROWS];
    int c[COLS][2] = {{7, 8}, {9, 10}, {11, 12}};
    int product[ROWS][2] = {{0, 0}, {0, 0}};
    int i, j, k;

    /* 1. Addition: add element by element */
    for (i = 0; i < ROWS; i++)
        for (j = 0; j < COLS; j++)
            sum[i][j] = a[i][j] + b[i][j];

    /* 2. Transpose: rows become columns */
    for (i = 0; i < ROWS; i++)
        for (j = 0; j < COLS; j++)
            t[j][i] = a[i][j];

    /* 3. Multiplication: (2x3) x (3x2) = (2x2) */
    for (i = 0; i < ROWS; i++)
        for (j = 0; j < 2; j++)
            for (k = 0; k < COLS; k++)
                product[i][j] += a[i][k] * c[k][j];

    printf("A (2x3):\n");
    print_2x3(a, ROWS);

    printf("\nB (2x3):\n");
    print_2x3(b, ROWS);

    printf("\nA + B:\n");
    print_2x3(sum, ROWS);

    printf("\nTranspose of A:\n");
    print_3x2(t, COLS);

    printf("\nC (3x2):\n");
    for (i = 0; i < COLS; i++)
    {
        for (j = 0; j < 2; j++)
            printf("%4d", c[i][j]);
        printf("\n");
    }

    printf("\nA x C (2x2):\n");
    for (i = 0; i < ROWS; i++)
    {
        for (j = 0; j < 2; j++)
            printf("%4d", product[i][j]);
        printf("\n");
    }

    return 0;
}

void print_2x3(const int m[][COLS], int rows)
{
    for (int i = 0; i < rows; i++)
    {
        for (int j = 0; j < COLS; j++)
            printf("%4d", m[i][j]);
        printf("\n");
    }
}

void print_3x2(const int m[][2], int rows)
{
    for (int i = 0; i < rows; i++)
    {
        for (int j = 0; j < 2; j++)
            printf("%4d", m[i][j]);
        printf("\n");
    }
}
