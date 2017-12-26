%{

	#include <string.h>
	#include <stdio.h>
	#include "ass4_15CS10045_translator.h"
	extern	int yylex();
	void yyerror(const char *s);
	extern type_e TYPE;
	extern int gDebug;

%}
/*
val_integer	: 	integer value to store the integer value encountered in the program .
instruct 	:	int value which holds the next instruction number, which comes handy during backpatching
val_string	:	character string to store the intialized strings or floats
exp* 		:	for storing the necessary data structures required for expressions
A 			:	for storing the required data for unary expressions
st 			:	for storing the symbol element type of a particular non -terminal
instruct 	:	used for storing the instruction line numbers
symp 		: 	pointer to a symbol table entry 
stat 		:	pointer to statement data structures

*/

/*
AUGMENTATIONS:

constant 	:	added new grammar rules for constant -> integer , float , char constant and string literals
M 			:	added this for backpatching
N 			:	same as above added this non terminal for backpatching
CST 		: 	added this non terminal to decide where to change symbol tabel
*/
%union {
	ST_entry* symp;
	int val_integer;
	list <int>* nl;
	char* val_string;
	expr_struct* exp;
	unary_expr* A;
	symbol_element_type* st;
	statement* stat;
	int instruct;
	char unary_op;	//unary operator
	
}

%define parse.error verbose
%expect 1

%token POINTER INC DEC L_SHIFT R_SHIFT LE_OP GE_OP TRANSP EQ_CMP NOT_EQ LOGIC_AND LOGIC_OR LL_ASS RR_ASS MUL_ASS DIV_ASS MOD_ASS INC_ASS DEC_ASS XOR_ASS OR_ASS AND_ASS
%token UNSIGNED BREAK RETURN VOID CASE FLOAT SHORT CHAR FOR SIGNED WHILE GOTO BOOL CONTINUE IF DEFAULT DO INT SWITCH DOUBLE LONG ELSE MATRIX
%token <val_string> STRING_LITERAL
%token <symp>IDENTIFIER
%token <val_integer>INT_CONST
%token <val_string> FLOAT_CONST
%token <val_string> CHAR_CONST

%type <exp> expression
%type <exp>	exclusive_OR_expression
%type <exp>	logical_AND_expression
%type <exp>	primary_expression
%type <exp>	multiplicative_expression
%type <exp>	additive_expression
%type <exp>	shift_expression
%type <exp>	expression_statement
%type <exp>	inclusive_OR_expression
%type <exp>	conditional_expression
%type <exp>	assignment_expression
%type <exp>	AND_expression
%type <exp>	relational_expression
%type <exp>	equality_expression
%type <exp>	logical_OR_expression



%type <unary_op> unary_operator

%type <instruct> M


%type <A> unary_expression
%type <A> cast_expression
%type <A> postfix_expression


%type <exp> N

%type <symp> constant
%type <symp> initializer_row_list
%type <symp> initializer
%type <symp> initializer_row

	
%type <stat> statement
%type <stat> labeled_statement
%type <stat> compound_statement
%type <stat> selection_statement
%type <stat> iteration_statement
%type <stat> jump_statement
%type <stat> block_item
%type <stat> block_item_list

%type <st> pointer
%type <symp> direct_declarator
%type <symp> init_declarator
%type <symp> declarator
%type <val_integer> argument_expression_list

%start	translation_unit

%%


/******** expressions *******/

primary_expression	
	: IDENTIFIER {	/*
					creates a new expression whenever it encounter an identifier , links the lhs non-terminal symbol table entry , to the
					symbol table entry of the rhs identifier			 	
					*/
				 	$$ = new expr_struct();
					$$->symp = $1;
					$$->isbool = false;
					if(gDebug)
					{
						debugger("primary_expression -> IDENTIFIER");
					}
				 }
	| constant  {
				/*
					creates a new expression for the lhs non terminal , and links the symbol table entry of lhs to the symbol table entry of
					the newly generated temporary 
				*/

				$$ = new expr_struct();
				$$->symp = $1;
				if(gDebug)
					{
						debugger("primary_expression -> constant");
					}
				}
	| STRING_LITERAL	{
						/*
						creates new expression corresponding to the primary expression , and creates a new temporary , for the string literal
						*/
						$$ = new expr_struct();
						$$->symp = gentemp( $1,PTR);
						$$->symp->initialize($1);
						$$->symp->type->ptr = new symbol_element_type(_CHAR);
						if(gDebug)
						{
							debugger("primary_expression -> STRING_LITERAL");
						}
						}
	| '(' expression ')' {
							$$=prop_expression($$,$2);
						 }
	;

constant 		//creates a new temporary for each constant and assigns it to lhs non-terminal for further propagation
	: INT_CONST {
		$$ = gentemp(num_to_string($1),_INT);	// creating a new temporary with the integer as initial value
		emit(EQUAL, $$->name, $1);
		if(gDebug)
			{
				debugger("constant -> INT_CONST");
			}
	}
	| FLOAT_CONST {
		$$ = gentemp( *new string ($1) , _DOUBLE );
		emit(EQUAL, $$->name, *new string($1));
		if(gDebug)
			{
				debugger("constant -> FLOAT_CONST");
			}
	}
	| CHAR_CONST {
	if(gDebug)
		{
			debugger("constant -> CHAR_CONSTANT");
		}

		$$ = gentemp(char_quote(yytext[1]),_CHAR);

		emit(EQUAL, $$->name, char_quote(yytext[1]));
	}
	;


