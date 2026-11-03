#include <stdio.h>

/* Prototypes */
int add(int a, int b);
int max_of_two(int a, int b);
int is_even(int n);
long long factorial(int n);
void print_line(void);
void print_sum(int a, int b);
int read_positive(void);

int main(void)
{
    print_line();
    printf("add(3, 4)        = %d\n", add(3, 4));
    printf("max_of_two(7, 2) = %d\n", max_of_two(7, 2));
    printf("is_even(10)      = %d\n", is_even(10));
    printf("factorial(5)     = %lld\n", factorial(5));
    print_line();

    print_sum(8, 12);
    print_line();

    int n = read_positive();
    printf("You entered %d\n", n);
    print_line();

    return 0;
}

/* Function with arguments and a return value */
int add(int a, int b)
{
    return a + b;
}

int max_of_two(int a, int b)
{
    if (a > b)
        return a;
    return b;
}

int is_even(int n)
{
    return (n % 2 == 0);
}

long long factorial(int n)
{
    long long result = 1;
    int i;

    for (i = 1; i <= n; i++)
        result *= i;

    return result;
}

/* Function with no arguments and no return value */
void print_line(void)
{
    printf("------------------------------\n");
}

/* Function with arguments and no return value */
void print_sum(int a, int b)
{
    printf("Sum of %d and %d = %d\n", a, b, a + b);
}

/* Function with no arguments and a return value */
int read_positive(void)
{
    int n;

    do
    {
        printf("Enter a positive integer: ");

        if (scanf("%d", &n) != 1)
        {
            while (getchar() != '\n')
                ;               /* discard invalid input */
            n = 0;
        }
    } while (n <= 0);

    return n;
}
