#include <stdio.h>

#define MAXLINE 1024

revline(str)
char str[];
{
    int left, right;
    int length;
    char hold;

    length = 0;
    while (str[length] != '\0')
        length++;

    if (length && str[length - 1] == '\n') {
        str[length - 1] = '\0';
        length--;
    }

    left = 0;
    right = length - 1;
    while (left < right) {
        hold = str[left];
        str[left] = str[right];
        str[right] = hold;
        left++;
        right--;
    }
}

int main(argc, argv)
int argc;
char *argv[];
{
    FILE *infile, *outfile;
    char buffer[MAXLINE];

    if (argc != 3) {
        printf("Usage: copy <infile> <outfile>\n");
        return;
    }

    infile = fopen(argv[1], "r");
    if (infile == NULL) {
        printf("Can’t open %s\n", argv[1]);
        exit();
    }

    outfile = fopen(argv[2], "w");
    if (outfile == NULL) {
        printf("Can’t open %s\n", argv[2]);
        exit();
    }

    while (fgets(buffer, MAXLINE, infile) != NULL) {
        revline(buffer);
        printf("%s\n", buffer);
        fprintf(outfile, "%s\n", buffer);
    }

    fclose(infile);
    fclose(outfile);
}
