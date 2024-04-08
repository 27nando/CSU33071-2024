%{
# include "ex2.tab.h"
void yyerror();
%}

%%

[0-9]+	{ yylval = atoi(yytext); return NUMBER; }
"+"	 { return ADD; }
"-"	 { return SUB; }
"*"	 { return MUL; }
"/"	 { return DIV; }
"//"(.*)\n
"["  { return OP; }
"]"  { return CP; }


\n      { return EOL; }
[ \t]   { }
.	    { yyerror(); }
%%