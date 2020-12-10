%{
    #include <ctype.h>
    #include <stdio.h>
    #include <math.h>
	#define YYERROR_VERBOSE
    int yyerror(char *s);
    int yylex();
%}

%union{
	double decimal;
	char sign;
}

%token <decimal> NUMBER
%type <decimal> exp term factor
%type <sign> '+' '-' '*' '/' '(' ')' '%'
%token <sign> SUM MUL DIF DIV MOD BPA EPA
%%
command: exp { printf("resultado --> %lf\n",$1); }
		| error { yyerror("bad expression"); }
        ;
    
exp: exp SUM term {
		$$ = $1 + $3;
		//printf("exp:%lf\n", $$);
	}
	| exp DIF term {$$ = $1 - $3;}
   	| DIF exp {
		if ($2 == 0) {
			$$ = 0;
		} else {
		   	 $$ = $2 * -1;
		}
	}
   | term {$$=$1;}
    ;

term: term MUL factor {$$=$1 * $3;}
	| term DIV factor {
		if ($3 == 0) {
			return yyerror("El 2do valor no puede ser 0");
		} else {
		$$=$1 / $3;
		}
	}
	| term MOD factor {
		if ($3 == 0) {
			return yyerror("El 2do valor no puede ser 0");
		} else {
			$$ = fmod($1, $3);
		}
	}
    | factor {$$=$1;}
    ;

factor: NUMBER	{
				//printf("factor:%lf ",$1);
				$$=$1;
				}
      | BPA exp EPA	{$$=$2;}
    ;
%%

int main(){
	/*
	extern int yydebug;
	yydebug=1;
	*/
	while(1)
		yyparse();
	return 0;
}

/*int yylex(void){
    int c;

    while((c=getchar()) == ' ');

    if(isdigit(c)){
        ungetc(c, stdin);
        scanf("%lf", &yylval);
        return NUMBER;
    }
    
    if(c =='\n') return 0;

    return(c);

}*/

int yyerror(char *s){
    fprintf(stderr, "%s\n", s);
}

