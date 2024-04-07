/* Write a flex program that reads a whitespace (space tab or newline) seperated 
list of Irish car registration numbers and outputs the number of years since 
registration followed by a new line for each one. 

If an invalid registration is detected the program should output the word 
"INVALID" followed by a newline character.


The current specification for number plates is the format YYY-CC-SSSSSS. 
Those issued from 1987 to 2012 had the format YY-CC-SSSSSS. 

The components are:
YYY - a 3-digit year (e.g. 131 for January to June 2013; 132 for July to December 2013) 
YY from 1987-2012 - a 2-digit year (e.g. 87 for 1987; 05 for 2005)
CC - a 1- or 2-character County/City identifier (e.g. L for Limerick City and County; SO for County Sligo).
SSSSSS - a 1- to 6-digit sequence number, starting with the first vehicle registered in the county/city that year/period.

2014-present
C 	Cork 	
CE 	Clare 	
CN 	Cavan 	
CW 	Carlow 	
D 	Dublin 
DL 	Donegal 
G 	Galway 	
KE 	Kildare 	
KK 	Kilkenny 	
KY 	Kerry 	
L 	Limerick 
LD 	Longford 
LH 	Louth 	
LM 	Leitrim 
LS 	Laois 	
MH 	Meath 
MN 	Monaghan 	
MO 	Mayo 
OY 	Offaly 	
RN 	Roscommon 	
SO 	Sligo 	
T 	Tipperary 	
W 	Waterford 	
WH 	Westmeath 	
WX 	Wexford 	
WW 	Wicklow 	
Differences 1987-2013
L 	Limerick City
LK 	County Limerick

TN 	North Tipperary
TS 	South Tipperary
T	INVALID

W       Waterford City
WD 	County Waterford

Note you can define sub-parts of regular expressions in the definitions section and then
use these in the rule:
NUMBER  [0-9]...
COUNTY  KK|... 
YEAR  [0-9]...
%%
{YEAR}{COUNTY}{NUMBER}   { do stuff... }
*/

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