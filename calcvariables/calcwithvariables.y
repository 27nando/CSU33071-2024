%{
#  include <stdio.h>
#  include <stdlib.h>
#  include <string.h>
int yylex();
void yyerror();
int alphabet[26];
%}

/* declare tokens */
%token ADD SUB MUL DIV ABS ASSIGNMENT END PRINT VARIABLE NUMBER

%%

input:
 | input VARIABLE ASSIGNMENT exp END {alphabet[$2] = $4;}
 | input PRINT VARIABLE END {printf("%d\n", alphabet[$3]);}
 ;

exp: factor
 | exp ADD factor { $$ = $1 + $3; }
 | exp SUB factor { $$ = $1 - $3; }
 ;

factor: term
 | factor MUL term { $$ = $1 * $3; }
 | factor DIV term { $$ = $1 / $3; }
 ;

term: NUMBER
 | SUB NUMBER { $$ = (- $2); }
 | ABS term { $$ = $2 >= 0? $2 : - $2; }
 | VARIABLE { $$ = alphabet[($1)]; }
 ;
 
 %%

int main()
{
  yyparse();
  return 0;
}

void yyerror()
{
  fprintf(stderr, "syntax error\n");
  exit(0);
}