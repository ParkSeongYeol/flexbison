bison -y -d fi1.y
flex fi1.l
gcc -c y.tab.c lex.yy.c defines.c
gcc y.tab.o lex.yy.o defines.o -o fi1.exe