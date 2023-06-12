%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "lexer.yy.h"
%}

%token AND
%token ARRAY
%token ASSIGN
%token COLON
%token COMMA
%token DIV
%token DO
%token DOT
%token ELSE
%token END
%token EQUAL
%token FUNCTION
%token GREATER_THAN
%token GREATER_THAN_EQUAL
%token IDENTIFIER
%token IF
%token INTEGER
%token LESS_THAN
%token LESS_THAN_EQUAL
%token LPAREN
%token MINUS
%token MULTIPLY
%token NOT
%token NOT_EQUAL
%token NUMBER
%token OF
%token OR
%token PROCEDURE
%token PROGRAM
%token RPAREN
%token SEMICOLON
%token THEN
%token TYPE
%token VAR
%token WHILE
%token BEGIN
%token LBRACKET
%token RBRACKET

%left OR
%left AND
%left EQUAL NOT_EQUAL
%left LESS_THAN LESS_THAN_EQUAL GREATER_THAN GREATER_THAN_EQUAL
%left PLUS MINUS
%left MULTIPLY DIV

%%

program : PROGRAM IDENTIFIER SEMICOLON declarations subprogram_declarations compound_statement DOT
        ;

declarations : VAR identifier_list COLON type SEMICOLON declarations
             | /* empty */
             ;

identifier_list : IDENTIFIER
                | identifier_list COMMA IDENTIFIER
                ;

type : INTEGER
     | ARRAY LBRACKET NUMBER DOT DOT NUMBER RBRACKET OF type
     ;

subprogram_declarations : subprogram_declarations subprogram_declaration SEMICOLON
                        | /* empty */
                        ;

subprogram_declaration : subprogram_head declarations compound_statement
                       ;

subprogram_head : FUNCTION IDENTIFIER arguments COLON type SEMICOLON
                | PROCEDURE IDENTIFIER arguments SEMICOLON
                ;

arguments : LPAREN parameter_list RPAREN
          | /* empty */
          ;

parameter_list : identifier_list COLON type
               | parameter_list SEMICOLON identifier_list COLON type
               ;

compound_statement : BEGIN optional_statements END
                   ;

optional_statements : statement_list
                    | /* empty */
                    ;

statement_list : statement
               | statement_list SEMICOLON statement
               ;

statement : variable ASSIGN expression
          | procedure_statement
          | compound_statement
          | IF expression THEN statement ELSE statement
          | WHILE expression DO statement
          ;

variable : IDENTIFIER
         | variable LBRACKET expression RBRACKET
         ;

procedure_statement : IDENTIFIER optional_arguments
                    ;

optional_arguments : LPAREN expression_list RPAREN
                   | /* empty */
                   ;

expression_list : expression
                | expression_list COMMA expression
                ;

expression : simple_expression
           | simple_expression relational_operator simple_expression
           ;

simple_expression : term
                  | simple_expression add_operator term
                  ;

term : factor
     | term mul_operator factor
     ;

factor : variable
       | constant
       | LPAREN expression RPAREN
       | NOT factor
       ;

constant : NUMBER
         | MINUS NUMBER
         ;

relational_operator : EQUAL
                    | NOT_EQUAL
                    | LESS_THAN
                    | LESS_THAN_EQUAL
                    | GREATER_THAN
                    | GREATER_THAN_EQUAL
                    ;

add_operator : PLUS
             | MINUS
             | OR
             ;

mul_operator : MULTIPLY
             | DIV
             | AND
             ;

%%

int main() {
    yyparse();
    return 0;
}

void yyerror(const char* message) {
    fprintf(stderr, "Syntax Error: %s\n", message);
    exit(1);
}

