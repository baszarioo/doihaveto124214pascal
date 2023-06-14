%{

#include <stdlib.h>
#include <stdio.h>
#include "parser.tab.h"
g
int cnt=0;

int yywrap();

%}

comment             \{[^\}]*\}|\(\*[^(\*\))]*\*\)

whitespace          [ \t]+
digit               [0-9]
alpha               [a-zA-Z_]
alphaNum            ({alpha}|{digit})
hexDigit            [0-9A-F]

identifier          {alpha}{alphaNum}*

dataType            "Integer"|"integer"|"Real"|"real"|"Boolean"|"boolean"|"String"|"string"|"Char"|"char"|"Byte"|"byte"

unsignedInteger     {digit}+
hexInteger          ${hexDigit}{hexDigit}*
exponent            e[\+\-]?{digit}+
i                   {unsignedInteger}
real                ({i}\.{i}?|{i}?\.{i}|{i}){exponent}?

pain                {i}\.\.({real}|{identifier})

string              \'([^\'])*\'

value               [Tt][Rr][Uu][Ee]|[Ff][Aa][Ll][Ss][Ee]|{i}|{hexInteger}|{real}|{string}


%%

{comment}           {}

"program"           { return PROGRAM; }
"uses"              { return USES; }
"const"             { return CONST; }
"var"               { return VAR; }
"function"          { return FUNCTION; }
"procedure"         { return PROCEDURE; }
"begin"             { return BEGGIN; }
"end"               { return END; }
"set"               { return SET; }
"array"             { return ARRAY; }
"of"                { return OF; }
"halt"              { return HALT; }

"for"               { return FOR; }
"while"             { return WHILE; }
"to"                { return TO; }
"do"                { return DO; }
"repeat"            { return REPEAT;}
"until"             { return UNTIL;}

"if"                { return IF; }
"then"              { return THEN; }
"else"              { return ELSE; }

"or else"           { return OR_ELSE; }
"and then"          { return AND_THEN; }
":="                { return ASSIGN; }
"<>"                { return NOT_EQ; }
"<="                { return LESS_EQ; }
">="                { return MORE_EQ; }
"in"                { return IN; }
"or"                { return OR; }
"div"               { return DIV; }
"mod"               { return MOD; }
"and"               { return AND; }
"not"               { return NOT; }


{dataType}          { return DATATYPE;}


{value}             { return VALUE; }


{pain}              { return PAIN;}

{identifier}        { return IDENTIFIER; }

"\r\n"|[\r\n]       { yylval++; }

{whitespace}        {}

.                   { return *yytext; }

%%

int yywrap(){
	return(1);
}
