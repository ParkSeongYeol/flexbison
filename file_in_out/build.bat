bison -y -d calc1.y
flex calc1.l
gcc -c y.tab.c lex.yy.c
gcc y.tab.o lex.yy.o -o calc1.exe