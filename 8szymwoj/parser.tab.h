/* A Bison parser, made by GNU Bison 3.0.4.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015 Free Software Foundation, Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

#ifndef YY_YY_PARSER_TAB_H_INCLUDED
# define YY_YY_PARSER_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    PROGRAM = 258,
    FUNCTION = 259,
    PROCEDURE = 260,
    BEGIN_ = 261,
    END_ = 262,
    IF = 263,
    THEN = 264,
    ELSE = 265,
    DO = 266,
    WHILE = 267,
    VAR = 268,
    OF = 269,
    COMMA = 270,
    COLON = 271,
    SEMICOLON = 272,
    RANGE_DOTS = 273,
    BRACKETS_OPEN = 274,
    BRACKETS_CLOSING = 275,
    SQUARE_OPEN = 276,
    SQUARE_CLOSING = 277,
    INTEGER = 278,
    REAL = 279,
    BOOLEAN = 280,
    ARRAY = 281,
    OP_ASSIGNMENT = 282,
    OP_NOT = 283,
    OP_EQUALS = 284,
    OP_NOT_EQUALS = 285,
    OP_LESS = 286,
    OP_LESS_EQUAL = 287,
    OP_GREATER = 288,
    OP_GREATER_EQUAL = 289,
    OP_ADD = 290,
    OP_SUB = 291,
    OP_MUL = 292,
    OP_DIV = 293,
    OP_INTEGER_DIV = 294,
    OP_AND = 295,
    OP_OR = 296,
    DOT = 297,
    LITERAL_INTEGER = 298,
    LITERAL_REAL = 299,
    LITERAL_STRING = 300,
    LITERAL_TRUE = 301,
    LITERAL_FALSE = 302,
    IDENTIFIER = 303
  };
#endif

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED

union YYSTYPE
{
#line 23 "parser.y" /* yacc.c:1909  */

    int num;
    Token* token;

#line 108 "parser.tab.h" /* yacc.c:1909  */
};

typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif

/* Location type.  */
#if ! defined YYLTYPE && ! defined YYLTYPE_IS_DECLARED
typedef struct YYLTYPE YYLTYPE;
struct YYLTYPE
{
  int first_line;
  int first_column;
  int last_line;
  int last_column;
};
# define YYLTYPE_IS_DECLARED 1
# define YYLTYPE_IS_TRIVIAL 1
#endif


extern YYSTYPE yylval;
extern YYLTYPE yylloc;
int yyparse (void);

#endif /* !YY_YY_PARSER_TAB_H_INCLUDED  */