postfix_expression
	: primary_expression  {
	/*
	creates a new instance of the lhs non-terminal and propagates the symbol table entry of the rhs non-terminal to lhs symbol table entry

	*/
		if(gDebug)
			{
				debugger("postfix_expression -> primary_expression");
			}
		$$ = new unary_expr ();
		$$->symp = $1->symp;
		$$->loc = $$->symp;
		$$->type = $1->symp->type;
		if($1->symp->type->cat==MAT)
		{
			$$->cat=$1->symp->type->cat;
		}
	}
	| postfix_expression '[' expression ']' {
	/*
		for computing the matrix/array address calculation , creates a temporary to store the computed address till now , then emits a code to 
		add the computed address to the current index , also emits to multiply by the address
	*/
		$$ = new unary_expr();
		$$->symp = $1->symp;			// symbol table entry copied
		$$->type = $1->type->ptr;		// type is assigned to type of the symbol element type
		$$->loc = gentemp("",_INT);		

		if ($1->cat==ARR || $1->cat==MAT) 
		{	
			ST_entry* t = gentemp("",_INT);
 			emit(MULT, t->name, $3->symp->name, num_to_string(get_type_size($$->type)));
			emit (ADD, $$->loc->name, $1->loc->name, t->name);
		}
 		else {
	 		emit(MULT, $$->loc->name, $3->symp->name, num_to_string(get_type_size($$->type)));
 		}

 		$$->cat = ARR;

	}
	| postfix_expression '(' ')'
	| postfix_expression '(' argument_expression_list ')' 
	{
		$$ = new unary_expr();
		$$->symp = gentemp("",$1->type->cat);
		emit(CALL, $$->symp->name, $1->symp->name, tostr($3));
	}
	| postfix_expression '.' IDENTIFIER /* to be ignored */
	| postfix_expression POINTER IDENTIFIER  /* to be ignored */
	| postfix_expression INC 
	{	/*
			creates a new instance of lhs non-terminal and then generating a temporary to store the incremented value , and then adding the emmitting
			codes to do the actual computation
		*/
		$$ = new unary_expr();
		$$->symp = gentemp("",$1->symp->type->cat);

		emit (EQUAL, $$->symp->name, $1->symp->name);

		if($1->type->cat == _INT)
		{
			emit (ADD, $1->symp->name, $$->symp->name, "1");
		}
		else if($1->type->cat == _DOUBLE)
		{
			emit (ADD, $1->symp->name, $$->symp->name, "1.0");
		}
		else if($1->type->cat == _CHAR)
		{
			emit (ADD, $1->symp->name, $$->symp->name, "1");
		}
		else if($1->type->cat==PTR)
		{
			if($1->type->ptr->cat==_INT)
			{
				emit(ADD, $1->symp->name , $$->symp->name, num_to_string(size_of_int));
			}
			else if($1->type->ptr->cat== _DOUBLE)
			{
				emit(ADD, $1->symp->name , $$->symp->name, num_to_string(size_of_double));
			}
			else if($1->type->ptr->cat==_CHAR)
			{
				emit(ADD, $1->symp->name , $$->symp->name, num_to_string(size_of_char));
			}
			else
			{
				cout<<convert_to_string(new symbol_element_type($1->cat))<<endl;	
				cout<<"cannot increment this type error"<<endl;
				exit(1);
			}	
		}
		else
		{
			cout<<convert_to_string(new symbol_element_type($1->cat))<<endl;	
			cout<<"cannot increment this type error"<<endl;
			exit(1);
		}
	}
	| postfix_expression DEC 
	{
		/*
			handles the cases of var--
			currently handles pointers to, decrements by size of type it is pointing to
		*/
		$$ = new unary_expr();

		$$->symp = gentemp("",$1->symp->type->cat);
		emit (EQUAL, $$->symp->name, $1->symp->name);

		if($1->type->cat == _INT)
		{
			emit (SUB, $1->symp->name, $$->symp->name, "1");
		}
		else if($1->type->cat == _DOUBLE)
		{
			emit (SUB, $1->symp->name, $$->symp->name, "1.0");
		}
		else if($1->type->cat == _CHAR)
		{
			emit (SUB, $1->symp->name, $$->symp->name, "1");
		}
		else if($1->type->cat==PTR)
		{
			if($1->type->ptr->cat==_INT)
			{
				emit(SUB, $1->symp->name , $$->symp->name, num_to_string(size_of_int));
			}
			else if($1->type->ptr->cat== _DOUBLE)
			{
				emit(SUB, $1->symp->name , $$->symp->name, num_to_string(size_of_double));
			}
			else if($1->type->ptr->cat==_CHAR)
			{
				emit(SUB, $1->symp->name , $$->symp->name, num_to_string(size_of_char));
			}
			else
			{
				cout<<convert_to_string(new symbol_element_type($1->cat))<<endl;	
				cout<<"cannot increment this type error"<<endl;
				exit(1);
			}	
		}
		else
		{
			cout<<convert_to_string(new symbol_element_type($1->cat))<<endl;	
			cout<<"cannot increment this type error"<<endl;
			exit(1);
		}
	}
	|postfix_expression TRANSP
	{
		/*
			rule for matrix transpose , sets the trnaspose starting flag
		*/

		if(gDebug)
		{
			debugger("postfix_expression -> postfix_expression TRANSP");
		}
		
		$1->start_trans=true;
	}
	;



