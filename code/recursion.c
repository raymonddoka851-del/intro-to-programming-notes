#include <stdio.h>

long long factorial_rec(int n);
int fibonacci_rec(int n);
int sum_digits_rec(int n);
int gcd_rec(int a, int b);
long long power_rec(int base, int exp);

int main(void)
{
    printf("factorial_rec(6)  = %lld\n", factorial_rec(6));
    printf("sum_digits_rec(12345) = %d\n", sum_digits_rec(12345));
    printf("gcd_rec(48, 18)   = %d\n", gcd_rec(48, 18));
    printf("power_rec(2, 10)  = %lld\n", power_rec(2, 10));

    printf("Fibonacci: ");
    for (int i = 0; i <= 10; i++)
        printf("%d ", fibonacci_rec(i));
    printf("\n");

    return 0;
}

long long factorial_rec(int n)
{
    if (n <= 1)                 /* base case */
        return 1;
    return n * factorial_rec(n - 1);
}

int fibonacci_rec(int n)
{
    if (n <= 1)                 /* base cases: fib(0)=0, fib(1)=1 */
        return n;
    return fibonacci_rec(n - 1) + fibonacci_rec(n - 2);
}

int sum_digits_rec(int n)
{
    if (n == 0)
        return 0;
    return (n % 10) + sum_digits_rec(n / 10);
}

int gcd_rec(int a, int b)
{
    if (b == 0)
        return a;
    return gcd_rec(b, a % b);
}

long long power_rec(int base, int exp)
{
    if (exp == 0)
        return 1;
    return base * power_rec(base, exp - 1);
}
