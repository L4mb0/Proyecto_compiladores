%{
	#include <ctype.h>
	#include "calc.tab.h"
	#include <stdlib.h>
%}

number [0-9]+|[0-9]+\.[0-9]+

%%
{number}    {
	//printf("tex: %s\n", yytext);
				yylval.decimal = atof(yytext);
				return NUMBER;
			}

\+	{ yylval.sign= yytext[0];return SUM;}
\*	{ yylval.sign= yytext[0];return MUL;}
\/	{ yylval.sign= yytext[0];return DIV;}
\-	{ yylval.sign= yytext[0];return DIF;}
\(	{ yylval.sign= yytext[0];return BPA;}
\)	{ yylval.sign= yytext[0];return EPA;}
\%	{ yylval.sign= yytext[0];return MOD;}

.|\n return 0;
%%
int yywrap(){return 1;}

/*
int main(){
	while(1){
	yylex();
	printf("tex: %s\n", yytext);
	}
	return 0;
}
*/