all: compiler

compiler:
	bison -d ex1401.y
	gcc ex1401.tab.c -o ex1401.exe -DLINUXUSE
