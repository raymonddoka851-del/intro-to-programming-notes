#include <stdio.h>

int main(void)
{
    int a, b, c;

    printf("Enter three integers: ");

    if (scanf("%d %d %d", &a, &b, &c) != 3)
    {
        printf("Invalid input.\n");
        return 1;
    }

    if (a >= b && a >= c)
        printf("%d is the largest.\n", a);
    else if (b >= a && b >= c)
        printf("%d is the largest.\n", b);
    else
        printf("%d is the largest.\n", c);

    return 0;
}
