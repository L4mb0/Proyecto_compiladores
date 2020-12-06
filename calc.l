%{
#include "calc.tab.h"
%}

number [0-9]+(\.[0-9]+)?
%%
[ \t\n]     ;
{number}    return NUMBER;
.           return ERROR;
%%
int yywrap(){return 1;}
