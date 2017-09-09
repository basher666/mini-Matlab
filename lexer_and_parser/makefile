parser.out: mini_matlab_parser.c lex.yy.c y.tab.c lexer.out
		gcc mini_matlab_parser.c -o parser.out
lexer.out: mini_matlab_lexer.c y.tab.h lex.yy.c
			gcc mini_matlab_lexer.c -lfl -o lexer.out
y.tab.c: mini_matlab.y lex.yy.c
	 bison -dtv mini_matlab.y -o y.tab.c
lex.yy.c: mini_matlab.l
	  flex mini_matlab.l
clean:
	  rm parser.out lexer.out y.output lex.yy.c y.tab.c y.tab.h
