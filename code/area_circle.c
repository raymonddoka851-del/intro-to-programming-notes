#include <stdio.h>
#define PI 3.14159265

int main(void)
{
    double radius, area, circumference;

    printf("Enter the radius: ");

    if (scanf("%lf", &radius) != 1 || radius < 0)
    {
        printf("Invalid radius.\n");
        return 1;
    }

    area = PI * radius * radius;
    circumference = 2 * PI * radius;

    printf("Radius        = %.2f\n", radius);
    printf("Area          = %.2f\n", area);
    printf("Circumference = %.2f\n", circumference);

    return 0;
}
