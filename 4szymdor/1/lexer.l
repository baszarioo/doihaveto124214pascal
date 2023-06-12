%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "parser.tab.h"
%}

%option noyywrap

%%
"and"   { return AND; }
":"     { return COLON; }
","     { return COMMA; }
"."     { return DOT; }
"="     { return EQUAL; }
">"     { return GREATER_THAN; }
">="    { return GREATER_THAN_EQUAL; }
"<"     { return LESS_THAN; }
"<="    { return LESS_THAN_EQUAL; }
"("     { return LPAREN; }
")"     { return RPAREN; }
"not"   { return NOT; }
"<> "   { return NOT_EQUAL; }
"or"    { return OR; }
"procedure" { return PROCEDURE; }

[A-Za-z][A-Za-z0-9]* { yylval.stringVal = strdup(yytext); return IDENTIFIER; }
[0-9]+              { yylval.intVal = atoi(yytext); return NUMBER; }

[ \t\n\r]           { /* ignore whitespace */ }
.                   { return yytext[0]; }
%%

int yywrap() {
    return 1;
}

