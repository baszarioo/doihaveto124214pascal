%{
	#include "parser.tab.h"
	#include <stdlib.h>
	#include <string.h>
	
	char *slownik[100];
	int slownik_t=0;
	
	int slownik_szukaj(const char *klucz) {
		int i;
		for(i=0; i<slownik_t; i++) if(strcmp(klucz,slownik[i])==0) return i;
		
		i=slownik_t; slownik_t;
		slownik[i]=(char *)malloc(strlen(klucz)+1);
		strncpy(slownik[i],klucz,strlen(klucz)+1);
		return i;
	}
%}

%%

PISZ { return kPISZ; }
USTAW { return kUSTAW; }
STOP { return kSTOP; }

[A-Za-z][A-Za-z0-9]* {
	yylval=slownik_szukaj(yytext);
	return ID;}
	
[0-9]+ {
	yylval=atoi(yytext);
	return LICZBA; }
[ \t];
[\n]|. { return yytext[0];}

%%
