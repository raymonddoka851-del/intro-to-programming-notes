#include <stdio.h>

#define MAX 100

int find_max(const int a[], int n);
int find_min(const int a[], int n);
long long find_sum(const int a[], int n);
void print_reverse(const int a[], int n);

int main(void)
{
    int a[MAX];
    int n, i;

    printf("How many numbers (1-%d)? ", MAX);

    if (scanf("%d", &n) != 1 || n < 1 || n > MAX)
    {
        printf("Invalid count.\n");
        return 1;
    }

    printf("Enter %d integers:\n", n);
    for (i = 0; i < n; i++)
        scanf("%d", &a[i]);

    long long sum = find_sum(a, n);

    printf("Sum     = %lld\n", sum);
    printf("Average = %.2f\n", (double)sum / n);
    printf("Maximum = %d\n", find_max(a, n));
    printf("Minimum = %d\n", find_min(a, n));

    printf("Reversed: ");
    print_reverse(a, n);
    printf("\n");

    return 0;
}

int find_max(const int a[], int n)
{
    int max = a[0];

    for (int i = 1; i < n; i++)
        if (a[i] > max)
            max = a[i];

    return max;
}

int find_min(const int a[], int n)
{
    int min = a[0];

    for (int i = 1; i < n; i++)
        if (a[i] < min)
            min = a[i];

    return min;
}

long long find_sum(const int a[], int n)
{
    long long sum = 0;

    for (int i = 0; i < n; i++)
        sum += a[i];

    return sum;
}

void print_reverse(const int a[], int n)
{
    for (int i = n - 1; i >= 0; i--)
        printf("%d ", a[i]);
}
