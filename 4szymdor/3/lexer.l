%{
#include "parser.tab.h"
%}

%%
[ \t\n]                    ; /* ignore whitespace */

if                         { return IF; }
then                       { return THEN; }
else                       { return ELSE; }
while                      { return WHILE; }
do                         { return DO; }
repeat                     { return REPEAT; }
until                      { return UNTIL; }

[a-zA-Z_][a-zA-Z0-9_]*     { yylval.identifier = strdup(yytext); return IDENTIFIER; }
[0-9]+                     { yylval.integer = atoi(yytext); return INTEGER; }

.                          { return yytext[0]; }
%%

int yywrap() {
    return 1;
}

