%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int yylex();
int yyerror();
int numExpressions = 0;
%}

%token <U>ULAMEK 
%token PLUS MINUS MNOZ DZIEL OTW ZAM

%union
{
	struct {
		int l;
		int m;
	} U;

}

%type <U> wyrazenie
%type <U> skladnik
%type <U> liczba
%type <U> czynnik

%% 
calosc : 
	| calosc wiersz
	;
	
wiersz : '\n' 
	| wyrazenie '\n' { printf("wartosc = %d|%d\n",$1.l, $1.m); ++numExpressions; }

wyrazenie : wyrazenie PLUS skladnik 
	{$$.l = ($1.l * $3.m) + ($3.l * $1.m);
	$$.m = $1.m*$3.m;
	}

	| wyrazenie MINUS skladnik 
	{$$.l = ($1.l * $3.m) - ($3.l * $1.m);
	$$.m = $1.m*$3.m;
	}
	
	| skladnik
	{$$.l = $1.l;
	$$.m = $1.m;
	}
	;

skladnik : skladnik MNOZ czynnik
	{$$.l = $1.l*$3.l;
	 $$.m = $1.m*$3.m;}

	| skladnik DZIEL czynnik
	{$$.l = $1.m*$3.m;
	 $$.m = $1.m*$3.m;}

	| czynnik
	{$$.l = $1.l;
	$$.m = $1.m;
	}

	;
czynnik: liczba
       {
	$$.l = $1.l;
	$$.m = $1.m;
       }

	| OTW wyrazenie ZAM
	{
	$$.l = $2.l;
	$$.m = $2.m;
	}

liczba : ULAMEK  
	{$$.l = $1.l;
	$$.m = $1.m;
	}

	| MINUS ULAMEK 
	{$$.l = -$2.l;
	$$.m = $2.m;
	}
	;

%% 


int main() {
printf("Poczatek skanowania ...\n");
yyparse();
printf("\nKoniec skanowania\n");
printf("\tprzeczytano %d poprawnych wyrazen\n\n",numExpressions);
return 0;
}


int yyerror(char *s) {
printf("Blad: %s\n", s);
}
