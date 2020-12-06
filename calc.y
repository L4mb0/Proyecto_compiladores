%{
#include <stdio.h>
#include <ctype.h>
int yyerror(char* s);
int yylex();
//#define YYSTYPE double
%}

%token NUMBER
//%left NEG
%token ERROR
%%
command: exp {printf("%.2f\n",$1);}
	   | ERROR {yyerror("bad expresion");}
	   ;

exp: term '+' exp	{$$ = $1 + $3;}
   | term '-' exp	{$$ = $1 - $3;}
   | '-' term		{$$ = - $2;}
   | term			{$$ = $1;}
   ;

term: factor '*' term	{$$ = $1 * $3;}
	| factor '/' term	{$$ = $1 / $3;}
	| factor			{$$ = $1;}
	;

factor: NUMBER		{$$ = $1;}
	  | '('exp')'	{$$ = $2;}
	  ;

%%
int main(){
	yyparse();
}

/*
int yylex(){//copied but not understood
	int c;
	while( (c=getchar()) == ' ');

	if(isdigit(c)){
		ungetc(c,stdin);
		scanf("%lf",&yylval);
		return NUMBER;
	}

	if(c==(int)"\n")return 0;
	return(c);
}
*/

int yyerror(char* s){
	fprintf(stderr, "%s\n",s);
	return 0;
}
