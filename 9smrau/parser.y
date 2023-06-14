%{
#include <stdio.h>
#include <stdlib.h>
#include "parser.tab.h"

extern int if_count;
extern int while_count;
extern int repeat_count;
extern int line_count;
extern int var_count;

void yyerror(char *message);
%}

%token <int> DIGIT
%token <string> IDENTIFIER
%token <string> TYPE
%token IF TOK_WHILE TOK_REPEAT TOK_DIGIT TOK_IDENTIFIER AND _BEGIN ELSE END FUNCTION GOTO NOT PROGRAM REPEAT SET DO THEN VAR WHILE LEQ GEQ NEQ EQ


%left '+' '-'
%left '*' '/'
%nonassoc UMINUS

%%

program : program_heading ';' block '.' 
        {
            // Actions to perform after parsing the program
        }
        ;

program_heading : PROGRAM IDENTIFIER
        {
            printf("Rozpoczynam analizê programu o nazwie: %s\n", $2);
        }
        ;

block : var_declaration_part compound_statement
{
    var_count += 1;
}

var_declaration_part : VAR var_declaration_list ';'
                      |
                      ;

var_declaration_list : var_declaration
                      | var_declaration_list ';' var_declaration
                      ;

var_declaration : IDENTIFIER_LIST ':' TYPE
                 {
                     // Actions to perform for variable declaration
                 }
                 ;
IDENTIFIER_LIST : IDENTIFIER
                | IDENTIFIER_LIST ',' IDENTIFIER
                ;

compound_statement : _BEGIN statement_list END
                   {
                       // Actions to perform for compound statement
                   }
                   ;

statement_list : statement
               | statement_list ';' statement
               ;

statement : assignment_statement
          | compound_statement
          | /* other statement types */
          ;

assignment_statement : IDENTIFIER ":=" expression
                      {
                          // Actions to perform for assignment statement
                      }
                      ;

expression : simple_expression
           | simple_expression '<' simple_expression
           | simple_expression '>' simple_expression
           | simple_expression LEQ simple_expression
           | simple_expression GEQ simple_expression
           | simple_expression EQ simple_expression
           | simple_expression NEQ simple_expression
           ;

simple_expression : term
                  | simple_expression '+' term
                  | simple_expression '-' term
                  ;

term : factor
     | term '*' factor
     | term '/' factor
     ;

factor : DIGIT
       | IDENTIFIER
       | '(' expression ')'
       | '-' factor %prec UMINUS
       ;

%%

int main() {
    yyparse();
    return 0;
}
