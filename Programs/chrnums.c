#include <stdio.h>

#define MAXLINE 1024

int main(int argc, char *argv[])
{
    FILE *infile, *outfile;
    int count, i;
    char buffer[MAXLINE];

    if (argc != 3) {
        printf("Usage: filecopy <source> <destination>\n");
        return 1;
    }

    infile = fopen(argv[1], "r");
    if (infile == NULL) {
        printf("Can't open input file: %s\n", argv[1]);
        exit(1);
    }

    outfile = fopen(argv[2], "w");
    if (outfile == NULL) {
        printf("Can't open output file: %s\n", argv[2]);
        exit(1);
    }

    while (fgets(buffer, MAXLINE, infile) != NULL) {
        count = 0;
        for (i = 0; buffer[i] != '\0'; i++)
            count++;

        printf("%d: %s", count, buffer);
        fprintf(outfile, "%d: %s", count, buffer);
    }

    fclose(infile);
    fclose(outfile);

    return 0;
}