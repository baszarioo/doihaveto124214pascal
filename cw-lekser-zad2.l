%{
#include <stdio.h>
int ignore=0;
%}
numver 			[1-9][0-9]*
id				[A-Za-z][A-Za-z0-9]*
input			"INPUT"
output			"OUTPUT"
add				"ADD"
subt			"SUBT"
load			"LOAD"
store			"STORE"
clear			"CLEAR"
halt			"HALT"
var				"VAR"
%%
{input}		{ if(!ignore) printf("czytanie z rejestru wejściowego\n");	}
{output}	{ if(!ignore) printf("pisanie do rejestru wyjściowego\n");	}
{add}		{ if(!ignore) printf("dodawanie do akumulatora\n");	}
{subt}		{ if(!ignore) printf("odejmowanie od akumulatora\n"); }
{load}		{ if(!ignore) printf("wczytanie z pamieci\n"); }
{store}		{ if(!ignore) printf("zapisanie do pamieci\n"); }
{clear}		{ if(!ignore) printf("zerowanie akumulatora\n"); }
{halt}		{ if(!ignore) printf("zatrzymanie programu\n");	}
{var}		{ if(!ignore) printf("deklaracja zmiennej\n");	}
{id}		{ if(!ignore) printf("zmienna: %s\n",yytext); }
{number}	{ if(!ignore) printf("adres: %s\n",yytext); }
{comment}	{ if(!ignore) printf("komentarz\n"); ignore = 1; }
\n 			{ if(!ignore) ignore =0; }
.			{ /* pomijaj wszystkie niedopasowane znaki */ }
%%
int main() {
	printf("Poczatek skanowania...\n");
	yylex();
	printf("\nKoniec skanowania\n");
	
	return 0;
}