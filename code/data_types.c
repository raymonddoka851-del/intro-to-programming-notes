#include <stdio.h>
#include <limits.h>
#include <float.h>

int main(void)
{
    printf("=== SIZES (bytes) ===\n");
    printf("char        : %zu\n", sizeof(char));
    printf("short       : %zu\n", sizeof(short));
    printf("int         : %zu\n", sizeof(int));
    printf("long        : %zu\n", sizeof(long));
    printf("long long   : %zu\n", sizeof(long long));
    printf("float       : %zu\n", sizeof(float));
    printf("double      : %zu\n", sizeof(double));
    printf("pointer     : %zu\n", sizeof(void *));

    printf("\n=== RANGES ===\n");
    printf("signed char : %d to %d\n", CHAR_MIN, CHAR_MAX);
    printf("short       : %d to %d\n", SHRT_MIN, SHRT_MAX);
    printf("int         : %d to %d\n", INT_MIN, INT_MAX);
    printf("unsigned int: 0 to %u\n", UINT_MAX);
    printf("float digits: %d significant\n", FLT_DIG);
    printf("double digits: %d significant\n", DBL_DIG);

    printf("\n=== CHARACTERS ===\n");
    char c = 'A';
    printf("'A' as char = %c, as int = %d\n", c, c);
    printf("'A' + 2 = %c (%d)\n", c + 2, c + 2);
    printf("'a' - 'A' = %d\n", 'a' - 'A');
    printf("'7' - '0' = %d\n", '7' - '0');

    printf("\n=== INTEGER VS FLOAT DIVISION ===\n");
    int a = 7, b = 2;
    printf("7 / 2       = %d\n", a / b);
    printf("7 %% 2       = %d\n", a % b);
    printf("(float)7 / 2 = %.2f\n", (float)a / b);

    printf("\n=== ARRAY SIZE ===\n");
    int arr[5] = {10, 20, 30, 40, 50};
    printf("sizeof(arr)       = %zu bytes\n", sizeof(arr));
    printf("number of elements = %zu\n", sizeof(arr) / sizeof(arr[0]));

    printf("\n=== FLOATING-POINT PRECISION ===\n");
    float f = 0.1f;
    printf("0.1f stored as      : %.20f\n", f);
    printf("1.0 / 3.0           : %.15f\n", 1.0 / 3.0);

    printf("\n=== UNSIGNED UNDERFLOW ===\n");
    unsigned int u = 0;
    u--;
    printf("unsigned 0 - 1 = %u\n", u);

    return 0;
}
