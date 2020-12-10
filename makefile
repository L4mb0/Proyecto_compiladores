all:
	lex calc.l
	yacc -d calc.y
	gcc -o calcu y.tab.c lex.yy.c -lm
	./calcu

all2:
	flex calc.l
	bison -d calc.y
	gcc -o calcu calc.tab.c lex.yy.c -lm
	./calcu


calc_ly:
	lex ./calc.l
	yacc -d ./calc.y
	gcc -o calcu y.tab.c lex.yy.c -ll
	./calcu

calc_fb:
	flex ./calc.l
	bison -d ./calc.y
	gcc -o calcu calc.tab.c lex.yy.c
	./calcu

calc_bison:
	bison calc.y
	gcc -o calcu calc.tab.c
	./calcu

calc_debug:
	lex calc.l
	yacc -v calc.y
	gcc -o calcu y.tab.c -DYYDEBUG -ll
	./calcu

debug2:
	flex calc.l
	bison -v calc.y
	gcc -o calcu calc.tab.c lex.yy.c -DYYDEBUG
	./calcu

calc_daster:
	lex calc.l
	yacc -v calc.y
	gcc -o calcu y.tab.c -ll
	./calcu

clear:
	rm lex.yy.c calcu calc.tab.c calc.tab.h
