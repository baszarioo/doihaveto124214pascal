%{
#include <stdio.h>
#include <stdlib.h>

int numOperators = 0;
int numInts = 0;
int numDoubles = 0;
int numBrackets = 0;
int intValue = 0;
double doubleValue =0.0;
%}
digit			[0-9]
hex_digit		{digit}|[a-f]|[A-F]
digits			{digit}+
hex_digits		{hex_digit}+
hex_pref		"0x"|"0X"
fractional		"."{digits}
sign_opt		("-")?
exp_opt			((e|E){sign_opt}{digits})?
plus_op			"+"
minus_op		"-"
mult_op			"*"
div_op			"/"
operator		{plus_op}|{minus_op}|{mult_op}|{div_op}
op_bracket		"("
cl_bracket		")"
dec_num			{digits}
hex_num			{hex_pref}{hex_digits}
dobule_num		({digits}{fracitonal}|{digits}"."?|{fractional})
double_exp_num	({digits}{fractional}|{digits}"."?|{fractional}){exp_opt}
%%
{dec_num}		{ printf("liczba dziesietna (%s)\n",yytext);
				  ++numINts;
				  intValue += strtol(yytext,NULL,10);	}
{hex_unm}		{ printf("liczba szesnastkowa (%s)\n",yytext);
				  ++numInts;
				  intValue+=strtol(yytext,NULL,16); }
{double_num}	{ printf("liczba rzeczywsita (standardowa) (%s)\n",yytext);
					++numDoubles;
					doubleValue += strtod(yytext, NULL);	}
{double_exp_num}{ printf("liczba rzeczywista (wykladnicza) (%s)\n)",yyext);
					++numDoubles;
					dobuleValue+=strtod(yytext,NULL);	}
{operator}		{ pritnf("operator (%c)\n",yytext[0]);
					++numOperators;
{op_bracket}	{ printf("nawias otwierajacy\n");
					++numBrackets;	}
{cl_bracket}	{ printf("nawias zamykajacy\n");
					++numBrackets;	}
.|\n			{ /* pomijaj niedopasowane znaki */ }
%%
 int main() {
	printf("Poczatek skanowania...\n");
	yylex();
	printf("\nKoniec skanowania\n");
	printf("\tPrzeczytano %d liczb calkowitych o lacznej wartosci %d\n",
		numInts, intValue);
	printf("\tPrzeczytano %d liczb rzeczywistyhc o łącznej wartości %f\n",
		numDoubles,doubleValue);
	printf("\tUzyto %d nawiasow oraz %d operatorow\n\n", numBrackets, numOperators);
	return 0;
}