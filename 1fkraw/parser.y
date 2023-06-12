%{

#include <stdio.h>
#include <string.h>

int yyerror();
int numExpressions = 0;
%}

%token LICZBA CALKOWITA PLUS MINUS MNOZ DZIEL OTW ZAM

%%

calosc :
	| calosc wiersz
	;

wiersz : '\n'
	| wyrazenie '\n' { printf("wartosc = %d\n",$1); ++numExpressions; }

wyrazenie : wyrazenie PLUS skladnik { $$ = $1 + $3; }
	| wyrazenie MINUS skladnik { $$ = $1 - $3; }
	| skladnik { $$ = $1; }
	;

skladnik : skladnik MNOZ czynnik { $$ = $1 * $3; }
	| skladnik DZIEL czynnik { $$ = $1 / $3; }
	| czynnik
	;

	czynnik : liczba { $$ = $1; }
	| OTW wyrazenie ZAM { $$ = $2; }

liczba : CALKOWITA { $$ = $1; }
	| MINUS CALKOWITA {$$ = -$2; }
	;

%%

main() {
printf("Poczatek skanowania ...\n");
yyparse();
printf("\nKoniec skanowania\n");
printf("\tprzeczytano %d poprawnych wyrazen\n\n",numExpressions);

return 0;
}

int yyerror(char *s) {
	printf("Blad: %s\n", s);
}
