all: tennis

tennis.tab.c tennis.tab.h:	tennis.y
	bison -d tennis.y

lex.yy.c: tennis.lex tennis.tab.h
	flex tennis.lex

tennis: lex.yy.c tennis.tab.c tennis.tab.h
	gcc -o tennis tennis.tab.c lex.yy.c

clean:
	rm tennis tennis.tab.c lex.yy.c tennis.tab.h tennis.output