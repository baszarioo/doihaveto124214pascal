%{
 #include "parser.tab.h"
 #include <stdio.h>
 #include <stdlib.h>
%}

digit [0-9]
digits {digit}+
fractional "."{digits}
sign_opt ("+"|"-")?
exp_opt((e|E){sign_opt}{digits})?
number {sign_opt}({digits}{fractional}|{digits}"."?|{fractional}){exp_opt}
comment             \{[^\}]*\}|\(\*[^(\*\))]*\*\)
POCZATEK "begin"
KONIECP ^"end\."$
KONIEC "end"
WYPISZ (writeln\(.*\);)|(write\(.*\);)
CZYTAJ read\(.*\)
HALT halt
VAR var
CONST const
REPEAT (repeat)|(REPEAT)
UNTIL [uU][nN][tT][iI][lL].*;
PROGRAM ^program
TYPLICZBA (integer;)|(real;)
TABLICA array\[.*"..".*\]
DEKTAB .*:{TABLICA}
TABLICAL {DEKTAB}" of "{TYPLICZBA}
TABLICAZ {DEKTAB}" of char;"
ZMIENNALOGICZNA .*":boolean;"
PROCEDURA ^procedure.*
SPACJE " "+
PETLA for.*":=".*to.*do
ZMIENNA [a-zA-Z0-9_\[\],\+\-/\*\.\(\)']+
PRZYPISANIE {ZMIENNA}" "*":="" "*{ZMIENNA}((;)|(\n))?
ZMIENNAL {ZMIENNA}":"{TYPLICZBA}
WARUNEK "if".*then

%%

{PROGRAM} { return PROG; }
{POCZATEK} { return OTW; }
{KONIEC} { return ZAM; }
{KOMENTARZ} { return KOM; }
{WARUNEK} { return WAR; }
{PETLA} { return PET; }
{REPEAT} { return REP; }
{UNTIL} { return UN; }
{WYPISZ} { return WYP; }

%%
