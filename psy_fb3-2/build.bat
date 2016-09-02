bison -d psy_fb3-2.y
flex psy_fb3-2.l
gcc -c psy_fb3-2.tab.c lex.yy.c psy_funcs.c
gcc psy_fb3-2.tab.o lex.yy.o psy_funcs.o -o a.exe