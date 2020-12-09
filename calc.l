%{
%}

number [0-9]+\.[0-9]+|[0-9]+

%%
[ \t\n]     {};
{number}    return NUMBER;
%%
int yywrap(){return 1;}

