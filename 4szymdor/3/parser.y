%{
#include <stdio.h>
#include <stdlib.h>

extern FILE* yyin;
extern int yylex();
extern int yyparse();
extern int yylineno;

int numLines = 0;
int numVariables = 0;
int numIfStatements = 0;
int numWhileLoops = 0;
int numRepeatLoops = 0;

void yyerror(const char* msg) {
    fprintf(stderr, "Syntax error: %s at line %d\n", msg, yylineno);
    exit(1);
}

%}

%union {
    int integer;
    char* identifier;
}

%token <integer> INTEGER
%token <identifier> IDENTIFIER
%token IF THEN ELSE WHILE DO REPEAT UNTIL BREAK CONTINUE

%type <integer> expression
%type <integer> statement

%start program

%%

program : statements
        {
            printf("Syntax analysis completed.\n");
            printf("Number of lines: %d\n", numLines);
            printf("Number of variables: %d\n", numVariables);
            printf("Number of if statements: %d\n", numIfStatements);
            printf("Number of while loops: %d\n", numWhileLoops);
            printf("Number of repeat loops: %d\n", numRepeatLoops);
        }
        ;

statements : statement
           | statements statement
           ;

statement : IDENTIFIER ":=" expression ';'
          {
              numVariables++;
          }
          | IF expression THEN statement ELSE statement
          {
              numIfStatements++;
          }
          | WHILE expression DO statement
          {
              numWhileLoops++;
          }
          | REPEAT statements UNTIL expression ';'
          {
              numRepeatLoops++;
          }
          | BREAK ';'
          {
              $$ = 0;  // Return 0 for BREAK
          }
          | CONTINUE ';'
          {
              $$ = 0;  // Return 0 for CONTINUE
          }
          ;

expression : INTEGER
           ;

%%

int main(int argc, char** argv) {
    if (argc != 2) {
        fprintf(stderr, "Usage: %s <input_file>\n", argv[0]);
        return 1;
    }

    FILE* inputFile = fopen(argv[1], "r");
    if (!inputFile) {
        fprintf(stderr, "Failed to open input file.\n");
        return 1;
    }

    yyin = inputFile;
    yyparse();

    fclose(inputFile);
    return 0;
}

