%{
	#include <stdio.h>
	extern int yylex();
	extern void yyerror(const char *s);	
%}



%start	start
%define parse.error verbose
%expect 1

%token POINTER INC DEC L_SHIFT R_SHIFT LE_OP GE_OP TRANSP EQ_CMP NOT_EQ LOGIC_AND LOGIC_OR LL_ASS RR_ASS MUL_ASS DIV_ASS MOD_ASS INC_ASS DEC_ASS XOR_ASS OR_ASS AND_ASS 
%token IDENTIFIER 
%token CONSTANT STRING_LITERAL
%token UNSIGNED BREAK RETURN VOID CASE FLOAT SHORT CHAR FOR SIGNED WHILE GOTO BOOL CONTINUE IF DEFAULT DO INT SWITCH DOUBLE LONG ELSE MATRIX



%%

start:	translation_unit    {printf(" start -> translation_unit \n");}
		;



primary_expression
	: IDENTIFIER { printf("primary-exp - > ID \n"); }
	| CONSTANT {printf("primary-exp -> constant \n");}
	| STRING_LITERAL	{printf("primary-> string-lit \n");}
	| '(' expression ')' {printf(" primary_expression -> ( expression ) \n");}
	;



postfix_expression
	:primary_expression { printf("postfix-exp -> primary-exp  \n");}
	|postfix_expression '['expression']'	{printf("postfix_exp -> postfix-expr [ expression ]\n");}
    |postfix_expression '('argument_expression_list')'		{printf("postfix_exp -> postfix-exp ( argument_expression_list ) \n");}
    |postfix_expression '('')'	{printf("postfix_exp ->	 postfix_exp()\n");}
	|postfix_expression '.' IDENTIFIER {printf("postfix_exp -> postfix_expr.IDENTIFIER\n");}
	|postfix_expression POINTER IDENTIFIER   {printf("postfix_exp  ->  postfix_expression -> IDENTIFIER\n");}
	|postfix_expression INC		{printf("postfix_expression -> postfix_exp++\n");}
	|postfix_expression DEC		{printf("postfix_expression  ->	postfix_exp--\n");}
	|postfix_expression TRANSP  { printf("postfix -> postfix TRANSP \n");}
	;

argument_expression_list
	:assignment_expression	{printf(" argument_expression_list \n");}
	|argument_expression_list ',' assignment_expression 	{printf(" argument_expression_list -> argument_expression_list, assignment_expression \n");}

unary_expression
	:postfix_expression		{printf("unary-expression -> postfix_expression \n");}
	|INC unary_expression	{printf("unary-expression -> INC unary-expression \n");}
	|DEC unary_expression	{printf("unary_expression  -> - unary_expression ");}
	|unary_operator cast_expression		{printf(" unary_expression -> unary_operator cast_expression \n");}
	;

unary_operator
	:'&'	{printf(" unary_operator -> & \n");}
	|'*'	{printf("unary_operator -> * \n");}
	|'+'	{printf("unary_operator -> + \n");}
	|'-'	{printf("unary_operator -> - \n");}
	;









cast_expression
	: unary_expression		{printf("cast_expression -> unary_expression \n");}
	;

multiplicative_expression
	:cast_expression  {printf(" multiplicative_expression -> cast_expression\n");}
	|multiplicative_expression '*' cast_expression 		{printf(" multiplicative_expression -> multiplicative_expression*cast_expression \n");}
	|multiplicative_expression '/' cast_expression 		{printf(" multiplicative_expression -> multiplicative_expression/ cast_expression \n");}
	|multiplicative_expression '%' cast_expression 		{printf(" multiplicative_expression -> multiplicative_expression MOD cast_expression \n");}
	;

additive_expression
	:multiplicative_expression		{printf(" additive_expression->multiplicative_expression \n");}
	|additive_expression'+'multiplicative_expression		{printf(" additive_expression-> additive_expression + multiplicative_expression \n");}
	|additive_expression'-'multiplicative_expression 		{printf(" additive_expression->multiplicative_expression- multiplicative_expression \n");}
	;

shift_expression
	:additive_expression 		{printf("shift_expression -> additive_expression \n");}
	|shift_expression L_SHIFT additive_expression	{printf(" shift_expression -> shift_expression << additive_expression \n");}
	|shift_expression R_SHIFT additive_expression	{printf(" shift_expression -> shift_expression >> additive_expression \n");}
	;

