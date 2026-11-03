/*
 * string_demo.c — strings without and with <string.h>
 *
 * Demonstrates: length, reverse, palindrome, vowel count,
 * word count and conversion to uppercase.
 *
 * Compile: gcc -Wall -Wextra string_demo.c -o string_demo
 */

#include <stdio.h>
#include <string.h>

#define SIZE 100

int my_strlen(const char s[]);
void reverse(char s[]);
int is_palindrome(const char s[]);
int count_vowels(const char s[]);
void to_upper(char s[]);
int count_words(const char s[]);

int main(void)
{
    char text[SIZE];
    char work[SIZE];

    printf("Enter a line of text: ");
    if (fgets(text, sizeof(text), stdin) == NULL)
    {
        printf("No input.\n");
        return 1;
    }

    /* fgets keeps the newline; remove it */
    text[strcspn(text, "\n")] = '\0';

    printf("\nOriginal    : \"%s\"\n", text);
    printf("Length      : %d\n", my_strlen(text));

    strcpy(work, text);
    reverse(work);
    printf("Reversed    : \"%s\"\n", work);

    printf("Palindrome? : %s\n", is_palindrome(text) ? "Yes" : "No");
    printf("Vowels      : %d\n", count_vowels(text));
    printf("Words       : %d\n", count_words(text));

    strcpy(work, text);
    to_upper(work);
    printf("Uppercase   : \"%s\"\n", work);

    return 0;
}

/* strlen written by hand: count until the null terminator */
int my_strlen(const char s[])
{
    int len = 0;

    while (s[len] != '\0')
        len++;

    return len;
}

/* Reverse in place using two indices */
void reverse(char s[])
{
    int i, j;
    char temp;

    for (i = 0, j = my_strlen(s) - 1; i < j; i++, j--)
    {
        temp = s[i];
        s[i] = s[j];
        s[j] = temp;
    }
}

/* A palindrome reads the same forwards and backwards */
int is_palindrome(const char s[])
{
    int i, j;

    for (i = 0, j = my_strlen(s) - 1; i < j; i++, j--)
        if (s[i] != s[j])
            return 0;

    return 1;
}

int count_vowels(const char s[])
{
    int i, count = 0;

    for (i = 0; s[i] != '\0'; i++)
    {
        char c = s[i];

        if (c == 'a' || c == 'e' || c == 'i' || c == 'o' || c == 'u' ||
            c == 'A' || c == 'E' || c == 'I' || c == 'O' || c == 'U')
            count++;
    }

    return count;
}

/* Manual uppercase: 'a' is 97 and 'A' is 65, so subtract 32 */
void to_upper(char s[])
{
    int i;

    for (i = 0; s[i] != '\0'; i++)
        if (s[i] >= 'a' && s[i] <= 'z')
            s[i] = s[i] - 32;
}

/* Count words by detecting the start of each word */
int count_words(const char s[])
{
    int i, count = 0, in_word = 0;

    for (i = 0; s[i] != '\0'; i++)
    {
        if (s[i] == ' ' || s[i] == '\t')
        {
            in_word = 0;
        }
        else if (!in_word)
        {
            in_word = 1;
            count++;
        }
    }

    return count;
}
