%{
#include <stdio.h>
#include <string.h>

int yyerror(char *);
extern int yylval;

int lines = 0;
int variables = 0;
int consts = 0;
int numIf = 0;
int numWhile = 0;
int numRepeat = 0;
int numFor = 0;
int numAssign = 0;
int numBreak = 0;
int numExit = 0;
int numHalt = 0;
int numWrite = 0;
int numRead = 0;

%}

%token PROGRAM NAZWA TBEGIN END        

%token DWUKROPEK SREDNIK PRZECINEK TABLICA_LEFT TABLICA_RIGHT
%token ROWNE KROPKA DWIEKROPKI APOSTROF

%token CONST VAR INTEGER REAL BOOLEAN CHARACTER STRING ASSIGN

%token ARRAY OF

%token AND OR MNIEJSZEROWNE WIEKSZEROWNE NOT

%token WHILE DO REPEAT UNTIL FOR TO DOWNTO

%token EXIT BREAK HALT

%token WRITE WRITELN READ READLN

%token IF ELSE THEN

%token FUNCTION TPROCEDURE

%token CYFRY NAPIS NAWIAS_LEWY NAWIAS_PRAWY MNIEJSZE WIEKSZE 


%%
poczatek    : PROGRAM NAZWA SREDNIK bloki koniec  {printf("\nKoniec skanowania\n"); return;}
            ;

bloki       : stale zmienne procedury funkcje procedury  blok_instrukcji 
            | stale zmienne funkcje procedury blok_instrukcji
            | stale zmienne blok_instrukcji procedury funkcje
            | stale zmienne blok_instrukcji funkcje procedury
            | stale zmienne funkcje blok_instrukcji
            ;

stale       : CONST listas
            |
            ;

listas      : listas stala SREDNIK
            | stala SREDNIK
            ;

stala       : st ROWNE wartosc
            ;

st          : st PRZECINEK NAZWA {++consts;}
            | NAZWA {++consts;}
            ;

wartosc     : CYFRY
            | CYFRY KROPKA CYFRY
            | NAPIS
            | NAZWA
            | wartosc '-' wartosc
            | wartosc '+' wartosc
            | wartosc '/' wartosc
            | wartosc '%' wartosc
            ;

zmienne     : VAR listaz
            |
            ;

listaz      : listaz zmienna SREDNIK
            | zmienna SREDNIK
            ;

zmienna     : zm DWUKROPEK typ
            ;

zm          : zm PRZECINEK NAZWA
            | NAZWA {++variables;}
            ;

typ         : zwykly
            | tablica
            ;

zwykly      : INTEGER
            | BOOLEAN
            | REAL
            | CHARACTER
            | STRING
            ;

tablica     : ARRAY TABLICA_LEFT CYFRY DWIEKROPKI CYFRY TABLICA_RIGHT OF zwykly
            | ARRAY TABLICA_LEFT CYFRY DWIEKROPKI NAZWA TABLICA_RIGHT OF zwykly
            | ARRAY TABLICA_LEFT NAZWA DWIEKROPKI NAZWA TABLICA_RIGHT OF zwykly
            ;


procedury   : procedury procedura
            | procedura
            ;

procedura   : TPROCEDURE NAZWA SREDNIK

funkcje     : funkcje funkcja
            | funkcja
            |
            ;

funkcja     : FUNCTION NAZWA NAWIAS_LEWY parametry NAWIAS_PRAWY DWUKROPEK typ SREDNIK stale zmienne blok_instrukcji
            ;

parametry   : parametry SREDNIK zmienna
            | zmienna
            |
            ;

blok_instrukcji : TBEGIN body END
                | body
                ;

body        : body expression
            | expression
            ;

expression : przypisanie
           | warunek
           | zapis
           | odczyt
           | przerwania
           | petle
           ;

