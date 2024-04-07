%{
#  include <stdio.h>
#  include <stdlib.h>
#  include <string.h>
int yylex();
int yyerror();

int values[] = {1000, 900, 500, 400, 100, 90, 50, 40, 10, 9, 5, 4, 1};
char* numerals[] = {"M","CM","D","CD","C","XC","L","XL","X","IX","V","IV","I"};
char text[800];

void decimalToNumeral(int dec)
{
  if(dec == 0)
    return;
  int index = 0;
  while(dec < values[index])
  {
    index++;
  }
  strcat(text, numerals[index]);
  dec-=values[index];
  decimalToNumeral(dec);
}

%}


/* declare tokens */
%token I II III IV V VI VII VIII IX X XX XXX XL L LX LXX LXXX XC C CC CCC CD D DC DCC DCCC CM M
%token EOL
%token OB CB ADD SUB MUL DIV

%%

calclist: /* nothing */
 | calclist exp EOL {int dec = abs($2); 
                     if($2==0){ strcat(text, "Z");}
                     if($2<0) { strcat(text, "-");}
                     decimalToNumeral(dec); printf("%s\n", text); memset(text, 0, sizeof(text));
                    }
 ; 

 exp:  factor 
 | exp ADD factor { $$ = $1 + $3; }
 | exp SUB factor { $$ = $1 - $3; } 
 ;

factor: value 
 | factor MUL value { $$ = $1 * $3; }
 | factor DIV value { $$ = $1 / $3; }
 ;


value: value term { if ($1+$2 >= 1000 & $1 < 1000) {yyerror();}
                    if ($1+$2 >= 100 & $1 < 100) {yyerror();}
                    if ($1+$2 >= 10 & $1 < 10) {yyerror();}
                    if ($1<$2) {yyerror();}
                    if ($1 != $2 || ($1 >= 1000 && $2 >= 1000)) { $$= $1+$2;}
                    else {yyerror();}
            	    }
 | OB exp CB { $$ = $2; }
 | OB exp {yyerror ("syntax error\n");}
 | term {$$ = $1;}
;

term: I {$$ = $1;}
 | II {$$ = $1;}
 | III {$$ = $1;}
 | IV {$$ = $1;}
 | V {$$ = $1;}
 | VI {$$ = $1;}
 | VII {$$ = $1;}
 | VIII {$$ = $1;}
 | IX {$$ = $1;}
 | X {$$ = $1;}
 | XX {$$ = $1;}
 | XXX {$$ = $1;}
 | XL {$$ = $1;}
 | L {$$ = $1;}
 | LX {$$ = $1;}
 | LXX {$$ = $1;}
 | LXXX {$$ = $1;}
 | XC {$$ = $1;}
 | C {$$ = $1;}
 | CC {$$ = $1;}
 | CCC {$$ = $1;}
 | CD {$$ = $1;}
 | D {$$ = $1;}
 | DC {$$ = $1;}
 | DCC {$$ = $1;}
 | DCCC {$$ = $1;}
 | CM {$$ = $1;}
 | M {$$ = $1;}
;
 
%% 
  
int main()
{
  yyparse();
  return 0;
}

int yyerror()
{
  fprintf(stderr, "syntax error\n");
  exit(0);
}