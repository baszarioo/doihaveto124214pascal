%{
    extern "C" int yylex();

    #include <stdio.h>
    #include "token.h"
    #include "parser.tab.h"

    #define ACCEPT(tokentype) do { yylval.token = new Token(tokentype, yytext, yylineno); return tokentype;} while(0)

    #define TokenType yytokentype
%}

%option yylineno

digit [0-9]
integer     {digit}+([eE][-+]?[0-9]+)?
real        {digit}+(\.{digit}+)?+([eE][-+]?[0-9]+)?

whitespace  [ \t]
newline     "\n"
string      "'"[^']*"'"

identifier  [a-zA-Z_][a-zA-Z0-9_]*
wrong_identifier [0-9][a-zA-Z0-9_]*

%%

 /*Komentarze*/
"{"[^}]*"}" { printf("Wystapil komentarz: %s\n", yytext); }

 /*Slowa kluczkowe*/
"program"     	{ ACCEPT(TokenType::PROGRAM); }
"function"    	{ ACCEPT(TokenType::FUNCTION); }
"procedure"   	{ ACCEPT(TokenType::PROCEDURE); }
"end"         	{ ACCEPT(TokenType::END_); }
"begin"       	{ ACCEPT(TokenType::BEGIN_); }

"while"       	{ ACCEPT(TokenType::WHILE); }
"do"          	{ ACCEPT(TokenType::DO); }
"if"          { ACCEPT(TokenType::IF); }
"then"        { ACCEPT(TokenType::THEN); }
"else"        { ACCEPT(TokenType::ELSE); }

"var"         { ACCEPT(TokenType::VAR); }
"of"          { ACCEPT(TokenType::OF); }

 /*Znaki*/
","         { ACCEPT(TokenType::COMMA); }
":"         { ACCEPT(TokenType::COLON); }
";"        { ACCEPT(TokenType::SEMICOLON); }
"."         { ACCEPT(TokenType::DOT); }
".."        { ACCEPT(TokenType::RANGE_DOTS); }
"("         { ACCEPT(TokenType::BRACKETS_OPEN); }
")"         { ACCEPT(TokenType::BRACKETS_CLOSING); }
"["         { ACCEPT(TokenType::SQUARE_OPEN); }
"]"         { ACCEPT(TokenType::SQUARE_CLOSING); }

 /*Typy danych*/
"integer"     { ACCEPT(TokenType::INTEGER); }
"real"        { ACCEPT(TokenType::REAL); }
"boolean"     { ACCEPT(TokenType::BOOLEAN); }
"array"       { ACCEPT(TokenType::ARRAY); }

 /*Operatory*/
":="        { ACCEPT(TokenType::OP_ASSIGNMENT); }
"not"       { ACCEPT(TokenType::OP_NOT); }

"="         { ACCEPT(TokenType::OP_EQUALS); }
"<>"        { ACCEPT(TokenType::OP_NOT_EQUALS); }
"<"         { ACCEPT(TokenType::OP_LESS); }
"<="        { ACCEPT(TokenType::OP_LESS_EQUAL); }
">"         { ACCEPT(TokenType::OP_GREATER); }
">="        { ACCEPT(TokenType::OP_GREATER_EQUAL); }

"+"         { ACCEPT(TokenType::OP_ADD); }
"-"         { ACCEPT(TokenType::OP_SUB); }
"*"         { ACCEPT(TokenType::OP_MUL); }
"/"         { ACCEPT(TokenType::OP_DIV); }
"div"       { ACCEPT(TokenType::OP_INTEGER_DIV); }

"and"       { ACCEPT(TokenType::OP_AND); }
"or"        { ACCEPT(TokenType::OP_OR); }

 /*Literały*/
"true"              { ACCEPT(TokenType::LITERAL_TRUE); }
"false"             { ACCEPT(TokenType::LITERAL_FALSE); }
{integer}           { ACCEPT(TokenType::LITERAL_INTEGER); }
{real}              { ACCEPT(TokenType::LITERAL_REAL); }
{string}            { ACCEPT(TokenType::LITERAL_STRING); }
{identifier}        { ACCEPT(TokenType::IDENTIFIER); }

 /*Do "zjedzenia"*/
{newline}           { }
{whitespace}        { }

 /*Błędy*/
{wrong_identifier}  { printf("Wystapił nieprawidłowy identyfikator zaczynajacy sie od cyfry:%s\n", yytext); }
.                   { printf("Nie można rozpoznać symbolu::%s\n", yytext); }

%%

/* int main() {
    yyin = fopen("przyklad.pas", "r");
    while(yylex());
    return 0;
} */

int yywrap (void) { return 1; }