argument_expression_list
	: assignment_expression 
	{
	/*
		used during a function calling
	*/
		if(gDebug)
		{
			debugger("argument_expression_list -> assignment_expression");
		}
		emit (PARAM, $1->symp->name);
		$$ = 1;
	}
	| argument_expression_list ',' assignment_expression 
	{

		if(gDebug)
		{
			debugger("argument_expression_list -> assignment_expression , assignment_expression");
		}
		emit (PARAM, $3->symp->name);
		if(gDebug)
		{
			debugger("assignment_expression ++");
		}
		$$ = $1+1;
	}
	;



unary_expression
	: postfix_expression 
	{
		if(gDebug)
		{
			debugger("unary_expression -> postfix_expression");
		}
		$$=prop_unary($$,$1);

	}
	| INC unary_expression 
	{
		/*
			much like in the case of postfix expression 
			similar handling of pointers

		*/
		$$ = new unary_expr();
		$$->symp = gentemp("",$2->symp->type->cat);

		emit (EQUAL, $$->symp->name, $2->symp->name);

		if($2->type->cat == _INT)
		{
			emit (ADD, $2->symp->name, $$->symp->name, "1");
		}
		else if($2->type->cat == _DOUBLE)
		{
			emit (ADD, $2->symp->name, $$->symp->name, "1.0");
		}
		else if($2->type->cat == _CHAR)
		{
			emit (ADD, $2->symp->name, $$->symp->name, "1");
		}
		else if($2->type->cat==PTR)
		{
			if(gDebug)
				debugger("++ pointer");
			if($2->type->ptr->cat==_INT)
			{
				emit(ADD, $2->symp->name , $$->symp->name, num_to_string(size_of_int));
			}
			else if($2->type->ptr->cat== _DOUBLE)
			{
				emit(ADD, $2->symp->name , $$->symp->name, num_to_string(size_of_double));
			}
			else if($2->type->ptr->cat==_CHAR)
			{
				emit(ADD, $2->symp->name , $$->symp->name, num_to_string(size_of_char));
			}
			else
			{
				cout<<convert_to_string(new symbol_element_type($2->cat))<<endl;	
				cout<<"cannot increment this type error"<<endl;
				exit(1);
			}	
		}
		else
		{
			cout<<convert_to_string(new symbol_element_type($2->cat))<<endl;	
			cout<<"cannot increment this type error"<<endl;
			exit(1);
		}


	}
	| DEC unary_expression 
	{
		/*
			much like in the case of postfix expression 
			similar handling of pointers

		*/
		$$ = new unary_expr();
		$$->symp = gentemp("",$2->symp->type->cat);

		emit (EQUAL, $$->symp->name, $2->symp->name);

		if($2->type->cat == _INT)
		{
			emit (SUB, $2->symp->name, $$->symp->name, "1");
		}
		else if($2->type->cat == _DOUBLE)
		{
			emit (SUB, $2->symp->name, $$->symp->name, "1.0");
		}
		else if($2->type->cat == _CHAR)
		{
			emit (SUB, $2->symp->name, $$->symp->name, "1");
		}
		else if($2->type->cat==PTR)
		{
			if(gDebug)
				debugger("-- pointer");
			if($2->type->ptr->cat==_INT)
			{
				emit(SUB, $2->symp->name , $$->symp->name, num_to_string(size_of_int));
			}
			else if($2->type->ptr->cat== _DOUBLE)
			{
				emit(SUB, $2->symp->name , $$->symp->name, num_to_string(size_of_double));
			}
			else if($2->type->ptr->cat==_CHAR)
			{
				emit(SUB, $2->symp->name , $$->symp->name, num_to_string(size_of_char));
			}
			else
			{
				cout<<convert_to_string(new symbol_element_type($2->cat))<<endl;	
				cout<<"cannot increment this type error"<<endl;
				exit(1);
			}	
		}
		else
		{
			cout<<convert_to_string(new symbol_element_type($2->cat))<<endl;	
			cout<<"cannot increment this type error"<<endl;
			exit(1);
		}


	}
	| unary_operator cast_expression 
	{
		$$ = new unary_expr();
		switch ($1) 
		{
			case '&':
				$$->symp = gentemp("",PTR);
				$$->symp->type->ptr = $2->symp->type;
				emit (ADDRESS, $$->symp->name, $2->symp->name);
				break;
			case '*':
				$$->loc = gentemp ("",$2->symp->type->ptr);
				$$->cat = PTR;
				emit (PTRR, $$->loc->name, $2->symp->name);
				$$->symp = $2->symp;
				break;
			case '+':
				$$ = $2;
				break;
			case '-':
				$$->symp = gentemp("",$2->symp->type->cat);
				emit (UMINUS, $$->symp->name, $2->symp->name);
				break;
			case '~':
				//$$->symp = gentemp("",$2->symp->type->cat);
				//emit (BNOT, $$->symp->name, $2->symp->name);
				break;
			case '!':
				$$->symp = gentemp("",$2->symp->type->cat);
				emit (LNOT, $$->symp->name, $2->symp->name);
				break;
			default:
				break;
		}
	}
	;


unary_operator //stores the unary operator encountered into the non-terminal attribute
	: '&' 
	{
		$$ = '&';
	}
	| '*' 
	{
		$$ = '*';
	}
	| '+' 
	{
		$$ = '+';
	}
	| '-' 
	{
		$$ = '-';
	}
	| '!'
	{
		if(gDebug)
			debugger("unary_op -> !");
		$$= '!';
	}
	;


cast_expression
	: unary_expression  
	{
		$$=prop_unary($$,$1);
	}
	;


