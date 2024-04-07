%{

%}

SEQ_NUM       ([0-9]{1,6})[ \t\n]+
COUNTY_2DIGIT (C|CE|CN|CW|D|DL|G|KE|KK|KY|L|LK|LD|LH|LM|LS|MH|MN|MO|OY|RN|SO|TN|TS|W|WD|WH|WX|WW)
COUNTY_3DIGIT (C|CE|CN|CW|D|DL|G|KE|KK|KY|L|LD|LH|LM|LS|MH|MN|MO|OY|RN|T|SO|W|WH|WX|WW)
YEAR_2DIGIT   (87|88|89|90|91|92|93|94|95|96|97|98|99|00|01|02|03|04|05|06|07|08|09|10|11|12)
YEAR_3DIGIT   ([1-2][0-9][1-2])
    	
%%
    	
{YEAR_2DIGIT}-{COUNTY_2DIGIT}-{SEQ_NUM}   {
	int year = atoi(yytext);
	if (year > 86) {
		year += 1900;
    } 
	else {
    	    year += 2000;
    }
    printf("%d\n", 2024 - year);
}
    	
{YEAR_3DIGIT}-{COUNTY_3DIGIT}-{SEQ_NUM}    {
    int year = atoi(yytext);
    year = 2000 + (year / 10);
    printf("%d\n", 2024 - year);
}
    	
.+[ \t\n]	{ printf("INVALID\n");}

\n          {}
    	
%%
    	
int main() {
	yylex();
    return 0;
}