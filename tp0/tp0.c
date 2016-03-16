#include <stdio.h>
#include <string.h>

#include "matrix.h"

void show_help(const char *arg) {
	if ((strcmp(arg, "-h") == 0) || (strcmp(arg, "--help") == 0)) {
		printf("Usage:\n\ttpo -h\n\ttp0 -V\n\ttp0 < in_file > out_file 2> err_file\n\n");
		printf("Options:\n\t-V, --version\t\tPrint version and quit\n\t-h --help\t\tPrint this information and quit\n\n");
		printf("Examples:\n\ttp0 < in.txt > out.txt\n\tcat in.txt | tp0 > out.txt\n\n");
	} else if ((strcmp(arg, "-V") == 0) || (strcmp(arg, "--version") == 0)) {
		printf("TP 0. Version 1.0\n");
	}
}

int main(int argc, char *argv[]) {
	if (argc != 1) {
		show_help(argv[1]);
		return 0;
	}
	return 0;
}
