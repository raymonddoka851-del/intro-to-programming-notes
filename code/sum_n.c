#include <stdio.h>

int main(void)
{
    long long n, i, sum = 0;

    printf("Enter a positive integer N: ");

    if (scanf("%lld", &n) != 1 || n < 1)
    {
        printf("Invalid input.\n");
        return 1;
    }

    for (i = 1; i <= n; i++)
        sum += i;

    printf("Sum of 1 to %lld = %lld\n", n, sum);

    return 0;
}
