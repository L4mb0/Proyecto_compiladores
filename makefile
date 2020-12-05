calc:
	lex ./calc.l
	yacc -v ./calc.y
	gcc -o calcu y.tab.c lex.yy.c -ll
	./calcu

clear:
	rm  lex.yy.c y.output calcu y.tab.c
