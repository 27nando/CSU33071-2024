/* Write a flex program even.l which takes a sequence of integers as its input and outputs
a count of the number of even integers a \n and no other characters. Note put return 0; at end of the main function
as codemark regards non zero exit status as an error. */

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
