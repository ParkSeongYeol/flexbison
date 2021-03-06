%{
	#include <stdio.h>
	#include "defines.h"
	int yylex(void);
    void yyerror(char *);
extern FILE *yyin;
extern FILE *yyout;	
%}

%token INTEGER
%left '-' '+'
%left '*'
%%

program:
        program expr '\n'		{
									TestFunc(500, 600);
									printf("sucdess. result is in output.txt\n");
									fprintf(yyout, "result=%d\n", $2);
								}
									
        | 
        ;

expr:
        INTEGER				{ $$ = $1; }	  	
		| expr '+' expr		{ $$ = $1 + $3; }
        | expr '-' expr		{ $$ = $1 - $3; }
		| expr '*' expr		{ $$ = $1 * $3; }
		
		
        ;

%%

void yyerror(char *s) {
    fprintf(stderr, "%s\n", s);
}



int main(void) {
    yyin = fopen("./aaa.txt", "r");
    yyout = fopen("./output.txt", "w+");
		
	yyparse();
	
	fclose(yyin);
	fclose(yyout);
	
	return 0;
}