multiplicative_expression
	: cast_expression 		
	{
		// this rule handles all the matrix index addressing
		if(gDebug)
		{
			debugger("multi_expr -> cast_expr");
		}
		$$ = new expr_struct();

		if ($1->cat==ARR||$1->cat==MAT)
		{	//Matrix handlings
			$$->symp = gentemp("",$1->type);
			if($1->start_trans)
			{
				int dim1=$$->symp->type->width;
				int dim2=$$->symp->type->ptr->width;
				$$->symp->type->width=dim2;
				$$->symp->type->ptr->width=dim1;
				emit(TRANSPOSE, $$->symp->name, $1->symp->name);
				$1->start_trans=false;
			}
			else
			{
				if($1->symp->name.compare($1->loc->name)==0)
				{
					emit(EQUAL, $$->symp->name, $1->symp->name, $1->loc->name);
				}
				else
				{
					emit(ARRR, $$->symp->name, $1->symp->name, $1->loc->name);
				}
			}
		}
		else if ($1->cat==PTR) 
		{ 
			// pointer handling
			$$->symp = $1->loc;
		}
		else 
		{ 
			//default
			$$->symp = $1->symp;
		}
	}
	| multiplicative_expression '*' cast_expression 	
	{
		//this handles the product in between primitive types or in between matrices
		if(gDebug)
		{
			debugger("multi_expr -> multi_expr * cast_expr");
		}
		if (typecheck ($1->symp, $3->symp) )
		{
			if($1->symp->type->cat==MAT)
			{
				$$=new expr_struct();
				$$->symp=gentemp("",$1->symp->type);
				emit(MULT, $$->symp->name , $1->symp->name , $3->symp->name);
			}
			else
			{
				$$ = new expr_struct();
				$$->symp = gentemp("",$1->symp->type->cat);
				emit (MULT, $$->symp->name, $1->symp->name, $3->symp->name);
			}
		}
		else 
		{
			debugger("Type Mismatch");
			exit(1);
		}

	}
	| multiplicative_expression '/' cast_expression 		
	{
	/*
	//this rule handles the division between primitive types and matrices ; for now, I am assuming '/' operator in 
	case of matrix means element wise division
	*/
		if(gDebug)
		{
			debugger("multi_expr -> multi_expr / cast_expr");
		}
		if (typecheck ($1->symp, $3->symp) )
		{
			if($1->symp->type->cat==MAT)
			{
				$$=new expr_struct();
				$$->symp=gentemp("",$1->symp->type);
				emit(DIVIDE, $$->symp->name , $1->symp->name , $3->symp->name);
			}
			else
			{
				$$ = new expr_struct();
				$$->symp = gentemp("",$1->symp->type->cat);
				emit (DIVIDE, $$->symp->name, $1->symp->name, $3->symp->name);
			}
		}
		else 
		{
			debugger("Type Mismatch");
			exit(1);
		}
	}
	| multiplicative_expression '%' cast_expression 		// handles modulo expressions , in case of matrix of array type ,throws type mismatch error
	{
		if(gDebug)
		{
			debugger("multi_expr -> multi_expr % cast_expr");
		}
		if (typecheck ($1->symp, $3->symp) ) {
			$$ = new expr_struct();
			$$->symp = gentemp("",$1->symp->type->cat);
			emit (MODOP, $$->symp->name, $1->symp->name, $3->symp->name);
		}
		else 
		{
			debugger("Type Mismatch");
			exit(1);
		}
	}
	;


additive_expression 		//propagation statements for additive expressions
	: multiplicative_expression 
	{
		$$ = prop_expression($$,$1);
	}
	| additive_expression '+' multiplicative_expression 		//handles addition of primitive and matrix data type , throws type mismatch error in case of mismatch
	{
		if(gDebug) 
		{
			debugger("additive_expr -> additive_expression + multiplicative_expr");
			
		}
		if (typecheck($1->symp, $3->symp))
		{
			if($1->symp->type->cat==MAT)
			{
				$$=new expr_struct();
				$$->symp=gentemp("",$1->symp->type);
				emit(ADD, $$->symp->name , $1->symp->name , $3->symp->name);
			}
			else
			{
				$$ = new expr_struct();
				$$->symp = gentemp("",$1->symp->type->cat);
				emit (ADD, $$->symp->name, $1->symp->name, $3->symp->name);
			}
		}
		else 
		{
			debugger("Type Mismatch");
			exit(1);
		}
	}
	| additive_expression '-' multiplicative_expression 		// subtraction rule for additive expression ,creates a temporary and emits the necessary quads
	{
		if(gDebug) 
		{
			debugger("additive_expr -> additive_expression - multiplicative_expr");
		}

		if (typecheck($1->symp, $3->symp))
		{
			if($1->symp->type->cat==MAT)
			{
				$$=new expr_struct();
				$$->symp=gentemp("",$1->symp->type);
				emit(SUB, $$->symp->name , $1->symp->name , $3->symp->name);
			}
			else
			{
				$$ = new expr_struct();
				$$->symp = gentemp("",$1->symp->type->cat);
				emit (SUB, $$->symp->name, $1->symp->name, $3->symp->name);
			}
		}
		else
		{
			debugger("Type Mismatch");
			exit(1);
		}
	}
	;

