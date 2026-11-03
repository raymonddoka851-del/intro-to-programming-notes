#include <stdio.h>

int main(void)
{
    int n, i;
    long long factorial = 1;

    printf("Enter a positive integer (0-20): ");

    if (scanf("%d", &n) != 1 || n < 0 || n > 20)
    {
        printf("Invalid input. Use 0 to 20.\n");
        return 1;
    }

    for (i = 1; i <= n; i++)
        factorial *= i;

    printf("%d! = %lld\n", n, factorial);

    return 0;
}
