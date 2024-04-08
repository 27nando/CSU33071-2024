
%{
# include "calcwithvariables.tab.h"
void yyerror();
%}

%%

"+"	    { return ADD; }
"-"	    { return SUB; }
"*"	    { return MUL; }
"/"	    { return DIV; }
"|"     { return ABS; }
[0-9]	{ yylval = atoi(yytext); return NUMBER; }

[a-z] 	{ yylval = yytext[0]; return VARIABLE; }
":="	{ return ASSIGNMENT; }
";"		{ return END; }
"print" { return PRINT; }

\n      {  }
[ \t]   {  }
.	    { yyerror("syntax error"); }

%%