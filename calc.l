%{
	#include <ctype.h>
	#include "y.tab.h"
	#include <stdlib.h>
	int yyerror(char *);
%}

number [0-9]+\.[0-9]+|[0-9]+

%%
[ \t\n]     {};
{number}    {
				printf("\nval: %s\n", yytext);
				yylval = atof(yytext);
				return NUMBER;
			}
%%
int yywrap(){return 1;}

