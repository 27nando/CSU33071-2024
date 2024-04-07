%{
int even_count = 0;
%}

%%

[ \t\n]+         
[0-9]+		{if (atoi(yytext) % 2 == 0) even_count++;}
.                

%%

int main() {
yylex();
printf("%d\n", even_count);
return 0;
}
