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
"begin"         {return tBEGIN;}
"end"           {return END;}

":"             {return COLON;}
";"             {return SEMICOLON;}
","             {return COMMA;}
"["             {return SQUARE_BRACKET_LEFT;}
"]"             {return SQUARE_BRACKET_RIGHT;}
"="             {return EQUAL;}
"."             {return DOT;}
".."            {return TWODOTS;}
"'"             {return APOSTROPHE;}
"("             {return BRACKET_LEFT;}
")"             {return BRACKET_RIGHT;}

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