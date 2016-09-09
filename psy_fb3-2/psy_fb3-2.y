
/* calculator with AST */

%{
#  include <stdio.h>
#  include <stdlib.h>
#  include "psy_funcs.h"
%}

%union {
  struct ast *a;
  double d;
  struct symbol *s;		/* which symbol */
  struct symlist *sl;
  int fn;			/* which function */
}

/* declare tokens */
%token <d> NUMBER
%token <s> NAME
%token <fn> FUNC
%token EOL

%token IF THEN ELSE WHILE DO LET


%nonassoc <fn> CMP
%right '='
%left '+' '-'
%left '*' '/'
%nonassoc '|' UMINUS
%nonassoc LOWER_THAN_ELSE
%nonassoc ELSE

%type <a> exp stmt stmt_list explist

%start calclist

%%
calclist: /* nothing */
	| calclist stmt     {
							if(debug)
								dumpast($2, 0);
							//printf("= %4.4g\n> ", eval($2));
							printf("= %4.4g\n", eval($2));
							treefree($2);
						}
	
stmt: IF exp THEN stmt %prec LOWER_THAN_ELSE	{ $$ = newflow('I', $2, $4, NULL); }
   | IF exp THEN stmt ELSE stmt 	{ $$ = newflow('I', $2, $4, $6); }
   | WHILE exp DO stmt         		{ $$ = newflow('W', $2, $4, NULL); }
   | ';'							{ $$ = newast('B', NULL, NULL);}
   | exp ';'					 	{ $$ = $1; }
   | '{' stmt_list '}'				{ $$ = $2; }
   
;

stmt_list: stmt
   | stmt stmt_list { $$ = newast('L', $1, $2); }
   ;
   
exp: exp CMP exp          { $$ = newcmp($2, $1, $3); }
   | exp '+' exp          { $$ = newast('+', $1,$3); }
   | exp '-' exp          { $$ = newast('-', $1,$3);}
   | exp '*' exp          { $$ = newast('*', $1,$3); }
   | exp '/' exp          { $$ = newast('/', $1,$3); }
   | '|' exp              { $$ = newast('|', $2, NULL); }
   | '(' exp ')'          { $$ = $2; }
   | '-' exp %prec UMINUS { $$ = newast('M', $2, NULL); }
   | NUMBER               { $$ = newnum($1); }
   | FUNC '(' explist ')' { $$ = newfunc($1, $3); }
   | NAME                 { $$ = newref($1); }
   | NAME '=' exp         { $$ = newasgn($1, $3); }
   | NAME '(' explist ')' { $$ = newcall($1, $3); }
	;

explist: exp
	| exp ',' explist  { $$ = newast('L', $1, $3); }
	;
%%