przypisanie : NAZWA ASSIGN wartosc SREDNIK {++numAssign;}
            | NAZWA ASSIGN NAWIAS_LEWY wartosc NAWIAS_PRAWY SREDNIK {++numAssign;}
            | NAZWA ASSIGN NAZWA NAWIAS_LEWY NAWIAS_PRAWY SREDNIK {++numAssign;}

warunek     : IF zalozenie THEN blok_instrukcji {++numIf;}
            | IF zalozenie THEN blok_instrukcji ELSE blok_instrukcji SREDNIK {++numIf;}
            | IF zalozenie THEN blok_instrukcji ELSE IF zalozenie THEN blok_instrukcji ELSE blok_instrukcji SREDNIK {++numIf;}

zalozenie   : zalozenie AND zalozenia
            | zalozenie OR zalozenia
            | zalozenia
            ;

zalozenia   : wartosc ROWNE wartosc
            | wartosc MNIEJSZE wartosc
            | wartosc WIEKSZE wartosc
            | wartosc WIEKSZEROWNE wartosc
            | wartosc MNIEJSZEROWNE wartosc
            | NOT wartosc
            ;

zapis       : write1
            | write2
            ;

write1      : WRITE NAWIAS_LEWY wartosci NAWIAS_PRAWY SREDNIK {++numWrite;}
            ;

write2      : WRITELN NAWIAS_LEWY wartosci NAWIAS_PRAWY SREDNIK {++numWrite;}
            ;

wartosci    : wartosci PRZECINEK wartosc
            | wartosc
            ;

odczyt      : read1
            | read2
            ;

read1       : READ NAWIAS_LEWY zm NAWIAS_PRAWY SREDNIK {++numRead;}
            ;

read2       : READLN NAWIAS_LEWY zm NAWIAS_PRAWY SREDNIK {++numRead;}
            ;

przerwania  : EXIT SREDNIK {++numExit;}
            | BREAK SREDNIK {++numBreak;}
            | HALT SREDNIK {numHalt;}
            ;

petle       : petla_for
            | petla_repeat
            | petla_while
            ;

petla_for   : FOR NAZWA ASSIGN wartosc TO CYFRY DO blok_instrukcji {++numFor;}
            | FOR NAZWA ASSIGN wartosc DOWNTO CYFRY DO blok_instrukcji {++numFor;}
            | FOR NAZWA ASSIGN wartosc TO NAZWA DO blok_instrukcji {++numFor;}
            | FOR NAZWA ASSIGN wartosc DOWNTO NAZWA DO blok_instrukcji {++numFor;}
            | FOR NAZWA ASSIGN NAZWA DOWNTO NAZWA DO blok_instrukcji {++numFor;}
            ;

petla_repeat : REPEAT body UNTIL zalozenia SREDNIK {++numRepeat;}
             ;

petla_while  : WHILE zalozenia DO blok_instrukcji {++numWhile;}
             ;

koniec      : KROPKA
            ;

%%

int main() {
    printf("Początek skanowania ...\n");
    yyparse();
    
    printf("\nIlosc przypisań: %d\n", numAssign);
    printf("Ilosc warunkow IF: %d\n", numIf);
    printf("Ilosc pętli WHILE: %d\n", numWhile);
    printf("Ilosc pętli REPEAT: %d\n", numRepeat);
    printf("Ilosc pętli FOR: %d\n", numFor);
    printf("Ilosc przerwań BREAK: %d\n", numBreak);
    printf("Ilosc przerwań EXIT: %d\n", numExit);
    printf("Ilosc przerwań HALT: %d\n", numHalt);
    printf("Ilosc wypisań WRITE | WRITELN: %d\n", numWrite);
    printf("Ilosc wczytań READ | READLN: %d\n", numRead);
    printf("Ilosc zadeklarowanych zmiennych: %d\n", variables);
    printf("Ilosc zadeklarowanych stalych: %d\n\n", consts);
    printf("Ilosc linijek kodu:%d\n\n",yylval);

    return 0;
}

int yyerror(char *s) {
    printf("Błąd: %s\n", s);
    return 0;
}