shift_expression
	: additive_expression 
	{
		$$ = prop_expression($$,$1);
	}
	| shift_expression L_SHIFT additive_expression 
	{
	/*
		left shifting of an integer only , throws error if any other type
	*/
		if ($3->symp->type->cat == _INT) 
		{
			$$ = new expr_struct();
			$$->symp = gentemp ("",_INT);
			emit (LEFTOP, $$->symp->name, $1->symp->name, $3->symp->name);
		}
		else
		{
			debugger("Type Mismatch");
			exit(1);
		}
	}
	| shift_expression R_SHIFT additive_expression 
	{
	/*
		right shifting of an integer only , throws error if any other type
	*/
		if ($3->symp->type->cat == _INT) 
		{
			$$ = new expr_struct();
			$$->symp = gentemp ("",_INT);
			emit (RIGHTOP, $$->symp->name, $1->symp->name, $3->symp->name);
		}
		else
		{
			debugger("Type Mismatch");
			exit(1);
		}
	}
	;

relational_expression
	: shift_expression 
		{ 
			$$ = prop_expression($$,$1);
		}
	| relational_expression '<' shift_expression {
		if (typecheck ($1->symp, $3->symp) )
		{
			// handles boolean expression
			$$ = new expr_struct();
			less_than_handler($$,$1,$3);

		}
		else
		{
			debugger("Type Mismatch");
			exit(1);
		}
	}
	| relational_expression '>' shift_expression {
		if (typecheck ($1->symp, $3->symp) ) {
			//for greater than comparison expression
			$$ = new expr_struct();
			greater_than_handler($$,$1,$3);
		}
		else
		{
			debugger("Type Mismatch");
			exit(1);
		}
	}
	| relational_expression LE_OP shift_expression {
		if (typecheck ($1->symp, $3->symp) ) {
			// for less than equal to comparison expression
			$$ = new expr_struct();
			less_equal_handler($$,$1,$3);
		}
		else
		{
			debugger("Type Mismatch");
			exit(1);
		}
	}
	| relational_expression GE_OP shift_expression 
	{
		if (typecheck ($1->symp, $3->symp) ) 
		{
			// for greater than equal to expression
			$$ = new expr_struct();
			great_equal_handler($$,$1,$3);
		}
		else
		{
			debugger("Type Mismatch");
			exit(1);
		}
	}
	;


equality_expression
	: relational_expression 
		{
			$$ = prop_expression($$,$1);
		}
	| equality_expression EQ_CMP relational_expression 
	{
		if (typecheck ($1->symp, $3->symp) ) 
		{
			//converts the value from boolean

			$$ = new expr_struct();
			eq_cmp_handler($$,$1,$3);
		}
		else
		{
			debugger("Type Mismatch");
			exit(1);
		}
	}
	| equality_expression NOT_EQ relational_expression 
	{
		if(gDebug)
		{
			debugger("equality_expr -> equality_expr NOT_EQ relational_expr");
		}
		if (typecheck ($1->symp, $3->symp) ) 
		{
			// if any is bool get its value
			$$ = new expr_struct();
			not_eq_handler($$,$1,$3);
		}
		else
		{
			debugger("Type Mismatch");
			exit(1);
		}
	}
	;


AND_expression
	: equality_expression 
	{
		$$ = prop_expression($$,$1);
	}
	| AND_expression '&' equality_expression 
	{
		if (typecheck ($1->symp, $3->symp) ) 
		{
			$$ = new expr_struct();
			$$->isbool = false;

			$$->symp = gentemp ("",_INT);
			emit (BAND, $$->symp->name, $1->symp->name, $3->symp->name);
		}
		else
		{
			debugger("Type Mismatch");
			exit(1);
		}
	}
	;

exclusive_OR_expression
	: AND_expression 
	{
		$$ = prop_expression($$,$1);
	}
	| exclusive_OR_expression '^' AND_expression 
	{
		if (typecheck ($1->symp, $3->symp) ) 
		{
			// converts the expression from boolean
			$$ = new expr_struct();
			convert_from_bool ($1);
			convert_from_bool ($3);

			$$->isbool = false;

			$$->symp = gentemp ("",_INT);
			emit (XOR, $$->symp->name, $1->symp->name, $3->symp->name);
		}
		else
		{
			debugger("Type Mismatch");
			exit(1);
		}
	}
	;

inclusive_OR_expression
	: exclusive_OR_expression 
	{
		$$ = prop_expression($$,$1);
	}
	| inclusive_OR_expression '|' exclusive_OR_expression {
		if (typecheck ($1->symp, $3->symp) ) {
			// If any is bool get its value
			convert_from_bool ($1);
			convert_from_bool ($3);

			$$ = new expr_struct();
			$$->isbool = false;

			$$->symp = gentemp ("",_INT);
			emit (INOR, $$->symp->name, $1->symp->name, $3->symp->name);
		}
		else
		{
			debugger("Type Mismatch");
			exit(1);
		}
	}
	;

logical_AND_expression 		// required for logical AND expressions
	: inclusive_OR_expression 
	{
		$$ = prop_expression($$,$1);
	}
	| logical_AND_expression N LOGIC_AND M inclusive_OR_expression 
	{
		convert_to_bool($5);

		
		backpatch($2->nextlist, next_instruction());
		convert_to_bool($1);

		$$ = new expr_struct();
		$$->isbool = true;

		backpatch($1->truelist, $4);
		$$->truelist = $5->truelist;
		$$->falselist = merge ($1->falselist, $5->falselist);
	}
	;


