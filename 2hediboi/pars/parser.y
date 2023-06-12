%{
	#include <stdio.h>
	#include <stdlib.h>
	#include <string.h>
	#define YYSTYPE int*
	int yyerror();
	int* dodaj(int* a, int* b);
	int* odejmij(int* a, int* b);
	int* mnoz(int* a, int* b);
	int* dziel(int* a, int* b);
	void skroc(int* a);
	int i = 0;
%}

%token WYMIERNA DODAJ ODEJMIJ MNOZ DZIEL OTW ZAM BLAD

%%
calosc		: 
			| calosc wiersz
			;

wiersz 		: '\n' 
			| wyrazenie '\n' { skroc($1);
							   printf("%d | %d\n", $1[0], $1[1]); ++i; }
			| BLAD { return 1; }
	
wyrazenie 	: wyrazenie DODAJ skladnik { $$ = dodaj($1, $3); }
			| wyrazenie ODEJMIJ skladnik { $$ = odejmij($1, $3); }
			| skladnik { $$ = $1; }
			;
	
skladnik 	: skladnik MNOZ czynnik { $$ = mnoz($1, $3); }
			| skladnik DZIEL czynnik { $$ = dziel($1, $3); }
			| czynnik
			;
	
czynnik 	: liczba { $$ = $1; }
			| OTW wyrazenie ZAM { $$ = $2; }
	
liczba 		: WYMIERNA { $$ = $1; }
			| ODEJMIJ WYMIERNA { $$[0] = -$1[0]; $$[1] = $1[1]; }
			;
%%

int NWW(int a, int b)
{
	return a / NWW(a,b) * b;
}

int NWD(int a, int b)
{
	int pom;
  	while(b!=0)
	{
    	pom = b;
    	b = a % b;
    	a = pom;  
  	}
    return a;
}

int* dodaj(int* a, int* b)
{
	int* c = (int*) malloc(2*sizeof(int));
	c[1] = NWW(a[1], b[1]);
	c[0] = a[0] * (c[1] / a[1]) + b[0] * (c[1] / b[1]);
	return c;
}

int* odejmij(int* a, int* b)
{
	int* c = (int*) malloc(2*sizeof(int));
	c[1] = NWW(a[1], b[1]);
	c[0] = a[0] * (c[1] / a[1]) - b[0] * (c[1] / b[1]);
	return c;
}

int* mnoz(int* a, int* b)
{
	int* c = (int*) malloc(2*sizeof(int));
	c[0] = a[0] * b[0];
	c[1] = a[1] * b[1];
	return c;
}

int* dziel(int* a, int* b)
{
	int* c = (int*) malloc(2*sizeof(int));
	c[0] = a[0] * b[1];
	c[1] = a[1] * b[0];
	return c;
}

void skroc(int* a)
{
	int b = NWD(a[0], a[1]);
	a[0] /= b;
	a[1] /= b;
}

main()
{
	yyparse();
	printf("Niepoprawne wyrazenie, liczba poprawnie obliczonych wyrazen: %d\n", i);
	return 0;
}

int yyerror(){}