relational_expression
	:shift_expression 		{printf("relational_expression -> shift_expression \n");}
	|relational_expression'<'shift_expression 		{printf("relational_expression -> relational_expression < shift_expression \n" );}
	|relational_expression'>'shift_expression  		{printf(" relational_expression -> relational_expression > shift_expression \n");}
	|relational_expression LE_OP shift_expression 	{printf(" relational_expression -> relational_expression <= shift_expression \n");}
	|relational_expression GE_OP shift_expression   {printf(" relational_expression -> relational_expression >= shift_expression \n");}
	;

equality_expression
	:relational_expression								{printf("equality_expression -> relational_expression \n");}
	|equality_expression EQ_CMP relational_expression     {printf("equality_expression -> equality_expression == relational_expression \n");}
	|equality_expression NOT_EQ relational_expression    {printf("equality_expression -> equality_expression != relational_expression \n");}
	;

AND_expression
	: equality_expression 						{printf(" AND_expression -> equality_expression \n");}
	| AND_expression '&' equality_expression  	{printf(" AND_expression -> AND_expression & equality_expression \n");}
	;

exclusive_OR_expression
	: AND_expression 							{printf("exclusive_OR_expression -> AND_expression \n");}
	| exclusive_OR_expression'^'AND_expression  	{printf("exclusive_OR_expression -> exclusive_OR_expression ^ AND_expression \n");}
	;

inclusive_OR_expression 							
	: exclusive_OR_expression 				{printf(" inclusive_OR_expression -> exclusive_OR_expression\n");}
	| inclusive_OR_expression '|' exclusive_OR_expression  {printf(" inclusive_OR_expression -> inclusive_OR_expression | exclusive_OR_expression \n");}
	;

logical_AND_expression
	: inclusive_OR_expression  					{printf(" logical_AND_expression -> inclusive_OR_expression \n");}
	| logical_AND_expression LOGIC_AND inclusive_OR_expression  {printf(" logical_AND_expression -> logical_AND_expression && inclusive_OR_expression \n");}
	;

logical_OR_expression
	: logical_AND_expression 					{printf("logical_OR_expression -> logical_AND_expression \n");}
	| logical_OR_expression LOGIC_OR logical_AND_expression 		{printf(" logical_OR_expression -> logical_OR_expression LOGIC_OR logical_AND_expression \n");}
	;

conditional_expression
	: logical_OR_expression  		{printf(" conditional_expression -> logical_OR_expression \n");}
	| logical_OR_expression '?' expression ':' conditional_expression  	{printf(" conditional_expression -> logical_OR_expression ? expression : conditional_expression \n");}
	;

assignment_expression
	: conditional_expression  	{printf(" assignment_expression -> conditional_expression \n");}
	| unary_expression assignment_operator assignment_expression 		{printf(" assignment_expression -> unary_expression assignment_operator assignment_expression \n");}
	;

assignment_operator
	: '='  	{printf("assignment_operator\n");}
	| MUL_ASS   {printf(" assignment_operator -> MUL_ASS\n");}
	| DIV_ASS   {printf(" assignment_operator -> DIV_ASS \n");}
	| MOD_ASS   {printf(" assignment_operator -> MOD_ASS \n");}
	| INC_ASS  	{printf(" assignment_operator -> INC_ASS \n");}
	| DEC_ASS  	{printf(" assignment_operator -> DEC_ASS \n");}
	| LL_ASS  	{printf(" assignment_operator -> LL_ASS \n");}
	| RR_ASS 	{printf(" assignment_operator -> RR_ASS \n");}
	| AND_ASS	{printf("assignment_operator -> AND_ASS \n");}
	| XOR_ASS 	{printf(" assignment_operator -> XOR_ASS \n");}
	| OR_ASS 	{printf(" assignment_operator -> OR_ASS \n");}
	;

expression
	: assignment_expression  			{printf("expression -> assignment_expression \n");}
	| expression','assignment_expression  	{printf(" expression -> expression , assignment_expression \n");}
	;

constant_expression
	: conditional_expression  		{printf("constant_expression -> conditional_expression \n");}
	;

init_declarator_list_opt
	: init_declarator_list {printf(" init_declarator_list_opt -> init_declarator_list \n ");}
	| %empty						{printf("init_declarator_list_opt -> epslon \n");}


declaration
	:declaration_specifiers init_declarator_list_opt ';'   		{printf("declaration -> declaration_specifiers init_declarator_list_opt \n");}
	;

