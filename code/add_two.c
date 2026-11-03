#include <stdio.h>

int main(void)
{
    int a, b, sum;

    printf("Enter two integers: ");

    if (scanf("%d %d", &a, &b) != 2)
    {
        printf("Invalid input. Please enter two integers.\n");
        return 1;
    }

    sum = a + b;
    printf("%d + %d = %d\n", a, b, sum);

    return 0;
}
