%{
#include <stdio.h>
#include <stdlib.h>
#include "y.tab.h"
#include "rational.h"
%}

digit           [0-9]
fraction        {digits}"|"{digits}
digits          {digit}+
plus_op         "+"
minus_op        "-"
mult_op         "*"
div_op          "/"
op_bracket      "("
cl_bracket      ")"
dec_num         {digits}

%%

{fraction}      {  
                    //sscanf(yytext,"%d|%d",yylval.rational.licznik,yylval.rational.mianownik);
                    //return ULAMEK;
                    yylval.Rational = r;                    
                    sscanf(yytext,"%d|%d",r.licznik,r.mianownik);

                }

{dec_num}       {//sscanf(yytext,"%d",&yylval.licznik); yylval.mianownik = 1; return ULAMEK;}
{plus_op}       {return PLUS;}
{minus_op}      {return MINUS;}
{mult_op}       {return MNOZ;}
{div_op}        {return DZIEL;}
{op_bracket}    {return OTW;}
{cl_bracket}    {return ZAM;}
\n              {return yytext[0];}
.               {return STOP;}
%%