declaration_specifiers_opt
	: declaration_specifiers {printf(" declaration_specifiers_opt -> declaration_specifiers \n" );}
	| %empty			{printf("declaration_specifiers_opt -> epslon \n ");}


declaration_specifiers
	: type_specifier declaration_specifiers_opt    	{printf("declaration_specifiers -> type_specifier declaration_specifiers_opt \n");}
	;


init_declarator_list
	: init_declarator 						{printf(" init_declarator_list -> init_declarator \n");}
	| init_declarator_list ',' init_declarator 		{printf("init_declarator_list -> init_declarator_list , init_declarator \n");}
	;

init_declarator
	: declarator 					{printf(" init_declarator -> declarator  \n");}
	| declarator '=' initializer      {printf("init_declarator -> declarator = initializer \n");}
	;

type_specifier
	:VOID  			{ printf(" type_specifier -> void \n");}
	|CHAR 			{printf(" type_specifier -> char \n");}
	|SHORT 			{ printf(" type_specifier -> SHORT \n");}
	|INT 			{ printf(" type_specifier -> int \n");}
	|LONG  			{printf(" type_specifier -> LONG \n");}
	|FLOAT 			{printf(" type_specifier -> FLOAT \n");}
	|DOUBLE 		{ printf(" type_specifier -> DOUBLE \n");}
	|SIGNED 		{ printf(" type_specifier -> SIGNED \n");}
	|UNSIGNED 		{ printf(" type_specifier -> UNSIGNED \n");}
	|BOOL 			{ printf(" type_specifier -> BOOL \n");}
	|MATRIX 		{printf(" type_specifier -> MATRIX \n");}
	;

declarator
	: pointer direct_declarator  {printf("declarator -> pointer direct_declarator \n");}
	| direct_declarator {printf("declarator -> direct_declarator \n");}
	;


direct_declarator
	: IDENTIFIER  		{printf(" direct_declarator -> IDENTIFIER \n");}
	| '(' declarator ')'   {printf(" direct_declarator -> (declarator )  \n");}
	| direct_declarator '[' assignment_expression ']'   {printf(" direct_declarator [ assignment_expression ] \n");}
	| direct_declarator '[' ']'   {printf(" direct_declarator [ ] \n");}
	| direct_declarator '(' parameter_type_list ')'  		{printf(" direct_declarator -> direct_declarator(parameter_type_list) \n");}
	| direct_declarator '(' identifier_list ')'  			{printf(" direct_declarator -> direct_declarator ( identifier_list )\n");}
	| direct_declarator '(' ')'  							{ printf(" direct_declarator -> direct_declarator () \n");}
	;


pointer
	: '*' pointer 		{printf("pointer -> * pointer \n");}
	| '*' 				{printf("pointer -> * \n");}
	;

parameter_type_list  		
	: parameter_list 		{printf(" parameter_type_list -> parameter_list \n");}
	;

parameter_list
	: parameter_declaration   	{printf(" parameter_list -> parameter_declaration \n");}
	| parameter_list ',' parameter_declaration  	{printf(" parameter_list -> parameter_list , parameter_declaration \n");}
	;

parameter_declaration
	: declaration_specifiers declarator  		{printf(" parameter_declaration -> declaration_specifiers declarator \n");}
	| declaration_specifiers 					{printf(" parameter_declaration -> declaration_specifiers \n");}
	;

identifier_list
	: IDENTIFIER 				{printf(" identifier_list -> IDENTIFIER \n");}
	| identifier_list ',' IDENTIFIER  	{printf("identifier_list -> identifier_list , IDENTIFIER \n");}
	;


initializer
	: assignment_expression  		{printf(" initializer -> assignment_expression \n");}
	| '{' initializer_row_list '}' 		{printf("initializer -> {initializer_row_list } \n");}
	;

initializer_row_list
	: initializer_row 				{printf(" initializer_row_list -> initializer_row \n");}
	| initializer_row_list ';' initializer_row  		{printf(" initializer_row_list -> initializer_row_list ; initializer_row \n");}
	;

initializer_row
	: designation initializer 		{printf(" initializer_row -> designation initializer \n");}
	| initializer 					{printf(" initializer_row -> initializer \n");}
	| initializer_row ',' designation initializer 		{printf(" initializer_row -> initializer_row designation initializer \n");}
	| initializer_row ',' initializer  			{printf(" initializer_row -> initializer_row initializer \n");}
	;

designation
	: designator_list '='  		{printf("designation\n");}
	;

