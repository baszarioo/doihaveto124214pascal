%option caseless

%{
#include <stdio.h>
#include <string.h>
#include "parser.tab.h" 

int code_lines = 1;


%}

string_text '[^']*'

%%
"program"       { return PROGRAM; }
"nazwa"         { return NAZWA; }
"uses"          { return USES;}
"var"           { return VAR;}
"const"         { return CONST;}
"integer"       { return INTEGER;}
"real"          { return REAL;}
"boolean"       { return BOOLEAN;}
"character"     { return CHARACTER;}
"string"        { return STRING;}
"array"         { return ARRAY;}
"of"            { return OF;}
"function"      { return FUNCTION;}
":"             { return COLON;}
";"             { return SEMICOLON;}
","             { return COMMA;}
"["             { return SQR_BR_LEFT;}
"]"             { return SQR_BR_RIGHT;}
"="             { return EQUAL;}
"."             { return DOT;}
".."            { return TWODOTS;}
"'"             { return APOSTROF;}
"and"           { return AND;}
"or"            { return OR;}
"<="            { return LEQ;}
">="            { return GEQ;}
"begin"         { return TBEGIN;}
"end"           { return END;}
":="            { return ASSIGN;}
"if"            { return IF;}
"then"          { return THEN;}
"else"          { return ELSE;}
"not"           { return NOT;}
"write"         { return WRITE;}
"writeln"       { return WRITELN;}
"read"          { return READ;}
"readln"        { return READLN;}
"exit"          { return EXIT;}
"break"         { return BREAK;}
"halt"          { return BREAK;}
"while"         { return WHILE;}
"do"            { return DO;}
"repeat"        { return REPEAT;}
"until"         { return UNTIL;}
"for"           { return FOR;}
"to"            { return TO;}
"downto"        { return DOWNTO;}
[0-9]+          { return CYFRY;}
[a-zA-Z_0-9]*   { return NAZWA;}
{string_text}   { return NAPIS;}
[ \t\r]       ;  
\n              { ++code_lines; yylval = code_lines;}
.               {return  *yytext; }
%%
