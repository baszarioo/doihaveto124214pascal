%{

#include <stdio.h>
#include <stdlib.h>
#include "y.tab.h"


%}

digit [0-9]
digits {digit}+
plus_op "+"
minus_op "-"
mult_op "*"
div_op "/" 
dec_num {digits}
frac_op "|"
fraction {digits}{frac_op}{digits}
op_bracket "("
cl_bracket ")"
%% 

{fraction} {sscanf(yytext, "%d|%d", &yylval.U.l, &yylval.U.m); 
		return ULAMEK;}

{plus_op} { return PLUS; }

{minus_op} { return MINUS; }

{mult_op} { return MNOZ; } 

{div_op} { return DZIEL; }

{op_bracket} {return OTW;}

{cl_bracket} {return ZAM;}

\n { return yytext[0]; } 

. { /*pomin*/ }


%%
