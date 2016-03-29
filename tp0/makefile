# NOMBRE DEL EJECUTABLE DEL TP
EXEC = tp0
CC = gcc
CFLAGS = -Wall -Werror -pedantic -std=c99 -g
BIN = $(filter-out $(EXEC).c, $(wildcard *.c))
BINFILES = $(BIN:.c=.o)

all: clean main todo-test

%.o: %.c %.h
	$(CC) $(CFLAGS) -c $<
	
main: $(BINFILES)  $(EXEC).c
	$(CC) $(CFLAGS) $(BINFILES) $(EXEC).c -o $(EXEC)

clean:
	rm -f $(wildcard *.o) $(EXEC)
	
test%:
	./$(EXEC) < tests/test$*/__stdin__ > tests/test$*/__out__ 2> tests/test$*/__err__
	diff -iadq tests/test$*/__out__ tests/$@/__stdout__
	
todo-test: test1 test2
	echo "PASAN TODAS LAS PRUEBAS!"

.PHONY: clean main
