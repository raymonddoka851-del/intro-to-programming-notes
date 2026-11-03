#include <stdio.h>

int main(void)
{
    int rows, i, j;

    printf("Enter the number of rows (1-20): ");

    if (scanf("%d", &rows) != 1 || rows < 1 || rows > 20)
    {
        printf("Invalid input.\n");
        return 1;
    }

    for (i = 1; i <= rows; i++)
    {
        for (j = 1; j <= rows - i; j++)
            printf(" ");

        for (j = 1; j <= 2 * i - 1; j++)
            printf("*");

        printf("\n");
    }

    return 0;
}
