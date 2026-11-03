/*
 * report_table.c — formatted output and a simple report
 *
 * Demonstrates field widths, precision, alignment, totals,
 * averages and a grade column.
 *
 * Compile: gcc -Wall -Wextra report_table.c -o report_table
 */

#include <stdio.h>

#define STUDENTS 4
#define SUBJECTS 3

typedef struct {
    char name[20];
    int score[SUBJECTS];
    int total;
    float average;
    char grade;
} Record;

char grade_of(float average);
void print_line(void);

int main(void)
{
    Record r[STUDENTS] = {
        {"Alice",   {78, 85, 90}, 0, 0.0f, ' '},
        {"Bob",     {55, 62, 48}, 0, 0.0f, ' '},
        {"Charlie", {92, 88, 95}, 0, 0.0f, ' '},
        {"Diana",   {40, 35, 58}, 0, 0.0f, ' '}
    };
    int i, j;

    float class_total = 0.0f;
    int highest = 0;

    /* ---------- Process ---------- */
    for (i = 0; i < STUDENTS; i++)
    {
        r[i].total = 0;

        for (j = 0; j < SUBJECTS; j++)
            r[i].total += r[i].score[j];

        r[i].average = (float)r[i].total / SUBJECTS;
        r[i].grade = grade_of(r[i].average);

        class_total += r[i].average;

        if (r[i].total > r[highest].total)
            highest = i;
    }

    /* ---------- Report header ---------- */
    printf("\n");
    printf("           STA 121 / CSC 112 - RESULTS REPORT\n");
    print_line();

    printf("%-12s %7s %7s %7s %7s %8s %6s\n",
           "NAME", "TEST 1", "TEST 2", "EXAM", "TOTAL", "AVERAGE", "GRADE");
    print_line();

    /* ---------- Rows ---------- */
    for (i = 0; i < STUDENTS; i++)
    {
        printf("%-12s", r[i].name);

        for (j = 0; j < SUBJECTS; j++)
            printf("%7d", r[i].score[j]);

        printf("%7d %8.2f %6c\n",
               r[i].total, r[i].average, r[i].grade);
    }

    print_line();

    /* ---------- Summary ---------- */
    printf("Class average : %.2f\n", class_total / STUDENTS);
    printf("Best student  : %s (total %d)\n",
           r[highest].name, r[highest].total);
    printf("Students      : %d\n", STUDENTS);
    print_line();

    return 0;
}

/* Simple grading scale - adjust the thresholds to your institution */
char grade_of(float average)
{
    if (average >= 70.0f) return 'A';
    if (average >= 60.0f) return 'B';
    if (average >= 50.0f) return 'C';
    if (average >= 45.0f) return 'D';
    if (average >= 40.0f) return 'E';
    return 'F';
}

void print_line(void)
{
    for (int i = 0; i < 60; i++)
        putchar('-');
    putchar('\n');
}
