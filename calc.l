number [0-9]+(\.[0-9]+)?
%%
[  ] { }
{number} {return NUMBER;}
\n|. {return yytext[0];}
%%

