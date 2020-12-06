%{
#include "calc.tab.h"
%}

number [0-9]+(\.[0-9]+)?
%%
[ \t\n] ;
{number} {return NUMBER;}
\n|. {return yytext[0];}
%%
int yywrap(){return 1;}
