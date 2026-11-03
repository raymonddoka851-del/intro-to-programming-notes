/*
 * file_records.c — writing and reading a text file
 *
 * The program asks for records, writes them to students.txt,
 * closes the file, then reopens it and reads the records back.
 *
 * Compile: gcc -Wall -Wextra file_records.c -o file_records
 */

#include <stdio.h>

#define FILE_NAME "students.txt"
#define MAX 50

typedef struct {
    char name[30];
    int age;
    float score;
} Student;

int main(void)
{
    Student s[MAX];
    int n, i;
    FILE *fp;

    printf("How many students (1-%d)? ", MAX);
    if (scanf("%d", &n) != 1 || n < 1 || n > MAX)
    {
        printf("Invalid count.\n");
        return 1;
    }

    for (i = 0; i < n; i++)
    {
        printf("Student %d (name age score): ", i + 1);
        if (scanf("%29s %d %f", s[i].name, &s[i].age, &s[i].score) != 3)
        {
            printf("Invalid record.\n");
            return 1;
        }
    }

    /* ---------- 1. Write records to the file ---------- */
    fp = fopen(FILE_NAME, "w");
    if (fp == NULL)
    {
        printf("Cannot open %s for writing.\n", FILE_NAME);
        return 1;
    }

    for (i = 0; i < n; i++)
        fprintf(fp, "%s %d %.2f\n", s[i].name, s[i].age, s[i].score);

    fclose(fp);
    printf("\n%d record(s) written to %s\n", n, FILE_NAME);

    /* ---------- 2. Read them back ---------- */
    fp = fopen(FILE_NAME, "r");
    if (fp == NULL)
    {
        printf("Cannot open %s for reading.\n", FILE_NAME);
        return 1;
    }

    printf("\n%-15s %5s %8s\n", "NAME", "AGE", "SCORE");
    printf("--------------------------------\n");

    i = 0;
    while (i < MAX &&
           fscanf(fp, "%29s %d %f", s[i].name, &s[i].age, &s[i].score) == 3)
    {
        printf("%-15s %5d %8.2f\n", s[i].name, s[i].age, s[i].score);
        i++;
    }

    fclose(fp);
    printf("\n%d record(s) read back.\n", i);

    return 0;
}
