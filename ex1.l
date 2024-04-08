%{

%}

%%

["].*["]       {printf("string %s\n", yytext);}
["]"\""*["]    {printf("string %s\n", yytext);}
["].*["].*     {printf("syntax error\n"); return 1;}  
["]            {printf("syntax error\n"); return 1;}
[ \t\n]        {}
.              {}

%%

int main() {
	yylex();
    return 0;
}