parser.out: ass3_15CS10045_parser.c lex.yy.c y.tab.c lexer.out
		gcc ass3_15CS10045_parser.c -o parser.out
lexer.out: ass3_15CS10045_lexer.c y.tab.h lex.yy.c
			gcc ass3_15CS10045_lexer.c -lfl -o lexer.out
y.tab.c: ass3_15CS10045.y lex.yy.c
	 bison -dtv ass3_15CS10045.y -o y.tab.c
lex.yy.c: ass3_15CS10045.l
	  flex ass3_15CS10045.l
clean:
	  rm parser.out lexer.out
