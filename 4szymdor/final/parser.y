a%{
#include <stdio.h>
#include <string.h>

int yyerror(char *);
extern int yylval;

int lines = 0;
int variables = 0;
int consts = 0;

int numberIf = 0;
int numberWhile = 0;
int numberRepeat = 0;
int numberFor = 0;
int numberAssign = 0;
int numberBreak = 0;
int numberExit = 0;
int numberHalt = 0;
int numberWrite = 0;
int numberRead = 0;

%}

%token PROGRAM NAZWA USES VAR CYFRY TWODOTS OF CONST NAPIS FUNCTION HALT TBEGIN END ASSIGN IF THEN ELSE NOT WRITE WRITELN READ READLN EXIT BREAK WHILE DO REPEAT UNTIL FOR TO DOWNTO INTEGER REAL BOOLEAN CHARACTER STRING ARRAY SEMICOLON COMMA COLON SQR_BR_LEFT SQR_BR_RIGHT EQUAL DOT APOSTROF AND OR LEQ GEQ

%%

START           : PROGRAM NAZWA SEMICOLON BLOKI END_OF_FILE {printf("\nProgram execution finished\n"); return 0;}
                ;

BLOKI           : BIBLIOTEKI ZMIENNE STALE FUNKCJE BLOK_INSTRUKCJI
                | BIBLIOTEKI STALE ZMIENNE FUNKCJE BLOK_INSTRUKCJI
                ;

BIBLIOTEKI      : USES ListaBibliotek SEMICOLON
                | /* epsilon */
                ;

ListaBibliotek  : ListaBibliotek COMMA NAZWA
                | NAZWA
                ;

ZMIENNE         : VAR ListaZmiennych
                | /* epsilon */
                ;

ListaZmiennych  : ListaZmiennych zmienna SEMICOLON
                | zmienna SEMICOLON
                ;

zmienna         : zm COLON typ
                ;

zm              : zm COMMA NAZWA 
                | NAZWA                                                         {++variables;}
                ;

typ             : prosty
                | tablicowy
                ;

prosty          : INTEGER
                | REAL
                | BOOLEAN
                | CHARACTER
                | STRING
                ;

tablicowy       : ARRAY SQR_BR_LEFT CYFRY TWODOTS CYFRY SQR_BR_RIGHT OF prosty
                ;

STALE           : CONST ListaStalych
                | /* epsilon */
                ;

ListaStalych    : ListaStalych stala SEMICOLON
                | stala SEMICOLON
                ;
            
stala           : st EQUAL wartosc
                ;

st              : st COMMA NAZWA 
                | NAZWA                                                     {++consts;}
                ;

wartosc         : CYFRY
                | CYFRY DOT CYFRY
                | NAPIS 
                | NAZWA
                | wartosc '-' wartosc
                | wartosc '+' wartosc
                | wartosc '*' wartosc
                | wartosc '/' wartosc
                | wartosc '%' wartosc
                ;

FUNKCJE         : FUNKCJE funkcja 
                | funkcja
                | /* epsilon */
                ;

funkcja         : FUNCTION NAZWA '(' parametry_dekl ')' COLON typ SEMICOLON ZMIENNE STALE BLOK_INSTRUKCJI                     
                ;

parametry_dekl  : parametry_dekl SEMICOLON zmienna
                | zmienna 
                | /* epsilon */
                ;

BLOK_INSTRUKCJI : TBEGIN BODY END
                ;

BODY            : BODY EXPRESSION                                    
                | EXPRESSION
                ;

EXPRESSION      : PRZYPISANIE                   
                | WARUNEK
                | PETLA
                | PRZERWANIE
                | ZAPIS
                | ODCZYT
                ;

PRZYPISANIE     : NAZWA ASSIGN wartosc SEMICOLON                            {++numberAssign;}
                | NAZWA ASSIGN NAZWA '(' wartosc ')' SEMICOLON              {++numberAssign;}
                | NAZWA ASSIGN NAZWA '(' ')' SEMICOLON                      {++numberAssign;}
                ;

