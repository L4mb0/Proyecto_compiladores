%{
    #include <ctype.h>
    #include <stdio.h>
    int yyerror(char *s);
    int yylex();
    #define YYSTYPE double
%}

%token NUMBER
%%
command: exp { printf("resultado --> %lf\n",$1); }
		| error { yyerror("bad expression"); }
        ;
    
exp: exp '+' term {
//		printf("exp: %d\n", $1);
		$$ = $1 + $3;
	}
   | exp '-' term {$$ = $1 - $3;}
   | term {$$=$1;}
    ;

term: term '*' factor {$$=$1 * $3;}
	| term '/' factor {
		// TODO: Validar que $3 no sea 0.
		$$=$1 / $3;
	}
    | factor {$$=$1;}
    ;

factor: NUMBER {$$=$1;}
      | '('exp')'{$$=$2;}
    ;
%%

int main(){
	/*extern int yydebug;
	yydebug=1;*/
	yyparse();
}

int yylex(void){
    int c;

    while((c=getchar()) == ' ');

    if(isdigit(c)){
        ungetc(c, stdin);
        scanf("%lf", &yylval);
        return NUMBER;
    }
    
    if(c =='\n') return 0;

    return(c);

}

int yyerror(char *s){
    fprintf(stderr, "%s\n", s);
    return 0;
}

