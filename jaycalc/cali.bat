bison -d cal.y
flex cal.l
gcc cal.tab.c lex.yy.c cali.c -o cali.exe
