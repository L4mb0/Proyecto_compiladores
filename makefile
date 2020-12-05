calc:
	lex ./calc.l
	yacc ./calc.y
	gcc -o calcu lex.yy.c y.tab.h -ll
	./calcu

clear:
	rm  lex.yy.c y.tab.h calcu
