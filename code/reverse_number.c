#include <stdio.h>

int main(void)
{
    long long n, digit, reverse = 0;
    int negative = 0;

    printf("Enter an integer: ");

    if (scanf("%lld", &n) != 1)
    {
        printf("Invalid input.\n");
        return 1;
    }

    if (n < 0)
    {
        negative = 1;
        n = -n;
    }

    do
    {
        digit = n % 10;
        reverse = reverse * 10 + digit;
        n /= 10;
    } while (n > 0);

    if (negative && reverse != 0)
        printf("-");

    printf("%lld\n", reverse);

    return 0;
}