logical_OR_expression
	: logical_AND_expression 
	{
		$$ = prop_expression($$,$1);
	}
	| logical_OR_expression N LOGIC_OR M logical_AND_expression {
		convert_to_bool($5);

		// N to convert $1 to bool
		backpatch($2->nextlist, next_instruction());
		convert_to_bool($1);

		$$ = new expr_struct();
		$$->isbool = true;

		backpatch ($$->falselist, $4);
		$$->truelist = merge ($1->truelist, $5->truelist);
		$$->falselist = $5->falselist;
	}
	;

M 	: %empty
	{		
	// stores the address of the next instruction for later use
		$$ = next_instruction();
	};

N 	: %empty 
	{ 	// Non terminal to prevent fallthrough by emitting a goto
		$$  = new expr_struct();
		$$->nextlist = makelist(next_instruction());
		emit (GOTOOP,"");
	}

conditional_expression
	: logical_OR_expression 
	{
		$$ = prop_expression($$,$1);
	}
	| logical_OR_expression N '?' M expression N ':' M conditional_expression 
	{
		$$->symp = gentemp("",_INT); 
		$$->symp->update($5->symp->type);
		emit(EQUAL, $$->symp->name, $9->symp->name);
		list <int> l = makelist(next_instruction());
		emit (GOTOOP, "");

		backpatch($6->nextlist, next_instruction());
		emit(EQUAL, $$->symp->name, $5->symp->name);
		list <int> m = makelist(next_instruction());
		l = merge (l, m);
		emit (GOTOOP, "");

		backpatch($2->nextlist, next_instruction());
		convert_to_bool ($1);
		backpatch ($1->truelist, $4);
		backpatch ($1->falselist, $8);
		backpatch (l, next_instruction());
	}
	;

assignment_expression
	: conditional_expression 
	{
		$$ = prop_expression($$,$1);
	}
	| unary_expression assignment_operator assignment_expression
	{

		if(gDebug)
		{
			debugger("assig_expr->unary_expr assign_operator assign_expr");
		}
		switch ($1->cat)
		{
			case ARR:
				$3->symp = conv($3->symp, $1->type->cat);
				emit(ARRL, $1->symp->name, $1->loc->name, $3->symp->name);
				break;
			case PTR:
				emit(PTRL, $1->symp->name, $3->symp->name);
				break;
			case MAT:
				emit(EQUAL, $1->symp->name, $3->symp->name);
				break;
			default:
				$3->symp = conv($3->symp, $1->symp->type->cat);
				emit(EQUAL, $1->symp->name, $3->symp->name);
				break;
		}
		$$ = $3;
	}
	;

assignment_operator 		//defines the assignment operators possible, currently assignment operator by default means '='
	: '='
	| MUL_ASS
	| DIV_ASS
	| MOD_ASS
	| INC_ASS
	| DEC_ASS
	| LL_ASS
	| RR_ASS
	| AND_ASS
	| XOR_ASS
	| OR_ASS
	;

expression
	: assignment_expression 
	{
		$$ = prop_expression($$,$1);
	}
	| expression ',' assignment_expression
	{	
		if(gDebug)
			debugger("expression -> expression , assignment_expression");
	}
	;

constant_expression
	: conditional_expression  		
	{
		if(gDebug)
		{
			debugger("constant_expression -> conditional_expression ");
		}
	}
	;


/*Declaration starts here */


declaration
	: declaration_specifiers ';' 
	{
		if(gDebug)
			debugger("declaration-> declaration_specifiers ; ");

	}
	| declaration_specifiers init_declarator_list ';' 
	{	
		if(gDebug)
			debugger("declaration-> declaration_specifiers init_declarator_list ; ");
	}
	;



declaration_specifiers_opt
	: declaration_specifiers 
	{
		if(gDebug)
			debugger("declaration_specifiers_opt-> declaration_specifiers ");
	}
	| %empty			
	{
		if(gDebug)
			debugger("declaration_specifiers_opt-> epsilon");
	}


declaration_specifiers
	: type_specifier declaration_specifiers_opt
	;

init_declarator_list
	: init_declarator
	| init_declarator_list ',' init_declarator 
	{
		
	}
	;

init_declarator
	: declarator
	{
		$$ = $1;
	}
	| declarator '=' initializer
	{
		if(gDebug)
			debugger("init_declarator -> declarator = initializer");
		if($1->type->cat==MAT)
		{
			if(gDebug)
				debugger("declarator cat = MAT");
		}
		if ($3->init!="")
		{
			$1->initialize($3->mat_init);
		}
		if($1->type->cat!=MAT)
		{
			emit (EQUAL, $1->name, $3->name);
		}
		
	}
	;

type_specifier
	: VOID 
	{
		TYPE = _VOID;
	}
	| CHAR 
	{
		TYPE = _CHAR;
	}
	| SHORT
	| INT 
	{
		TYPE = _INT;
	}
	| LONG
	| FLOAT
	| DOUBLE 
	{
		TYPE = _DOUBLE;
	}
	| SIGNED
	| UNSIGNED
	| BOOL
	| MATRIX 
	{ 
		TYPE = _DOUBLE; 
	}
	;

declarator
	: pointer direct_declarator 
	{
		// for pointer operations
		symbol_element_type * t;
		t = $1;
		for (;t->ptr !=NULL;) 
			t = t->ptr;
		t->ptr = $2->type;
		$$ = $2->update($1);
	}
	| direct_declarator
	;

