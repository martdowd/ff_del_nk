CLD = gcc -g -Wall -Wno-parentheses -Wno-unused-function -o $@
CL = gcc -O2 -o $@

#compile and link
ff_del_nk: ff_del_nk.c
	$(CL) ff_del_nk.c -lsqlite3
