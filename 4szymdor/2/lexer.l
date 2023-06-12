%option noyywrap

%{
#include "assembler.tab.h"
#include <stdio.h>
#include <stdlib.h>
%}

int ignore = 0;
char *variables[1024];
int pos = 0;

int getAddress(const char *varName) {
    int i;

    for (i = 0; i < pos; ++i) {
        if (!strcmp(varName, variables[i])) return i;
    }

    i = pos;
    ++pos;
    variables[i] = (char *)malloc(strlen(varName) + 1);
    strncpy(variables[i], varName, strlen(varName) + 1);

    return i;
}

number [1-9][0-9]*
id [A-Za-z][A-Za-z0-9]*
comment "//"
input "INPUT"
output "OUTPUT"
add "ADD"
subt "SUBT"
load "LOAD"
store "STORE"
clear "CLEAR"
halt "HALT"
var "VAR"

%%

{input} { if (!ignore) return INPUT; }
{output} { if (!ignore) return OUTPUT; }
{add} { if (!ignore) return ADD; }
{subt} { if (!ignore) return SUBT; }
{load} { if (!ignore) return LOAD; }
{store} { if (!ignore) return STORE; }
{clear} { if (!ignore) return CLEAR; }
{halt} { if (!ignore) return HALT; }
{var} { if (!ignore) return VAR; }
{id} { if (!ignore) { yylval = getAddress(yytext); return ID; } }
{number} { if (!ignore) { yylval = atoi(yytext); return NUMBER; } }
{comment} { if (!ignore) ignore = 1; }
\n { if (ignore) ignore = 0; return yytext[0]; }
. { }

%%

int main() {
    yylex();
    return 0;
}