direct_declarator
	: IDENTIFIER 
	{
		//if an identifier is encountered in declarator phase, updates it's type and moves the current symbol pointer to the st entry of this identifier
		if(gDebug)
			debugger("direct_declarator -> IDENTIFIER");

		$$ = $1->update(TYPE);
		
		current_symbol = $$;
	}
	| '(' declarator ')' 
	{
		// simply propagates the value
		$$ = $2;
	}
	| direct_declarator '[' assignment_expression ']' 
	{
		// for array and matrix indexing 
		if(gDebug)
			debugger("direct_declarator-> direct_declarator [ assignment_expressin ]");

		symbol_element_type * t = $1 -> type;
		symbol_element_type * prev = NULL;
		while (t!=NULL && t->cat == MAT)
		{
			prev = t;
			t = t->ptr;
		}
		if (prev==NULL)
		{
			int x = atoi($3->symp->init.c_str());
			symbol_element_type* s = new symbol_element_type(MAT, $1->type, x);
			int y = get_type_size(s);
			$$ = $1->update(s);
			
		}
		else
		{

			prev->ptr =  new symbol_element_type(MAT, t, atoi($3->symp->init.c_str()));
			$$ = $1->update ($1->type);
			$1->size+=8;
		}
		
	}
	| direct_declarator '[' ']' 
	{
		symbol_element_type * t = $1 -> type;
		symbol_element_type * prev = NULL;
		while (t->cat == ARR) 
		{
			prev = t;
			t = t->ptr;
		}
		if (prev==NULL) {
			symbol_element_type* s = new symbol_element_type(ARR, $1->type, 0);
			int y = get_type_size(s);
			$$ = $1->update(s);
		}
		else {
			prev->ptr =  new symbol_element_type(ARR, t, 0);
			$$ = $1->update ($1->type);
		}
	}
	| direct_declarator '(' CST parameter_type_list ')' 
	{
		table->tname = $1->name;

		if ($1->type->cat !=_VOID) {
			ST_entry *s = table->lookup("retVal");
			s->update($1->type);
		}

		$1 = $1->link_symbol_table(table);

		table->parent = gTable;
		changeTable (gTable);				// Come back to globalsymbol table

		current_symbol = $$;
	}
	| direct_declarator '(' identifier_list ')' { /* Ignored */

	}
	| direct_declarator '(' CST ')' 
	{
		table->tname = $1->name;			// Update function symbol table name

		if ($1->type->cat !=_VOID) {
			ST_entry *s = table->lookup("retVal");// Update type of return value
			s->update($1->type);
		}

		$1 = $1->link_symbol_table(table);		// Update type of function in global table

		table->parent = gTable;
		changeTable (gTable);				// Come back to globalsymbol table

		current_symbol = $$;
	}
	;


CST : %empty 
	{ 
		/*
			used for changing symbol tables
		*/
		if (current_symbol->nest==NULL)
			changeTable(new symbol_table(""));		// creates a new symbol table
		else {
			changeTable (current_symbol ->nest);						// if already present , changetable
			emit (LABEL, table->tname);
		}
	}
	;

pointer
	: '*' 
	{
			$$ = new symbol_element_type(PTR);
	}
	| '*' pointer 
	{
		$$ = new symbol_element_type(PTR, $2);
	}
	;

parameter_type_list
	: parameter_list
	;

parameter_list
	: parameter_declaration
	| parameter_list ',' parameter_declaration 
	{
		if(gDebug)
			debugger("param_list -> param_list , param_declaration");
	}
	;

parameter_declaration
	: declaration_specifiers declarator 
	{
		if(gDebug)
			debugger("param_declaration -> declaration_specifiers declarator");	
		$2->category = "param";
	}
	| declaration_specifiers
	{
		if(gDebug)
			debugger("parameter_declaration -> declaration_specifiers");
	}
	;

identifier_list
	: IDENTIFIER
	| identifier_list ',' IDENTIFIER
	{
		if(gDebug)
			debugger("identifier_list -> identifier_list , IDENTIFIER");
	}
	;

initializer 		// initializer directs all the assignment expression symbol table entry to lhs non terminal
	: assignment_expression 
	{
		if(gDebug)
			debugger("init->ass_exp");

		$$ = $1->symp;
		
	}
	| '{' initializer_row_list '}'
		{
		if(gDebug)
			debugger("initializer -> { initialzer_row_list }");
		 
		 $$=$2;
		 
		}
	;

initializer_row_list  // this handles the matrix initializations 
	: initializer_row 				
		{
			if(gDebug)
				debugger(" initializer_row_list -> initializer_row");
		}
	| initializer_row_list ';' initializer_row  
	{

	if(gDebug)
		debugger("initialize_row_list -> initializer_row_list ; initializer_row");
	
	$$->mat_init.append(";");
	$$->mat_init.append($3->mat_init);
	}
	;

initializer_row  //handles matrix initializations row wise
	: designation initializer 	
	{
		if(gDebug)
		debugger(" initializer_row -> designation initializer ");
	}
	| initializer 				
	{

		if(gDebug)
			debugger(" initializer_row -> initializer ");
	}
	| initializer_row ',' designation initializer 		
	{
		if(gDebug)
			debugger(" initializer_row -> initializer_row , designation initializer");
	}
	| initializer_row ',' initializer  
	{

	if(gDebug)
		debugger("initializer_row -> initializer_row , initializer ");

	$$->mat_init.append(",");
	$$->mat_init.append($3->mat_init);
	}
	;

designation
	: designator_list '='  		
	{
		if(gDebug)
			debugger("designation -> designator_list = ");
	}
	;

designator_list
	: designator
	| designator_list designator
	{
		if(gDebug)
		{
			debugger("designator_list -> designator_list designator");
		}
	}
	;

