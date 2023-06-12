%option caseless

%{
    #include <stdio.h>
    #include <string.h>
    #include "y.tab.h"
    int linieProgramu = 1;
%}

string_text '[^']*'

%%

"program"       {return PROGRAM;}
"nazwa"         {return NAZWA;}
"begin"         {return TBEGIN;}
"end"           {return END;}

":"             {return DWUKROPEK;}
";"             {return SREDNIK;}
","             {return PRZECINEK;}
"["             {return TABLICA_LEFT;}
"]"             {return TABLICA_RIGHT;}
"="             {return ROWNE;}
"."             {return KROPKA;}
".."            {return DWIEKROPKI;}
"'"             {return APOSTROF;}
"("             {return NAWIAS_LEWY;}
")"             {return NAWIAS_PRAWY;}

"const"         {return CONST;}
"var"           {return VAR;}
"integer"       {return INTEGER;}
"real"          {return REAL;}
"boolean"       {return BOOLEAN;}
"character"     {return CHARACTER;}
"string"        {return STRING;}
":="            {return ASSIGN;}

"array"         {return ARRAY;}
"of"            {return OF;}

"and"           {return AND;}
"or"            {return OR;}
"<="            {return MNIEJSZEROWNE;}
">="            {return WIEKSZEROWNE;}
">"             {return WIEKSZE;}
"<"             {return MNIEJSZE;}
"not"           {return NOT;}

"while"         {return WHILE;}
"do"            {return DO;}
"repeat"        {return REPEAT;}
"until"         {return UNTIL;}
"for"           {return FOR;}
"to"            {return TO;}
"downto"        {return DOWNTO;}

"exit"          {return EXIT;}
"break"         {return BREAK;}
"halt"          {return HALT;}

"write"         {return WRITE;}
"writeln"       {return WRITELN;}
"read"          {return READ;}
"readln"        {return READLN;}

"if"            {return IF;}
"else"          {return ELSE;}
"then"          {return THEN;}

"function"      {return FUNCTION;}

"procedure"     {return TPROCEDURE;}

[0-9]+          {return CYFRY;}
[a-zA-Z_0-9]*   {return NAZWA;}
{string_text}   {return NAPIS;}
[ \t\r]         ;  // Pomijaj białe znaki i znaki nowej linii
\n              {++linieProgramu; yylval = linieProgramu;}
.               {return *yytext;}
%%
