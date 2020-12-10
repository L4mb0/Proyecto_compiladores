%{
    #include <ctype.h>
    #include <stdio.h>
    #include <math.h>
	#define YYERROR_VERBOSE
	#define VARSIZE 26
    int yyerror(char *s);
    int yylex();
	void initVars();
	int varHash(char);

	double vars[VARSIZE];
%}

%union{
	double decimal;
	char sign;
}

%token <decimal> NUMBER
%token <sign> SUM MUL DIF DIV MOD BPA EPA ASG
%token <sign> VAR

%type <decimal> exp term factor
%type <sign> '+' '-' '*' '/' '(' ')' '%'
%%
command: exp { printf("resultado --> %lf\n",$1); }
		| error { yyerror("bad expression"); }
		| VAR ASG exp	{
						vars[varHash($1)] = $3;
						printf("%c <- %lf\n",$1,$3);
						}
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
	  | VAR {$$= vars[varHash($1)];}
    ;
%%

int main(){
	/*
	extern int yydebug;
	yydebug=1;
	*/
	initVars();

	while(1)
		yyparse();

	return 0;
}

int yyerror(char *s){
    fprintf(stderr, "%s\n", s);
}

void initVars(){
	for(int i=0;i<VARSIZE;i+=1)
		vars[i]=0;
}

int varHash(char id){
	return tolower(id)-'a';
}