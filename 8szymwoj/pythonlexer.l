%{
//DANE WEJŚCIOWE UMIEŚCIĆ W PLIKU przyklad.pas W FOLDERZE PROGRAMU
#include <stdio.h>

//modes
int ignore = 0;

int comments = 0;

%}

opComment "{"
opArray "["

clComment "}"
clArray "]"

Digit [0-9]
Digits {Digit}+
Float {Digits}(\.{Digits}([Ee][+-]?{Digits})?)

%%
{opComment} { if(!ignore) {printf("Komentarz\n"); comments++;} ignore = 1;}
{opArray} { if(!ignore) {ignore = 1;}}

{clComment} { if(ignore) ignore = 0; }
{clArray} { if(ignore) ignore = 0;}

"program" { if(!ignore) printf("Rozpoczęcie wykonywania programu\n"); }
"var" { if(!ignore) printf("Deklaracje zmiennych\n"); }
"integer" { if(!ignore) printf("integer deklaracja\n"); }
"real" { if(!ignore) printf("real deklaracja\n"); }
"array" { if(!ignore) printf("Tablicy "); }
"of" { if(!ignore) printf("zmiennych typu "); }
"function" { if(!ignore) printf("Deklaracja funkcji\n"); }
"procedure" { if(!ignore) printf("Deklaracja procedury\n"); }
"begin" { if(!ignore) printf("Wystapienie begin\n"); }
"end" { if(!ignore) printf("Wystapienie End\n"); }
"do" { if(!ignore) printf("Wystapienie do\n"); }
"not" { if(!ignore) printf("Wystapienie not\n"); }
"while" { if(!ignore) printf("Wystapienie while\n"); }
"if" { if(!ignore) printf("Wystapienie if\n"); }
"else" { if(!ignore) printf("Warunek else\n"); }
"then" { if(!ignore) printf("Wystapienie then\n"); }
"+"|"-" { if(!ignore) printf("Dodawanie lub odejmowanie\n"); }
"mod" { if(!ignore) printf("Dzielenie z reszta\n"); }
":=" { if(!ignore) printf("Przypisanie\n"); }
"<="|">="|"<>"|"="|"<"|">" { if(!ignore) printf("Porównanie\n"); }
{Digits}|{Float} { if(!ignore) printf("Liczba\n"); }
[a-zA-Z][_a-zA-Z0-9]* { if(!ignore) printf("Identyfikator\n"); }
. {}

%%

int main() {
    //DANE WEJŚCIOWE UMIEŚCIĆ W PLIKU przyklad.pas W FOLDERZE PROGRAMU
    yyin = fopen("przyklad.pas", "r");
    while(yylex());
    printf("\nZliczono %d komentarzy\n", comments);

    return 0;
}