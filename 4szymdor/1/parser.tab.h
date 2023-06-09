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
    AND = 258,
    ARRAY = 259,
    ASSIGN = 260,
    COLON = 261,
    COMMA = 262,
    DIV = 263,
    DO = 264,
    DOT = 265,
    ELSE = 266,
    END = 267,
    EQUAL = 268,
    FUNCTION = 269,
    GREATER_THAN = 270,
    GREATER_THAN_EQUAL = 271,
    IDENTIFIER = 272,
    IF = 273,
    INTEGER = 274,
    LESS_THAN = 275,
    LESS_THAN_EQUAL = 276,
    LPAREN = 277,
    MINUS = 278,
    MULTIPLY = 279,
    NOT = 280,
    NOT_EQUAL = 281,
    NUMBER = 282,
    OF = 283,
    OR = 284,
    PROCEDURE = 285,
    PROGRAM = 286,
    RPAREN = 287,
    SEMICOLON = 288,
    THEN = 289,
    TYPE = 290,
    VAR = 291,
    WHILE = 292,
    BEGIN = 293,
    LBRACKET = 294,
    RBRACKET = 295,
    PLUS = 296
  };
#endif

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef int YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_PARSER_TAB_H_INCLUDED  */
