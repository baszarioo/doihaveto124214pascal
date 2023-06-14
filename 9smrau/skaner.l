%option noyywrap

%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "parser.tab.h"

// Counter variables
int if_count = 0;
int while_count = 0;
int repeat_count = 0;
int line_count = 0;
int var_count = 0;

void yyerror(char *message);
%}

WHITE_SPACE [ \t\n]+
COMMENTS "{"[^}\n]*"}"
BADCOMMENT "{"[\n]*[^}]|[^\{]*"}"
DIGIT [0-9]
IDENTIFIER [a-zA-Z_][a-zA-Z0-9]*
TYPE ({REAL}|{INTEGER}|{CHAR}|{BOOLEAN}|{STRING})


%%
(?i:if)       { if_count++; }
(?i:while)    { while_count++; }
(?i:repeat)   { repeat_count++; }
\n            { line_count++; } 

{COMMENTS}		/* do nothing */
{WHITE_SPACE}	/* do nothing */
.             { /* Ignore other characters */ }

{BADCOMMENT} {return BADCOMMENT;}
{DIGIT} return(DIGIT);
{IDENTIFIER} return(IDENTIFIER);

and         { return AND; }
begin       { return _BEGIN; }
else        { return ELSE; }
end         { return END; }
function    { return FUNCTION; }
goto        { return GOTO; }
if          { return IF; }
not         { return NOT; }
program     { return PROGRAM; }
repeat      { return REPEAT; }
set         { return SET; }
do          { return DO; }
then        { return THEN; }
var         { return VAR; }
while       { return WHILE; }

"<="|"=<"   { return LEQ; }
"=>"|">="   { return GEQ; }
"<>"        { return NEQ; }
"="         { return EQ; }
%%

yywrap() {
  return 1;
}