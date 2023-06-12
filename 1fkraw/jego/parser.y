%{

#include <stdio.h>
#include <string.h>

int yyerror();
int liczba_nawiasowan = 0;
int liczba_komentarzy = 0;
int liczba_warunkow = 0;
int liczba_petli_for = 0;
int liczba_petli_repeat = 0;
int liczba_wypisan = 0;
%}

%token PROG OTW ZAM KOM WAR PET REP UN WYP

%%

program : PROG nawiasowanie ZAM nawiasowanie { printf("KOMPILACJA ZAKONCZONA SUKCESEM"); liczba_nawiasowan++; }
	;
	
nawiasowanie : /* epsilon */
	| nawiasowanie OTW nawiasowanie ZAM { printf(" KONIEC NAWIASU "); liczba_nawiasowan++; }
	| kod
	;
	
kod : /* epsilon */
	| nawiasowanie KOM { printf(" KOMENTARZ "); liczba_komentarzy++; }
	| nawiasowanie WAR { printf(" WARUNEK "); liczba_warunkow++; }
	| nawiasowanie PET { printf(" FOR "); liczba_petli_for++; }
	| nawiasowanie REP nawiasowanie UN { printf(" REP - UNTIL "); liczba_petli_repeat++; }
	| nawiasowanie WYP { printf(" FOR "); liczba_wypisan++; }
	;
%%

main() {
printf("Poczatek skanowania ...\n");
yyparse();
printf("\nKoniec skanowania\n");
printf("Przeczytano %d nawiasowan\n",liczba_nawiasowan);
printf("Przeczytano %d komentarzy\n",liczba_komentarzy);
printf("Przeczytano %d warunkow\n",liczba_warunkow);
printf("Przeczytano %d petli for\n",liczba_petli_for);
printf("Przeczytano %d petli repeat\n",liczba_petli_repeat);
printf("Przeczytano %d petli\n",liczba_petli_repeat+liczba_petli_for);
printf("Przeczytano %d funkcji wypisujacych\n\n",liczba_wypisan);

return 0;
}

int yyerror(char *s) {
	printf("Blad: %s\n", s);
}
