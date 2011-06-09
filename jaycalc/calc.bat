bison -d cal.y
flex cal.l
gcc cal.tab.c lex.yy.c calc.c -o calc.exe
