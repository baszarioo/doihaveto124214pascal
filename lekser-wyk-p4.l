%{ 
#include<iostream>
using namespace std;
int liczba;
%}

digit [0-9]
digits {digit}+
fractional "."{digits}
sign_opt ("+"|"-")?
exp_opt ((e|E){sign_opt}{digits})?
number {sign_opt}({digits}{fractional}|{digits}"."?|{fractional}){exp_opt}

%%

{number}	{ cout<<atof(yytext)<<","; liczba++; }

|\n {/* nothing */}

%%

int main() {
	liczba =0;
	cout<<"Poczatek skanowania..."<<endl;
	yylex();
	cout<<endl<<"Koniec skanowania, zeskanowano liczb: " << liczba <<endl;
	return 0;
}

