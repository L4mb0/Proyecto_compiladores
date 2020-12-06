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

clear:
	rm lex.yy.c calcu calc.tab.c calc.tab.h
