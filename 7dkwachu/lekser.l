%{

#include <stdio.h>
#include <stdlib.h>
#include "y.tab.h"
%}

digit [0-9]
digits {digit}+
plus "+"
minus "-"
mult "*"
div "/"
bracket_l "("
bracket_r ")"
fraction "|"
num {digits}

%%

{num} { yylval.integer = strtol(yytext, NULL, 10); return WYMIERNA; }

{plus} { return PLUS; }

{minus} { return MINUS; }

{mult} { return MNOZ; }

{div} { return DZIEL; }

{fraction} { return FRACTION; }

{bracket_l} { return OTW; }

{bracket_r} { return ZAM; }

\n { return yytext[0]; }

. { }

%%
