#include <stdio.h>

#define MAX 100

int main(void)
{
    int a[MAX];
    int n, i, j, temp;

    printf("How many numbers (1-%d)? ", MAX);

    if (scanf("%d", &n) != 1 || n < 1 || n > MAX)
    {
        printf("Invalid count.\n");
        return 1;
    }

    printf("Enter %d integers:\n", n);
    for (i = 0; i < n; i++)
        scanf("%d", &a[i]);

    /* Bubble sort: ascending order */
    for (i = 0; i < n - 1; i++)
    {
        for (j = 0; j < n - 1 - i; j++)
        {
            if (a[j] > a[j + 1])
            {
                temp = a[j];
                a[j] = a[j + 1];
                a[j + 1] = temp;
            }
        }
    }

    printf("Sorted: ");
    for (i = 0; i < n; i++)
        printf("%d ", a[i]);
    printf("\n");

    return 0;
}