designator_list
	: designator 			{printf(" designator_list -> designator \n");}
	| designator_list designator  		{printf(" designator_list -> designator_list designator \n");}
	;

designator
	: '[' constant_expression ']'  	{printf(" designator -> [ constant_expression ] \n");}
	| '.' IDENTIFIER 	{printf("designator-> . IDENTIFIER \n");}
	;

statement
	: labeled_statement		{printf(" statement -> labeled_statement \n");}
	| compound_statement 	{printf(" statement -> compound_statement \n");}
	| expression_statement  {printf(" statement -> expression_statement \n");}
	| selection_statement 	{printf(" statement -> selection_statement \n");}
	| iteration_statement 	{printf(" statement -> iteration_statement \n");}
	| jump_statement  		{printf("statement -> jump_statement  \n");}
	;

labeled_statement
	: IDENTIFIER ':' statement  		{printf(" labeled_statement -> IDENTIFIER : statement \n");}
	| CASE constant_expression ':' statement 		{printf(" labeled_statement -> CASE constant_expression : statement \n");}
	| DEFAULT ':' statement 		{printf("labeled_statement -> DEFAULT : statement   \n");}
	;

compound_statement
	: '{' '}'  						{printf(" compound_statement -> {} \n");}
	| '{' block_item_list '}'  		{printf("compound_statement -> { block_item_list } \n");}
	;

block_item_list
	: block_item 			{printf(" block_item_list -> block_item \n");}
	| block_item_list block_item 			{printf(" block_item_list -> block_item_list block_item\n");}
	;

block_item
	: declaration 		{printf(" block_item -> declaration \n");}
	| statement    		{printf("block_item -> statement \n");}
	;


expression_opt
	:expression  		{printf(" expression_opt -> expression \n");}
	| %empty			{printf("expression_opt -> epslon \n ") ; }


expression_statement
	: expression_opt ';'  {printf("expression_statement -> expression_opt ; \n");}
	;



selection_statement
	: IF '(' expression ')' statement   			{printf(" selection_statement -> IF ( expression ) statement \n");}
	| IF '(' expression ')' statement ELSE statement  		{printf(" selection_statement -> IF ( expression ) statement ELSE statement \n");}
	| SWITCH '(' expression ')' statement  			{printf(" selection_statement -> SWITCH ( expression ) statement \n");}
	;




iteration_statement
	: WHILE '(' expression ')' statement  			{printf(" iteration_statement -> WHILE ( expression ) statement \n");}
	| DO statement WHILE '(' expression ')' ';' 		{printf(" iteration_statement -> DO statement WHILE ( expression ) ; \n");}
	| FOR '(' expression_opt ';' expression_opt ';' expression_opt')' statement  {printf(" iteration_statement -> FOR ( expression_opt ;  expression_opt  ; expression_opt ) statement \n");}
	| FOR '(' declaration expression_opt ';' expression_opt ')' statement  			{printf(" iteration_statement -> declaration expression_opt expression_opt ) statement \n");}
	;

jump_statement
	: GOTO IDENTIFIER ';'   		{printf("jump_statement -> GOTO IDENTIFIER \n");}
	| CONTINUE ';'  				{printf("jump_statement -> CONTINUE \n");}
	| BREAK ';'  					{printf("jump_statement-> BREAK \n");}
	| RETURN ';'   					{printf("jump_statement -> RETURN \n");}
	| RETURN expression ';'  	{printf("jump_statement -> RETURN expression \n");}
	;

translation_unit
	: external_declaration 							{printf("translation_unit -> external_declaration \n");}
	| translation_unit external_declaration  		{printf("translation_unit -> translation_unit external_declaration \n");}
	;

external_declaration
	: function_definition  					{printf(" external_declaration -> function_definition \n");}
	| declaration  							{ printf(" external_declaration -> declaration \n");}
	;

function_definition
	: declaration_specifiers declarator declaration_list compound_statement  		{printf(" function_definition -> declaration_specifiers declarator declaration_list compound_statement \n");}
	| declaration_specifiers declarator compound_statement  			{printf(" function_definition ->  declaration_specifiers declarator compound_statement\n");}
	;


declaration_list
	: declaration  							{printf(" declaration_list -> declaration \n");}
	| declaration_list declaration  		{ printf(" declaration_list -> declaration_list declaration \n");}
	;


%%
void yyerror(const char *str)
{
	printf(" parse error , %s , line no = %d \n ",str , yylineno);
	//return -99;
}
