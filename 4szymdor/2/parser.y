%{

#include <stdio.h>
#include <string.h>

int yyerror();
int memory[1024];
int reg;

int gatValue(int id) {
return memory[id];
}

int setValue(int id, int val) {
memory[id] = val;
}

%}

%token INPUT OUTPUT LOAD STORE ADD SUBT CLEAR HALT VAR ID NUMBER

%%

command :
| command instruction
;

instruction: '\n'
| INPUT '\n' { printf(">> "); scanf("%d",&reg); }
| OUTPUT '\n' { printf(">> "); printf("%d\n",reg); }
| LOAD num '\n' { reg = memory[$2]; }
| STORE num '\n' { memory[$2] = reg; }
| ADD num '\n' { reg += memory[$2]; }
| SUBT num '\n' { reg -= memory[$2]; }
| HALT '\n' { return 0; }
| VAR num num { memory[$2] = $3; }
| CLEAR '\n' { reg = 0; }

num: NUMBER { $$ = $1; }
| ID { $$ = $1; }

%%

main() {
bzero(&memory,sizeof(memory));
printf("Poczatek przetwarzania kodu\n\n");
yyparse();
printf("\nKoniec przetwarzania kodu\n\n");

return 0;
}

int yyerror(char *s) {
printf("Blad: %s\n", s);
}