designator
	: '[' constant_expression ']'
	| '.' IDENTIFIER
	{
		if(gDebug)
			debugger("designator -> .IDENTIFIER");
	}
	;


statement 				// the following rules are just for propagating values
	: labeled_statement /* to be ignored */
	| compound_statement 
	{
		$$ = $1;
		if(gDebug)
		{
			debugger("statement ->compound_statement");
		}
	}
	| expression_statement 
	{
		$$ = new statement();
		$$->nextlist = $1->nextlist;

		if(gDebug)
		{
			debugger("statement -> expression_statement");
		}
	}
	| selection_statement 
	{
		if(gDebug)
		{
			debugger("statement -> selection_statement");
		}
		$$ = $1;
	}
	| iteration_statement {
		$$ = $1;
		if(gDebug)
		{
			debugger("statement->iteration_statement");
		}
	}
	| jump_statement 
	{
		if(gDebug)
		{
			debugger("statement -> jump_statement");
		}
		$$ = $1;
		
	}
	;

labeled_statement
	: IDENTIFIER ':' statement 
	{ 
		$$ = new statement();
	}
	| CASE constant_expression ':' statement 
	{ 
		$$ = new statement();
	}
	| DEFAULT ':' statement 
	{ 
		$$ = new statement();
	}
	;


compound_statement
	: '{' '}' 
	{ 
		$$ = new statement();
	}
	| '{' block_item_list '}' 
	{ 
		$$ = $2; 
	}
	;


block_item_list
	: block_item
	{
		$$ = prop_stat($$,$1);
	}
	| block_item_list M block_item 
	{
		$$ = prop_stat($$,$3);
		backpatch ($1->nextlist, $2);
	}
	;


block_item
	: declaration
	{
		$$ = new statement();
	}
	| statement 
	{
		$$ = prop_stat($$,$1);
	}
	;


expression_statement  // for determining when the statement ends with semicolon
	: ';' 
	{	
		$$ = new expr_struct();
	}
	| expression ';' 
	{
		$$ = prop_expression($$,$1);
	}
	;

/*
selection statements handles all the if and if else statements by backpatching
switch is ignored
*/
selection_statement  // defines the if else rules , switch is not implemented
	: IF '(' expression N ')' M statement N 
	{
		$$ = new statement();
		
		if_handler($$,$3,$6,$7,$8);

	}
	| IF '(' expression N ')' M statement N ELSE M statement 
	{
		
		$$=new statement();
		if_else_handler($$,$3,$6,$7,$8,$10,$11);
	}
	| SWITCH '(' expression ')' statement // to be ignored
	{
		if(gDebug)
		{
			debugger("selection_stmt -> SWITCH (expression) statement");
		}
	}
	;


iteration_statement   // defines the iteration statement rules 
	: WHILE M '(' expression ')' M statement 
	{	
		/*
			first M is for converting expression to boolean
			second M is for checking if boolean expression is true
		*/

		$$ = new statement();

		while_handler($$,$2,$4,$6,$7);
	}
	| DO M statement M WHILE '(' expression ')' ';' 
	{
		
		/*
			 first M to go to statement if expression evaluates to true
			 second M is for marking completion of statement
		*/

		$$ = new statement();

		do_while_handler($$,$2,$3,$4,$7);

	}
	| FOR '(' expression_statement M expression_statement ')' M statement 
	{
		$$ = new statement();

		for1_handler($$,$4,$5,$7,$8);
	}
	| FOR '(' expression_statement M expression_statement M expression N ')' M statement 
	{
		$$ = new statement();
		for2_handler($$,$4,$5,$6,$8,$10,$11);
	}
	;


jump_statement /* Ignored except return */
	: GOTO IDENTIFIER ';' 
		{	
			if(gDebug)
				debugger("jump_statement -> goto identifier ;");
			$$ = new statement();
		}
	| CONTINUE ';' 
		{
			if(gDebug)
				debugger("jump_statement -> continue ;");
			$$ = new statement();
		}
	| BREAK ';' 
	{
		if(gDebug)
			debugger("jump_statement -> break ;");
		$$ = new statement();
	}
	| RETURN ';' 
	{
		if(gDebug)
			debugger("jump_statement -> return ;");
		$$ = new statement();
		emit(_RETURN,"");
	}
	| RETURN expression ';'
	{
		if(gDebug)
		{
			debugger("jump_statement -> RETURN expression ;");
		}
		$$ = new statement();
		//if (table->lookup("retVal")->type->cat==$2->symp->type->cat) 
		//{
			emit(_RETURN,$2->symp->name);
		//}

	}
	;


translation_unit
	: external_declaration
	| translation_unit external_declaration 
	{
		if(gDebug)
		{
			debugger("translation_unit -> translation_unit external_declaration");
		}
	}
	;

external_declaration
	: function_definition
	| declaration
	;

function_definition
	: declaration_specifiers declarator declaration_list CST compound_statement 
	{

	}
	| declaration_specifiers declarator CST compound_statement 
	{
//		table->tname = $2->name;

//		$2 = $2->update(FUNC, table);
		if(gDebug)
		{
			debugger("function_definition -> declaration_specifiers CST compound_statement");
			debugger("changing symbol tables");
		}
		table->parent = gTable;
		changeTable (gTable);
	}
	;

declaration_list
	: declaration
	| declaration_list declaration
	{
		if(gDebug)
		{
			debugger("declaration_list -> declaration_list declaration");
		}
	}
	;


%%
void yyerror(const char *str)
{
	printf(" parse error , %s , line no = \n ",str );
	//return -99;
}
