%{
	#include<stdio.h>
	#include<string.h>
	int yyerror();
	int wartosci[100];
	int slow_wart(int klucz) {
		return wartosci[klucz];
	}
	
	int slow_ustaw(int klucz,int wartosc){
		wartosci[klucz]=wartosc;
	}
%}

%token kPISZ kUSTAW kSTOP ID LICZBA

%%

dane: /* nic */
	| dane wiersz
	;
wiersz: '\n'
	| kUSTAW ID '=' wyr '\n' { slow_ustaw($2,$4); }
	| kPISZ wyr '\n' { printf("%d\n",$2); }
	| kSTOP '\n' { printf("Koniec\n"); return 0; }
wyr : wyr '+' skl { $$ = $1 + $3; }
	| wyr '-' skl { $$ = $1 - $3; }
	| skl
	;
skl : skl '*' czyn { $$ = $1 * $3; }
	| skl '/' czyn { $$ = $1 / $3; }
	| czyn 
	;
czyn : LICZBA 
	| ID { $$ =slow_wart($1); }
	| '(' wyr ')' { $$ = $2; }
	;
%%

main()
{
	bzero(&wartosci,sizeof(wartosci));
	yyparse();
}
int yyerror(char *s){
	printf("ERROR: %s\n", s);
}