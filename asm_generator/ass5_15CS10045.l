%{              // C Declarations and Definitions 
#include "ass5_15CS10045_translator.h"
#include "y.tab.h"
#include <math.h>
void yyerror (char *);  /* prints grammar violation message */
void count(void);
%}

%option noyywrap
%option yylineno

NZ_DIG [1-9]

DIGIT [0-9]

DIG_SEQ ({DIGIT}+)

NIC ({NZ_DIG}({DIGIT})*)

IC ({NIC}|[0])
sign [+-] 

E ([eE]{sign}?{DIG_SEQ})

FRC (({DIG_SEQ}?[\.]{DIG_SEQ})|({DIG_SEQ}[\.]))

FC (({FRC}{E}?)|{DIG_SEQ}{E})

ID_NONDIGIT [a-zA-Z_]


ESC_SEQ     \\['"?\\abfnrtv]
CCHAR       [^'\\\n]|{ESC_SEQ}
CCHARSEQ    {CCHAR}+
CHARCONSTANT      '({CCHARSEQ})'
SCHAR       [^"\\\n]|{ESC_SEQ}
SCHARSEQ    {SCHAR}+ 
STRINGLITERAL      \"({SCHARSEQ})\"



IDENTIFIER      {ID_NONDIGIT}({ID_NONDIGIT}|{DIGIT})*

KEYWORD     "unsigned"|"break"|"return"|"void"|"case"|"float"|"short"|"char"|"for"|"signed"|"while"|"goto"|"Bool"|"continue"|"if"|"default"|"do"|"int"|"switch"|"double"|"long"|"else"|"Matrix"

PUNCTUATORS     "["|"]"|"("|")"|"{"|"}"|"."|"->"|"++"|"--"|"&"|"*"|"+"|"-"|"~"|"!"|"/"|"%"|"<<"|">>"|"<"|">"|"<="|">="|"=="|"!="|"^"|"|"|"&&"|"||"|"?"|":"|";"|"="|"*="|"/="|"%="|"+="|"-="|"^="|"|="|"&="|","|"#"
WS      [ \t\n\v\f\r]+

comments                "/*"([^*]|\*+[^*/])*\*+"/"|"//"(.)*

%%


"unsigned"      { return UNSIGNED;}
"break"         { return BREAK; }
"return"        { return RETURN; }
"void"          { return VOID; }
"case"          { return CASE; }
"float"         { return FLOAT; }
"short"         { return SHORT; }
"char"          { return CHAR; }
"for"           { return FOR; }
"signed"        { return SIGNED; }
"while"         { return WHILE; }
"goto"          { return GOTO; }
"Bool"          { return BOOL;}
"continue"      { return CONTINUE; }
"if"            { return IF; }
"default"       { return DEFAULT; }
"do"            { return DO; }
"int"           { return INT;  }
"switch"        { return SWITCH; }
"double"        { return DOUBLE; }
"long"          { return LONG; }
"else"          { return ELSE; }
"Matrix"        { return MATRIX; }


{STRINGLITERAL}            { yylval.val_string = yytext;
							return STRING_LITERAL; }
{IDENTIFIER}            { yylval.symp = table->lookup(yytext);
							return IDENTIFIER; }

{IC} 			{ 	yylval.val_integer = atoi(yytext);
					return INT_CONST; }
{FC} 			{ 	yylval.val_string = yytext;
					return FLOAT_CONST; }
{CHARCONSTANT} 			{ return CHAR_CONST; }

"["             { return yytext[0]; }
"]"             {return yytext[0];}
"("             {return yytext[0]; }
")"             {return yytext[0]; }
"{"             { return yytext[0]; }
"}"             { return yytext[0]; }
"."             {return yytext[0]; }
"->"            {return POINTER; }
"++"            {return INC; }
"--"            {return DEC; }
"&"             {return yytext[0]; }
"*"             {return yytext[0]; }
"+"             {return yytext[0]; }
"-"             {return yytext[0]; }
"~"             {return yytext[0]; }
"!"             {return yytext[0]; }
"/"             {return yytext[0]; }
"%"             {return yytext[0]; }
"<<"            {return L_SHIFT; }
">>"            {return R_SHIFT; }
"<"             {return yytext[0]; }
">"             {return yytext[0]; }
"<="            {return LE_OP; }
">="            {return GE_OP; }
"=="            {return EQ_CMP; }
"!="            { return NOT_EQ; }
"^"             {return yytext[0]; }
"|"             {return yytext[0]; }
"&&"            {return LOGIC_AND; }
"||"            {return LOGIC_OR; }
"?"             {return yytext[0]; }
":"             {return yytext[0]; }
";"             {return yytext[0]; }
"="             {return yytext[0]; }
"<<="           {return LL_ASS; }
">>="           {return RR_ASS; }
"*="            {return MUL_ASS; }
"/="            {return DIV_ASS; }
"%="            {return MOD_ASS; }
"+="            {return INC_ASS; }
"-="            {return DEC_ASS; }
"^="            {return XOR_ASS; }
"|="            { return OR_ASS; }
"&="            {return AND_ASS; }
","             { return yytext[0]; }
"#"             {return yytext[0]; }
".'"            { return TRANSP; }

{comments}          { /*  printf("comment \n"); */ }

{WS}            {  /* printf(" whitespace \n");  Ignore Whitespace */ }
.               { printf(" lexical error at line = %d , text = %s \n" , yylineno , yytext );  return -99 ; }

%%

int column = 0;
void count(void) {
	int i;
	for (i = 0; yytext[i] != '\0'; i++)
		if (yytext[i] == '\n') column = 0;
		else if (yytext[i] == '\t')
			column += 8 - (column % 8);
		else
			column++;
	ECHO;
}