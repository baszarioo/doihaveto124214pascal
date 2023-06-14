%{

#include "Parser.tab.h"

#include <stdlib.h>
#include <stdio.h>
#include <string.h>

int count_lines = 1;
int count_if = 0;
int count_for = 0;
int count_while = 0;
int count_repeat = 0;


%}

comparison =|!=|<|<=|>|>=

%%

program			{ return PROGRAM; }
const			{ return CONST; }
var			{ return VAR; }
begin			{ return BBEGIN; }
end			{ return END; }
if			{ count_if++; return IF; }
then			{ return THEN; }
else			{ return ELSE; }
while			{ count_while++; return WHILE; }
do			{ return DO; }
repeat			{ count_repeat++; return REPEAT; }
until			{ return UNTIL; }
:=			{ return ASSIGN; }
=			{ return EQUAL; }
:			{ return COLON; }
"\."			{ return DOT; }
,			{ return COMMA; }
;			{ return SEMICOLON; }
{comparison}		{ return COMP; }
[a-zA-Z][a-zA-Z0-9]*	{ yylval.str = yytext; return NAME; }
\'[a-zA-Z0-9 ]+\'	{ yylval.str = yytext; return STRING; }
[0-9]+      		{ yylval.num = atoi(yytext); return INTEGER; }
\n			{ count_lines++; }
[ \t]			{ }
.			{ }

%%

yywrap() {}