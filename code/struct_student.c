/*
 * struct_student.c — structures, typedef, array of structs, arrow operator
 *
 * Compile: gcc -Wall -Wextra struct_student.c -o struct_student
 */

#include <stdio.h>

#define MAX 50

typedef struct {
    char name[30];
    int age;
    float score;
} Student;

void read_students(Student s[], int n);
void print_students(const Student s[], int n);
float average_score(const Student s[], int n);
int best_student(const Student s[], int n);

int main(void)
{
    Student s[MAX];
    int n;

    printf("How many students (1-%d)? ", MAX);
    if (scanf("%d", &n) != 1 || n < 1 || n > MAX)
    {
        printf("Invalid count.\n");
        return 1;
    }

    read_students(s, n);
    print_students(s, n);

    int best = best_student(s, n);

    printf("\nClass average : %.2f\n", average_score(s, n));
    printf("Best student  : %s (%.2f)\n", s[best].name, s[best].score);

    return 0;
}

void read_students(Student s[], int n)
{
    for (int i = 0; i < n; i++)
    {
        printf("\nStudent %d\n", i + 1);
        printf("  Name  : ");
        scanf("%29s", s[i].name);       /* array name needs no & */
        printf("  Age   : ");
        scanf("%d", &s[i].age);
        printf("  Score : ");
        scanf("%f", &s[i].score);
    }
}

void print_students(const Student s[], int n)
{
    printf("\n%-15s %5s %8s\n", "NAME", "AGE", "SCORE");
    printf("--------------------------------\n");

    for (int i = 0; i < n; i++)
        printf("%-15s %5d %8.2f\n", s[i].name, s[i].age, s[i].score);
}

float average_score(const Student s[], int n)
{
    float sum = 0.0f;

    for (int i = 0; i < n; i++)
        sum += s[i].score;

    return sum / n;
}

/* Return the index of the student with the highest score */
int best_student(const Student s[], int n)
{
    int best = 0;

    for (int i = 1; i < n; i++)
        if (s[i].score > s[best].score)
            best = i;

    return best;
}
