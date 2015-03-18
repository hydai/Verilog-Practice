#include <stdio.h>
#include <stdlib.h>

void errorDump(const char errorMessage[]); 
void f2v(FILE *, FILE *);
int main(int argc, char *argv[])
{
    if (argc < 2) {
        errorDump("Too less args!");
    }
    FILE *inputFile, *outputFile;
    inputFile = fopen(argv[1], "r");
    outputFile = fopen(argv[2], "w");
    if (inputFile == NULL || outputFile == NULL) {
        errorDump("Cannot open the input or output file");
    }

    f2v(inputFile, outputFile);
    fclose(inputFile);
    fclose(outputFile);

    printf("Translate %s to %s done.\n", argv[1], argv[2]);
    return 0;
}

void errorDump(const char errorMessage[]) {
    fprintf(stderr, "%s\n", errorMessage);
    exit(1);
}
void f2v(FILE *inputFile, FILE *outputFile) {
    char tmpChar;
    while ((tmpChar = fgetc(inputFile)) != EOF) {
        if (tmpChar == '{') {
            fprintf(outputFile, "begin");
        }
        else if (tmpChar == '}') {
            fprintf(outputFile, "end");
        }
        else {
            fputc(tmpChar, outputFile);
        }
    }
}
