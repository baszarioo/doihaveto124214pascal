/* A Bison parser, made by GNU Bison 3.5.1.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015, 2018-2020 Free Software Foundation,
   Inc.

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

/* Undocumented macros, especially those whose name start with YY_,
   are private implementation details.  Do not rely on them.  */

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
    NAZWA = 259,
    USES = 260,
    VAR = 261,
    CYFRY = 262,
    TWODOTS = 263,
    OF = 264,
    CONST = 265,
    NAPIS = 266,
    FUNCTION = 267,
    HALT = 268,
    TBEGIN = 269,
    END = 270,
    ASSIGN = 271,
    IF = 272,
    THEN = 273,
    ELSE = 274,
    NOT = 275,
    WRITE = 276,
    WRITELN = 277,
    READ = 278,
    READLN = 279,
    EXIT = 280,
    BREAK = 281,
    WHILE = 282,
    DO = 283,
    REPEAT = 284,
    UNTIL = 285,
    FOR = 286,
    TO = 287,
    DOWNTO = 288,
    INTEGER = 289,
    REAL = 290,
    BOOLEAN = 291,
    CHARACTER = 292,
    STRING = 293,
    ARRAY = 294,
    SEMICOLON = 295,
    COMMA = 296,
    COLON = 297,
    SQR_BR_LEFT = 298,
    SQR_BR_RIGHT = 299,
    EQUAL = 300,
    DOT = 301,
    APOSTROF = 302,
    AND = 303,
    OR = 304,
    LEQ = 305,
    GEQ = 306
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
