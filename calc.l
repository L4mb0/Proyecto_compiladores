%{
	#include <ctype.h>
	#include "calc.tab.h"
	#include <stdlib.h>
%}

number [0-9]+|[0-9]+\.[0-9]+
var [a-zA-Z]

%%
{number}	{ yylval.decimal = atof(yytext); return NUMBER;	}
{var}	{ yylval.sign= yytext[0];return VAR;}

\+	{ yylval.sign= yytext[0];return SUM;}
\*	{ yylval.sign= yytext[0];return MUL;}
\/	{ yylval.sign= yytext[0];return DIV;}
\-	{ yylval.sign= yytext[0];return DIF;}
\(	{ yylval.sign= yytext[0];return BPA;}
\)	{ yylval.sign= yytext[0];return EPA;}
\%	{ yylval.sign= yytext[0];return MOD;}
\=	{ yylval.sign= yytext[0];return ASG;}
\^	{ yylval.sign= yytext[0];return POW;}

[ \t]	;
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