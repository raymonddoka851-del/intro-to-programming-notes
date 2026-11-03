#include <stdio.h>

int main(void)
{
    char grade;

    printf("Enter grade (A-F): ");

    if (scanf(" %c", &grade) != 1)
    {
        printf("Invalid input.\n");
        return 1;
    }

    switch (grade)
    {
        case 'A':
        case 'a':
            printf("Outstanding!\n");
            break;
        case 'B':
        case 'b':
            printf("Excellent!\n");
            break;
        case 'C':
        case 'c':
            printf("Well done\n");
            break;
        case 'D':
        case 'd':
            printf("You passed\n");
            break;
        case 'F':
        case 'f':
            printf("Better try again\n");
            break;
        default:
            printf("Invalid grade\n");
    }

    return 0;
}
