#include "lex.yy.c"
#include <stdio.h>
extern char* yytext;
extern int yyparse();
int main()
{
  int ret = yyparse();
  if(ret==0)
  	printf(" successful parsing %s ",yytext);
  else if(ret==2)
  	printf(" unsuccessful parsing , memory finished  %s ",yytext);
  else if(ret ==1)
  	printf(" unsuccessful parsing %s ",yytext);


return 0;
}