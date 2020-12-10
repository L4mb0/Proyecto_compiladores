%{
	#include <ctype.h>
	#include "calc.tab.h"
	#include <stdlib.h>
%}

number [0-9]+|[0-9]+\.[0-9]+
var [a-zA-Z]
Bool [tT]([rR][uU][eE])?|[fF]([aA][lL][sS][eE])?

%%
{number}	{ yylval.decimal = atof(yytext); return NUMBER;	}
{var}	{ yylval.sign = yytext[0];return VAR;}
{Bool}	{ yylval.boolean = tolower(yytext[0])=='t'; return BOOL; }

\+	{ return SUM;}
\*	{ return MUL;}
\/	{ return DIV;}
\-	{ return DIF;}
\(	{ return BPA;}
\)	{ return EPA;}
\%	{ return MOD;}
\=	{ return ASG;}
\^	{ return POW;}

\<	{ return LST;}
\>	{ return GRT;}
\<\=	{ return LTE;}
\>\=	{ return GTE;}
\=\=	{ return YEQ;}
\!\=	{ return NEQ;}

\!	{return NEG;}
\&\&	{return AND;}
\|\|	{return BOR;}

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