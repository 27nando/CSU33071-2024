%{
#  include <stdio.h>
#  include <stdlib.h>
int yylex();
void yyerror();
%}

/* declare tokens */
%token NUMBER
%token ADD SUB MUL DIV OP CP
%token EOL

%%

calclist: /* nothing */
 | calclist exp EOL { printf("%d", $2); }
 ; 

 exp:  term 
 | exp ADD term { $$ = $1 + $3; }
 | exp SUB term { $$ = $1 - $3; } 
 ;


term: factor
 | term MUL factor { $$ = $1 * $3; }
 | term DIV factor { $$ = $1 / $3; }
 ;


factor: NUMBER  
 | SUB factor        { $$ = $2 >= 0? $2 : - $2; }
 | factor SUB factor { $$ = $1 - $3; }
 | OP exp CP         { $$ = $2; }
 ;

%%

int main()
{
  yyparse();
  return 0;
}

void yyerror(char *s)
{
  fprintf(stderr, "syntax error\n");
  exit(0);
}
