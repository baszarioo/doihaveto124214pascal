%{

#include <stdio.h>

FILE *yyin;
int yyerror();

extern int yylex();
extern int count_lines;
extern int count_if;
extern int count_for;
extern int count_while;
extern int count_repeat;
int count_variables = 0;
int count_constants = 0;

%}

%union symval {
	int num;
	char* str;
};

%token PROGRAM CONST VAR BBEGIN END IF THEN ELSE WHILE DO REPEAT UNTIL ASSIGN EQUAL 
	DOT COMMA COLON SEMICOLON COMP

%token<str> NAME STRING
%token<num> INTEGER
%type<str> const_block const_dec const_all var_block var_dec var_all stmt_block stmts stmt
%type<num> exp
%%

prog:
	PROGRAM NAME SEMICOLON const_block var_block stmt_block DOT
		{ printf("Poprawna skladnia programu.\n"); }
;

const_block:
	| CONST const_all
		{ printf("Poprawna skladnia deklaracji sta³ych.\n"); }
;

const_all:
	const_dec const_all
	| const_dec
;

const_dec:
	NAME EQUAL INTEGER SEMICOLON
		{ count_constants++; }
	| NAME EQUAL STRING SEMICOLON
		{ count_constants++; }
;

var_block:
	| VAR var_all
		{ printf("Poprawna skladnia deklaracji zmiennych.\n"); }
;

var_all: 
	var_dec var_all
	| var_dec
;

var_dec:
	NAME COLON NAME SEMICOLON
		{ count_variables++; }
	| NAME COMMA var_dec
		{ count_variables++; }
;

stmt_block: 
	BBEGIN stmts END
		{ printf("Poprawna skladnia bloku instrukcji.\n"); }
;

stmts:
	stmt SEMICOLON
	| stmts stmt SEMICOLON
;

stmt:
	NAME ASSIGN exp
		{ printf("%s := %d\n", $1, $3); }
;

exp:
	INTEGER
;

%%

int main(int argc, char *argv[])
{
	yyparse();

	printf("\nLiczba linii: %d\n", count_lines);
	printf("Liczba stalych: %d\n", count_constants);
	printf("Liczba zmiennych: %d\n", count_variables);
	printf("Liczba warunkow if: %d\n", count_if);
	printf("Liczba petli for: %d\n", count_for);
	printf("Liczba petli while: %d\n", count_while);
	printf("Liczba petli repeat: %d\n", count_repeat);	

	return 0;
}

int yyerror(const char *p) {
	
	printf("Error on line %s\n", p);
	return 0;
}

