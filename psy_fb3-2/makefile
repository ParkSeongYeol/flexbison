all:	  psy_fb3-2

psy_fb3-2:	psy_fb3-2.l psy_fb3-2.y psy_funcs.h psy_funcs.c
			bison -d psy_fb3-2.y
			flex -o psy_fb3-2.lex.c psy_fb3-2.l
			gcc -g -o $@ psy_fb3-2.tab.c psy_fb3-2.lex.c psy_funcs.c

clean :
	rm -f psy_fb3-2.exe psy_fb3-2.lex.c psy_fb3-2.tab.c psy_fb3-2.tab.h