#include <stdio.h>
#include "y.tab.h"
#include "lex.yy.c"
extern int yylex(void);
extern char *yytext;

int main(int argc,char** argv)
{
	
	int token;
	while (token = yylex()) {
		if(token>=283 && token<=305)
			{
				printf("<KEYWORD, %s >\n",yytext); 
			}
		else if(token==IDENTIFIER)
			printf("<IDENTIFIER, %s >\n",yytext);
		else if(token==CONSTANT)
			printf("<CONSTANT, %s >\n",yytext);
		else if(token== STRING_LITERAL )
			printf("<STRING_LITERAL, %s >\n",yytext);
		else if(token > 0 )
			{
				printf("<PUNCTUATOR, %s >\n",yytext); 					
			}
		else
		{
			printf(" <ERROR > line no = %d \n",yylineno );
		}
	}
}