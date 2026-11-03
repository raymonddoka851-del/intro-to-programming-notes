#include <stdio.h>

int main(void)
{
    int a = 10, b = 3;

    printf("=== ARITHMETIC ===\n");
    printf("a + b  = %d\n", a + b);
    printf("a - b  = %d\n", a - b);
    printf("a * b  = %d\n", a * b);
    printf("a / b  = %d  (integer division)\n", a / b);
    printf("a %% b  = %d  (remainder)\n", a % b);
    printf("(float)a / b = %.2f\n", (float)a / b);

    printf("\n=== RELATIONAL ===\n");
    printf("a == b : %d\n", a == b);
    printf("a != b : %d\n", a != b);
    printf("a >  b : %d\n", a > b);
    printf("a <  b : %d\n", a < b);
    printf("a >= b : %d\n", a >= b);
    printf("a <= b : %d\n", a <= b);

    printf("\n=== LOGICAL ===\n");
    printf("a > 5 && b > 5 : %d\n", a > 5 && b > 5);
    printf("a > 5 || b > 5 : %d\n", a > 5 || b > 5);
    printf("!(a > b)       : %d\n", !(a > b));
    printf("!0 = %d, !5 = %d\n", !0, !5);

    printf("\n=== BITWISE (a=60, b=13) ===\n");
    int x = 60, y = 13;
    printf("60 & 13  = %d\n", x & y);
    printf("60 | 13  = %d\n", x | y);
    printf("60 ^ 13  = %d\n", x ^ y);
    printf("~60      = %d\n", ~x);
    printf("60 << 2  = %d\n", x << 2);
    printf("60 >> 2  = %d\n", x >> 2);

    printf("\n=== INCREMENT / DECREMENT ===\n");
    int i = 5, r;
    r = i++;
    printf("r = i++  -> r=%d, i=%d\n", r, i);
    i = 5;
    r = ++i;
    printf("r = ++i  -> r=%d, i=%d\n", r, i);
    i = 5;
    r = i--;
    printf("r = i--  -> r=%d, i=%d\n", r, i);
    i = 5;
    r = --i;
    printf("r = --i  -> r=%d, i=%d\n", r, i);

    printf("\n=== CONDITIONAL AND PRECEDENCE ===\n");
    int m = 9;
    printf("m > 5 ? 1 : 4 = %d\n", (m > 5) ? 1 : 4);
    printf("7 + 3 * 2     = %d\n", 7 + 3 * 2);
    printf("(7 + 3) * 2   = %d\n", (7 + 3) * 2);
    printf("10 - 4 - 3    = %d\n", 10 - 4 - 3);
    printf("20 / 4 * 2    = %d\n", 20 / 4 * 2);

    return 0;
}
