a.out: lex.yy.o y.tab.o ass4_15CS10045_translator.o
	g++ lex.yy.o y.tab.o ass4_15CS10045_translator.o -lfl

ass4_15CS10045_translator.o: ass4_15CS10045_translator.cxx ass4_15CS10045_translator.h
	g++ -c ass4_15CS10045_translator.h
	g++ -c ass4_15CS10045_translator.cxx

lex.yy.o: lex.yy.c
	g++ -c lex.yy.c

y.tab.o: y.tab.c
	g++ -c y.tab.c

lex.yy.c: ass4_15CS10045.l y.tab.h ass4_15CS10045_translator.h
	flex ass4_15CS10045.l

y.tab.c: ass4_15CS10045.y
	yacc -dtv ass4_15CS10045.y -W

y.tab.h: ass4_15CS10045.y
	yacc -dtv ass4_15CS10045.y -W

clean:
	rm lex.yy.c y.tab.c y.tab.h lex.yy.o y.tab.o ass4_15CS10045_translator.o y.output a.out
