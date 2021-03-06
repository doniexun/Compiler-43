# OS type: Linux/Win DJGPP
ifdef OS
   EXE=.exe
else
   EXE=
endif

CFLAGS=-g
CC=gcc

quadruples$(EXE): lexer.o parser.o symbol.o error.o general.o semantics.o quadruples.o
	        $(CC) $(CFLAGS) -o $@ $^ -lm -lfl

parser.c parser.h: parser.y symbol.h
	bison -v -d -o parser.c $<

lexer.c: lexer.lex symbol.h parser.h
	flex -s -o $@ $<

quadruples.o : quadruples.c quadruples.h 
semantics.o : semantics.c semantics.h 
parser.o: parser.c parser.h
lexer.o: lexer.c parser.h
general.o  : general.c general.h error.h
error.o    : error.c general.h error.h
symbol.o   : symbol.c symbol.h general.h error.h




.PHONY: clean distclean

clean:
	$(RM) lexer.c parser.c parser.h parser.output *.o *~ lexer.o

distclean: clean
	$(RM) quadruples$(EXE)
