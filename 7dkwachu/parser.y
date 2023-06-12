%{
	#include <stdio.h>
	#include <stdlib.h>
	
	int yyerror();
	int numExpressions = 0;

	int NWD(int a, int b){
		int c;
		while(b != 0){
			c = a%b;
			a = b;
			b = c;
		}
		return a;
	}
%}
%union {
struct {
	int licznik;
	int mianownik;
} fraction;
int integer;
}

%token <integer> WYMIERNA PLUS MINUS MNOZ DZIEL OTW ZAM FRACTION
%type <fraction> ulamek skladnik wiersz wyrazenie liczba

%%

calosc :
     | calosc wiersz
     ;

wiersz : '\n'
       | wyrazenie '\n' { printf("%d|%d\n", $1.licznik / NWD($1.licznik, $1.mianownik), $1.mianownik/ NWD($1.licznik, $1.mianownik)); ++numExpressions; }

wyrazenie : wyrazenie PLUS skladnik {
  					 $$.licznik = $1.licznik * $3.mianownik  + $3.licznik * $1.mianownik;
	 				 $$.mianownik = $1.mianownik * $3.mianownik; 
				    }
	| wyrazenie MINUS skladnik { 
					$$.licznik = $1.licznik * $3.mianownik - $3.licznik * $1.mianownik;
				        $$.mianownik = $1.mianownik * $3.mianownik; 
				   }
	| skladnik { 
			$$.licznik = $1.licznik; 
			$$.mianownik = $1.mianownik; 
		   }
    ;
skladnik : skladnik MNOZ ulamek { 
	 				$$.licznik = $1.licznik * $3.licznik;
					 $$.mianownik = $1.mianownik * $3.mianownik;
				 }
	 | skladnik DZIEL ulamek { 
					$$.licznik = $1.licznik * $3.mianownik; 
					$$.mianownik = $1.mianownik * $3.licznik; 
				}
	| ulamek 
    ;
ulamek : liczba FRACTION liczba{ 
       				$$.licznik = $1.licznik; 
				$$.mianownik = $3.licznik; 
			       }
       | OTW wyrazenie ZAM {
				$$.licznik = $2.licznik; 
				$$.mianownik = $2.mianownik; 
			   }
    ;
liczba :  WYMIERNA { $$.licznik = $1;}
       	| MINUS WYMIERNA { $$.licznik = -$2;}
    ;
%%

int main() {
	yyparse();
	printf("Niepoprawne wyrazenie, liczba poprawnie obliczonych wyrazen: %d\n",
numExpressions);
	return 0;
}

int yyerror(char *s){

}