WARUNEK         : IF ZALOZENIA THEN BLOK_INSTRUKCJI                                                                 {++numberIf;}
                | IF ZALOZENIA THEN BLOK_INSTRUKCJI ELSE BLOK_INSTRUKCJI                                            {++numberIf;}
                | IF ZALOZENIA THEN BLOK_INSTRUKCJI ELSE IF ZALOZENIA THEN BLOK_INSTRUKCJI ELSE BLOK_INSTRUKCJI     {++numberIf;}
                ;

ZALOZENIA       : ZALOZENIE AND ZALOZENIA
                | ZALOZENIE OR ZALOZENIA
                | ZALOZENIE
                ;

ZALOZENIE       : wartosc EQUAL wartosc
                | wartosc '<' wartosc
                | wartosc '>' wartosc
                | wartosc LEQ wartosc
                | wartosc GEQ wartosc
                | NOT wartosc
                ;

ZAPIS           : WRITE_ST
                | WRITELN_ST
                ;

WRITE_ST        : WRITE '(' wartosci ')' SEMICOLON                                  {++numberWrite;}
                ;

WRITELN_ST      : WRITELN '(' wartosci ')' SEMICOLON                                {++numberWrite;}
                ;
        
wartosci        : wartosci COMMA wartosc
                | wartosc
                ;

ODCZYT          : READ_ST
                | READLN_ST
                ;

READ_ST         : READ '(' zm ')' SEMICOLON                                         {++numberRead;}
                ;

READLN_ST       : READLN '(' zm ')' SEMICOLON                                       {++numberRead;}
                ;

PRZERWANIE      : EXIT SEMICOLON                                                    {++numberExit;}
                | BREAK SEMICOLON                                                   {++numberBreak;}
                | HALT SEMICOLON                                                    {++numberHalt;}
                ;

PETLA           : WHILE_ST
                | REPEAT_ST
                | FOR_ST
                ;

WHILE_ST        : WHILE ZALOZENIE DO BLOK_INSTRUKCJI                                {++numberWhile;}
                ;

REPEAT_ST       : REPEAT BODY UNTIL ZALOZENIE SEMICOLON                             {++numberRepeat;}
                ;

FOR_ST          : FOR NAZWA ASSIGN wartosc TO CYFRY DO BLOK_INSTRUKCJI              {++numberAssign; ++numberFor;}
                | FOR NAZWA ASSIGN wartosc DOWNTO CYFRY DO BLOK_INSTRUKCJI          {++numberAssign; ++numberFor;}
                | FOR NAZWA ASSIGN wartosc TO NAZWA DO BLOK_INSTRUKCJI              {++numberAssign; ++numberFor;}
                | FOR NAZWA ASSIGN wartosc DOWNTO NAZWA DO BLOK_INSTRUKCJI          {++numberAssign; ++numberFor;}
                ;

END_OF_FILE     :   DOT
                ;

%%

int main() {
    printf("Scanning program...\n");
    yyparse();
    
    printf("\nPrzypisania: %d\n", numberAssign);
    printf("IF: %d\n", numberIf);
    printf("WHILE: %d\n", numberWhile);
    printf("REPEAT: %d\n", numberRepeat);
    printf("FOR: %d\n", numberFor);
    printf("BREAK: %d\n", numberBreak);
    printf("EXIT: %d\n", numberExit);
    printf("HALT: %d\n", numberHalt);
    printf("WRITE | WRITELN: %d\n", numberWrite);
    printf("READ | READLN: %d\n", numberRead);
    
    printf("Zmienne: %d\n", variables);
    printf("Stale: %d\n", consts);
    printf("Linijki kodu: %d\n\n", yylval);

    return 0;
}

int yyerror(char *s) {
    printf("Błąd: %s\n", s);
    return 0;
}
