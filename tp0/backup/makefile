# NOMBRE DEL EJECUTABLE DEL TP
EXEC = tp0
CC = gcc
CFLAGS = -Wall -Werror -pedantic -std=c99 -g
BIN = $(filter-out $(EXEC).c, $(wildcard *.c))
BINFILES = $(BIN:.c=.o)

all: main

%.o: %.c %.h
	$(CC) $(CFLAGS) -c $<
	
main: $(BINFILES)  $(EXEC).c
	$(CC) $(CFLAGS) $(BINFILES) $(EXEC).c -o $(EXEC)

clean:
	rm -f $(wildcard *.o) $(EXEC)

.PHONY: clean main
