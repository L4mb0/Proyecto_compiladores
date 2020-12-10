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
	_Bool boolean;
}

%token <decimal> NUMBER
%token <sign> VAR
%token <boolean> BOOL
%token <sign> SUM MUL DIF DIV MOD BPA EPA ASG POW LST GRT LTE GTE YEQ NEQ NEG AND BOR

%type <decimal> exp term factor
%type <boolean> boolop boolexp

%left	BOR AND 
%right	POW ASG
%nonassoc	NEG
%%
command: exp { printf("result:\t%lf\n",$1); }
		| error { yyerror("bad expression"); }
		| boolexp { printf("result:\t %d \n", $1?1:0);}
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
   | DIF DIF VAR	{
	   				vars[varHash($3)]-=1;
					$$ = vars[varHash($3)];
   					}
   | SUM SUM VAR	{
	   				vars[varHash($3)]+=1;
					$$ = vars[varHash($3)];
   					}
	| VAR ASG exp	{
					vars[varHash($1)] = $3;
					printf("%c <- %lf\n",$1,$3);
					$$ = $3;
					}
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
	  | exp POW exp {$$= pow($1,$3);}
    ;

boolop: exp LST exp	{$$ = $1 < $3;}
		 | exp GRT exp	{$$ = $1 > $3;}
		 | exp LTE exp	{$$ = $1 <= $3;}
		 | exp GTE exp	{$$ = $1 >= $3;}
		 | exp YEQ exp	{$$ = $1 == $3;}
		 | exp NEQ exp	{$$ = $1 != $3;}
		 ;

boolexp: boolop	{$$ = $1;}
	   | boolexp AND boolexp {$$ = $1 && $3;}
	   | boolexp BOR boolexp {$$ = $1 || $3;}
	   | BPA boolexp EPA {$$=$2;}
	   | NEG boolexp {$$=!$2;}
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