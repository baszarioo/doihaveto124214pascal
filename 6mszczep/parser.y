%{
#include <stdlib.h>
#include <stdio.h>
#include <string.h>

int global = 1;
int lineCnt = 0;
int libCnt = 0;
int constCnt = 0;
int globalVarCnt = 0;
int localVarCnt = 0;
int functionCnt = 0;
int procedureCnt = 0;
int beginCnt = 0;
int forCnt = 0;
int whileCnt = 0;
int repeatCnt = 0;
int ifCnt = 0;

int yylex();
int yyerror();
%}

%token       PAIN HALT
%token       PROGRAM USES CONST VAR FUNCTION PROCEDURE
%token       IDENTIFIER DATATYPE VALUE 
%token       BEGGIN END
%token       SET ARRAY OF
%token       IF THEN ELSE WHILE FOR TO DO REPEAT UNTIL 

%token       OR_ELSE "or else" AND_THEN "and then"
%token       ASSIGN ":=" NOT_EQ "<>" LESS_EQ "<=" MORE_EQ ">=" IN "in"
%token       OR "or"
%token       DIV "div" MOD "mod" AND "and"
%token       NOT "not"


%left        "or else" "and then"
%left        '=' "<>" '<' "<=" '>' ">=" "in"
%left        '+' '|' '!' "or"
%left        '*' '/' "div" "mod" "and" '&'
%right       '-'
%precedence        '~' "not"

%precedence        '[' '('


%%

/*============= 1st LEVEL =============*/

code:         program uses const var functions procedures main {return 0;}; 

/*============= 2nd LEVEL =============*/

program:      PROGRAM IDENTIFIER ';' ;

uses:         USES identifiers ';' { libCnt = $2; }
|             %empty;

const:        CONST constDecls
|             %empty;

var:          VAR varDecls         {if(global==1){global=0; globalVarCnt = $2;}else{localVarCnt += $2;}}
|             %empty               {if(global==1)global=0;};

functions:    function functions
|             %empty;

function:     FUNCTION funcDecl var statement ';';

procedures:   procedure procedures
|             %empty;  

procedure:    PROCEDURE procDecl var statement ';';

main:         BEGGIN statements END '.' ;


/*============= 3rd LEVEL =============*/

constDecls:   constDecl ';' constDecls 
|             constDecl ';';

constDecl:    identifiers '=' expression                           { constCnt += $1; }
|             identifiers ':' DATATYPE '=' expression              { constCnt += $1;  }
|             identifiers ':' SET OF subscript                     { constCnt += $1;  }
|             identifiers ':' SET OF '(' expressions ')'           { constCnt += $1;  } ; 

varDecls:     varDecl ';' varDecls     { $$ = $1 + $2; }
|             varDecl ';'             { $$ = $1; };

varDecl:      identifiers ':' DATATYPE '=' expression               { $$ = $1; }
|             identifiers ':' DATATYPE                              { $$ = $1; }
|             identifiers ':' SET OF subscript                      { $$ = $1; }
|             identifiers ':' SET OF '(' expressions ')'            { $$ = $1; }
|             identifiers ':' ARRAY '[' subscripts ']' OF DATATYPE  { $$ = $1; }
|             identifiers ':' ARRAY '[' DATATYPE ']' OF DATATYPE    { $$ = $1; } ;


funcDecl:     IDENTIFIER params ':' DATATYPE ';' { functionCnt++; } ;

procDecl:     IDENTIFIER params ';' { procedureCnt++; } ;

/*============= 4th LEVEL =============*/

identifiers:  IDENTIFIER ',' identifiers { $$ = $2+1; }
|             IDENTIFIER { $$ = 1; } ;

subscripts:   subscript ',' subscripts
|             subscript;

subscript:    expression ".." expression
|             PAIN;

params:       '(' params1 ')'
|             %empty;

params1:      param ',' params1 
|             param ;

param:        identifiers ':' DATATYPE;

statements:   statement ';' statements
|             statement;

statement:    BEGGIN statements END                     { beginCnt++; } 
|             FOR statement TO expression DO statement  { forCnt++; } 
|             WHILE expression DO statement             { whileCnt++; } 
|             REPEAT statements UNTIL expression        { repeatCnt++; } 
|             IF expression THEN statement else         { ifCnt++; } 
|             expression ":=" expression
|             expression
|             HALT
|             %empty;

else:         ELSE statement
|             %empty;

expressions:  expression ',' expressions
|             expression;

expression:   VALUE
|             IDENTIFIER
|             '(' expression ')'
|             expression '[' expressions ']'
|             expression '(' ')'
|             expression '(' expressions ')'
|             expression '*' expression
|             expression '/' expression
|             expression "div" expression
|             expression "mod" expression
|             expression "and" expression
|             expression '&' expression
|             expression '|' expression
|             expression '!' expression
|             expression '+' expression 
|             expression '-' expression    %prec '+'
|             expression "or" expression
|             expression '=' expression
|             expression "<>" expression
|             expression '<' expression
|             expression "<=" expression
|             expression '>' expression
|             expression ">=" expression
|             expression "in" expression
|             expression "or else" expression
|             expression "and then" expression
|             '~' expression
|             "not" expression
|             '+' expression    %prec '-'
|             '-' expression;




%%


int main(){
    yylval=1;
	printf("Poczatek skanowania:\n");
	
	yyparse();
	
	printf("\nKoniec skanowania.\n");
	printf("Przeczytano %d poprawnych linii kodu.\n", lineCnt=yylval);
	printf("Odczytano:\n");
	printf(" %d bibliotek,\n", libCnt);
	printf(" %d stalych globalnych,\n", constCnt);
	printf(" %d zmiennych globalnych,\n", globalVarCnt);
	printf(" %d zmiennych lokalnych,\n", localVarCnt);
	printf(" %d funkcji,\n", functionCnt);
	printf(" %d procedur,\n", procedureCnt);
	printf(" \n");
	printf(" %d instrukcji begin\n", beginCnt);
	printf(" %d instrukcji for\n", forCnt);
	printf(" %d instrukcji while\n", whileCnt);
	printf(" %d instrukcji repeat\n", repeatCnt);
	printf(" %d instrukcji if\n", ifCnt);
	
}

int yyerror(){
	printf("ERROR: linia %d\n", lineCnt=yylval);
	
	exit(-1);
}
