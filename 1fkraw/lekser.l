%{

#include "parser.tab.h"
#include <stdio.h>
#include <stdlib.h>

%}

digit [0-9]
hex_digit {digit}|[a-f]|[A-F]
digits {digit}+
hex_digits {hex_digit}+
hex_pref "0x"|"0X"
plus_op "+"
minus_op "-"
mult_op "*"
div_op "/"
op_bracket "("
cl_bracket ")"
dec_num {digits}
hex_num {hex_pref}{hex_digits}

%%

{dec_num} { yylval = strtol(yytext,NULL,10); return CALKOWITA; }

{hex_num} { yylval = strtol(yytext,NULL,16); return CALKOWITA; }

{plus_op} { return PLUS; }

{minus_op} { return MINUS; }

{mult_op} { return MNOZ; }

{div_op} { return DZIEL; }

{op_bracket} { return OTW; }

{cl_bracket} { return ZAM; }

\n { return yytext[0]; }

. { /* pomijaj niedopasowane znaki */ }

%%
