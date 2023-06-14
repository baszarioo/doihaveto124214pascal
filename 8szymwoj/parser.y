%{
    #include <iostream>
    #include <string>

    #include "token.h"

    void yyerror(const char* msg);

    extern "C" int yylex();
    extern int yylineno;
    extern char* yytext;
    extern FILE *yyin;

    bool error = false;
    int wiersze = 0, zmienne = 0, ifs = 0, whiles = 0;
    int getLineNum (Token* endDot);
    void printOccurances ();
%}

%define parse.error verbose
%locations

%union {
    int num;
    Token* token;
}

%start store


%token PROGRAM FUNCTION PROCEDURE BEGIN_ END_
%token IF THEN ELSE DO WHILE
%token VAR OF

%token COMMA COLON SEMICOLON RANGE_DOTS
%token BRACKETS_OPEN BRACKETS_CLOSING SQUARE_OPEN SQUARE_CLOSING

%token INTEGER REAL BOOLEAN ARRAY

%token OP_ASSIGNMENT
%token OP_NOT
%token OP_EQUALS OP_NOT_EQUALS OP_LESS OP_LESS_EQUAL OP_GREATER OP_GREATER_EQUAL
%token OP_ADD OP_SUB OP_MUL OP_DIV OP_INTEGER_DIV
%token OP_AND OP_OR
%token <token> DOT

%token LITERAL_INTEGER LITERAL_REAL LITERAL_STRING LITERAL_TRUE LITERAL_FALSE

%token IDENTIFIER

%%


store       : start { }

start       : PROGRAM IDENTIFIER SEMICOLON varDec             
              subProgList                                     
              compStmt DOT                                    { wiersze = getLineNum($7); }
            ;

varDec      : VAR varDecList                                  { }
            | /* epsilon */                                   { }
            ;

varDecList  : varDecList identListType SEMICOLON              { }
            | identListType SEMICOLON                         { }
            ;

identListType : identList COLON type                          { }
              ;

identList   : identList COMMA IDENTIFIER                      { zmienne++; }
            | IDENTIFIER                                      { zmienne++; }
            ;

type        : simpleType                                      { }
            | ARRAY SQUARE_OPEN 
              LITERAL_INTEGER RANGE_DOTS LITERAL_INTEGER
              SQUARE_CLOSING OF simpleType                    { }
            ;

simpleType  : INTEGER
            | REAL
            | BOOLEAN
            ;

subProgList : subProgList subProgHead varDec                    { }
              compStmt SEMICOLON                                { }
            | /* epsilon */                                     { }
            ;

subProgHead : FUNCTION IDENTIFIER args COLON type SEMICOLON     { }
            | PROCEDURE IDENTIFIER args SEMICOLON               { }
            ;

args        : BRACKETS_OPEN parList BRACKETS_CLOSING            { }
            | /* epsilon */                                     { }
            ;

parList     : parList SEMICOLON identListType                   { }
            | identListType                                     { }
            ;

statement   : procCall                                          { }
            | assignStmt                                        { }
            | compStmt                                          { }
            | ifStmt                                            { }
            | whileStmt                                         { }
            ;

procCall    : IDENTIFIER                                        { }
            | IDENTIFIER params                                 { }
            ;
params      : BRACKETS_OPEN exprList BRACKETS_CLOSING           { }
            ;


assignStmt  : IDENTIFIER OP_ASSIGNMENT expr                     { }
            | IDENTIFIER index OP_ASSIGNMENT expr               { }
            ;
index       : SQUARE_OPEN expr SQUARE_CLOSING                   { }
            | SQUARE_OPEN expr RANGE_DOTS expr SQUARE_CLOSING   { }
            ;

compStmt    : BEGIN_ stmtList END_                              { }
            ;
stmtList    : stmtList SEMICOLON statement                      { }
            | statement                                         { }
            ;


ifStmt      : IF expr THEN statement                            {ifs++;}
            | IF expr THEN statement ELSE statement             {ifs++;}
            ;

whileStmt   : WHILE expr DO statement                           {whiles++;}
            ;

expr        : simpleExpr relOp simpleExpr                       { }
            | simpleExpr                                        { }
            ;

simpleExpr  : simpleExpr addOp term                             { }
            | term                                              { }
            ;

term        : term mulOp factor                                 { }
            | factor                                            { }
            ;

factor      : LITERAL_INTEGER                                   { }
            | LITERAL_REAL                                      { }
            | LITERAL_STRING                                    { }
            | LITERAL_TRUE                                      { }
            | LITERAL_FALSE                                     { }

            | IDENTIFIER                                        { }
            | IDENTIFIER SQUARE_OPEN expr SQUARE_CLOSING        { }

            | IDENTIFIER BRACKETS_OPEN exprList BRACKETS_CLOSING { }

            | OP_NOT factor                                     { }
            | OP_SUB factor                                     { }

            | BRACKETS_OPEN expr BRACKETS_CLOSING               { }
            ;

relOp       : OP_EQUALS                                         { }
            | OP_NOT_EQUALS                                     { }
            | OP_LESS                                           { }
            | OP_LESS_EQUAL                                     { }
            | OP_GREATER                                        { }
            | OP_GREATER_EQUAL                                  { }
            ;

addOp       : OP_ADD                                            { }
            | OP_SUB                                            { }
            | OP_OR                                             { }
            ;

mulOp       : OP_MUL                                            { }
            | OP_DIV                                            { }
            | OP_INTEGER_DIV                                    { }
            | OP_AND                                            { }


exprList    : exprList COMMA expr                               { }
            | expr                                              { }
            ;
%%

int main (void) {
    yyparse();

    if (!error) {
        std::cout << std::endl << "Kod ma prawidłową strukturę" << std::endl;
        printOccurances();
    }
}

void yyerror(const char* msg) {
    std::cout << "Znaleziono blad w linii " << yylineno << ": " << msg << "\n" << std::endl;
    error = true;
}

int getLineNum (Token* endDot) {
    return endDot->lineNumber;
}

void printOccurances () {
    std::cout << "Zliczono " << wiersze << " wierszy." << std::endl;
    std::cout << "Zliczono " << ifs << " instrukcji if." << std::endl;
    std::cout << "Zliczono " << whiles << " instrukcji while." << std::endl;
}