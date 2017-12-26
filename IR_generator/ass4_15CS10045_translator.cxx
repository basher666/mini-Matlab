#include "ass4_15CS10045_translator.h"

/************ Global variables *************/

quad_vector qarr;				//pointer to quad array
type_e TYPE;					// Stores latest type specifier
symbol_table* gTable;			//pointer to global Symbbol Table
bool gDebug = false;			// Debug mode
symbol_table* table;			// Points to current symbol table
ST_entry* current_symbol; 				// points to latest function entry in symbol table
/*
get_type_size():	returns the type size of the of a specific symbol element type
input:				a pointer to a symbol element type
return:				an integer specifying the size
*/
int get_type_size (symbol_element_type* t)
{
	switch (t->cat)
	{
		case _VOID:
			return 0;
		case _CHAR:
			return size_of_char;
		case MAT:
			if(t->ptr==NULL)
			{
				return t->width * size_of_double;
			}
			return t->width * get_type_size (t->ptr);
		case PTR:
			return size_of_pointer;
		case ARR:
			return t->width * get_type_size (t->ptr);
		case _INT:
			return size_of_int;
		case _DOUBLE:
			return size_of_double;
		case FUNC:
			return 0;
	}
}

/*
convert_to_string():	converts a particular type to string , used for printing quads
input:				a symbol element type specifying the type of the entry
return:				string specifying the type
*/

string convert_to_string (const symbol_element_type* t)
{
	if (t==NULL) return "null";
	switch (t->cat)
	{
		case _VOID:
			return "void";
		case _CHAR:
			return "char";
		case _INT:
			return "int";
		case _DOUBLE:
			return "double";
		case PTR:
			return "ptr("+ convert_to_string(t->ptr)+")";
		case ARR:
			return "arr(" + tostr(t->width) + ", "+ convert_to_string (t->ptr) + ")";
		case FUNC:
			return "funct";
		case MAT:
			//cout<<"convert_to_string - > MAT"<<endl;
			if(t->ptr==NULL)
			{
				return "Matrix("+tostr(t->width)+")";
			}
			return "Matrix("+tostr(t->width)+","+tostr(t->ptr->width)+","+convert_to_string (t->ptr->ptr)+")";
		default:
			return "type";
	}
}
symbol_element_type::symbol_element_type(type_e cat, symbol_element_type* ptr, int width)
	{
		this->cat=cat;
		this->ptr=ptr;
		this->width=width;
	}

ST_entry* symbol_table::lookup (string name)
{
	ST_entry* s=NULL;
	list <ST_entry>::iterator it=table.begin();
	for (; it!=table.end(); it++)
	{
		if (it->name == name )
			break;
	}
	if (it!=table.end() )
	{
		return &*it;
	}
	else
	{

		s =  new ST_entry (name);
		s->category = "local";
		table.push_back (*s);
		return &table.back();

	}
}

/*
gentemp():	overloaded function for creating a temporary variable required for computation 
input:		string for initializing a variable , and a enum type or symbol element type
return:		a pointer to a newly created symbol table entry 
*/
ST_entry* gentemp ( string init,type_e t)
{
	char *n;
	n=(char *)malloc(sizeof(char)*20);
	sprintf(n, "#t%03d", table->tcount++);
	ST_entry* s = new ST_entry (n, t);
	s-> init = init;
	s-> mat_init="";
	s->mat_init.append(init);
	s->category = "temp";
	table->table.push_back ( *s);
	return &table->table.back();
}
ST_entry* gentemp (  string init , symbol_element_type* t)
 {
	char *n;
	n=(char *)malloc(sizeof(char)*20);
	sprintf(n, "#t%03d", table->tcount++);
	ST_entry* s = new ST_entry (n);
	
	if(t!=NULL)
	{
		s->type=copy_symbol_element_type(s->type, t);
		
	}
	else
		s->type = t;
	s-> init = init;
	s-> mat_init="";
	s->mat_init.append(init);
	s->category = "temp";
	table->table.push_back ( *s);
	return &table->table.back();
}
/*
copy_symbol_table_element:	used for copying all the components of a symbol_element_type instance by recursive copying
input:	the two symbol_element_type , destination and source
output:	the resultant copied destination
*/
symbol_element_type* copy_symbol_element_type(symbol_element_type* t1,symbol_element_type* t2)
{
	t1 = new symbol_element_type(_INT);
	t1->width=t2->width;
	t1->cat=t2->cat;
	if(t2->ptr!=NULL)
	{	
		t1->ptr=copy_symbol_element_type(t1->ptr,t2->ptr);
	}

	return t1;
}
symbol_table::symbol_table (string name)
{
	this->tname=name;
	this->tcount=0;
}
/*
print_table_helper:	helper function for printing the columns of the symbol table
input:	a pointer to a particular symbol table entry
return:	none
*/
void print_table_helper(const ST_entry* it)
{

	cout << left << setw(25) << it->name;
	cout << left << setw(25) << convert_to_string(it->type);
	cout << left << setw(12) << it->category;
	if(it->type!=NULL && it->type->cat==MAT && it-> init!="")
	{
		string ss("{");
		ss.append(it->init);
		ss.append("}");
		cout<<left <<setw(20) << ss;
	}
	else
	{
		cout << left << setw(20) << it->init;
	}
	cout << left << setw(8) << it->size;
	cout << left << setw(8) << it->offset;
	cout << left;
	if (it->nest == NULL)
	{
		cout << "null" <<  endl;
	}
	else
	{
		cout << it->nest->tname <<  endl;
	}
}
void symbol_table::st_heading_printer()
{
	printf("+++++-----+++++-----+++++-----+++++-----+++++-----+++++-----+++++-----+++++-----+++++-----+++++-----+++++-----\n");
	cout << "Symbol Table: " << setfill (' ') << left << setw(35)  << this -> tname ;
	cout << right << setw(20) << "Parent: ";
	if (this->parent!=NULL)
		cout << this -> parent->tname;
	else cout << "null" ;
	cout << endl;
	cout<<".............................................................................................................."<<endl;
	cout << setfill (' ') << left << setw(25) << "Name";
	printf("%-25s", "Type");
	printf("%-12s", "Category");
	printf("%-20s", "Initial Value");
	
	//cout << left << setw(8) << "Size";
	printf("%-8s", "Size");
	printf("%-8s", "Offset");
	printf("Nest \n");
	printf("**************************************************************************************************************\n");
}
void symbol_table::print(int all) 
{
	list<symbol_table*> tablelist;
	st_heading_printer();
	for (list <ST_entry>::iterator it = table.begin(); it!=table.end(); it++)
	{

		//cout << &*it;
		print_table_helper(&*it);
		if (it->nest!=NULL) 
			tablelist.push_back (it->nest);
	}
	//cout<<"/////-----/////-----/////-----/////-----/////-----/////-----/////-----/////-----/////-----/////-----/////-----"<<endl;
	cout << endl;
	if (all==1)
		nested_table_print(tablelist);
}
void symbol_table::nested_table_print(list<symbol_table*> tablelist)
{
	//cout<<"nested_table_print"<<endl;
	list<symbol_table*>::iterator iterator = tablelist.begin();
	for (; iterator != tablelist.end(); ++iterator) 
		{
		    (*iterator)->print();
		}

}
/*
debugger():	function for printing the debug string when the debug flag is true
input:		debug string
ouptut:		printing the string
*/
void debugger(string prompt)
{
	cout<<" -> "<<prompt<<endl;
}
quad::quad (string result, string arg1, opcode op, string arg2)
	{
		this->result=result;
		this->op=op;
		this->arg1=arg1;
		this->arg2=arg2;
	}

quad::quad (string result, int arg1, opcode op, string arg2)
	{

		this->result=result;
		this->op=op;
		this ->arg1 = num_to_string(arg1);
		this-> arg2=arg2;

	}
ST_entry::ST_entry (string name, type_e t, symbol_element_type* ptr, int width) 
{
	type = new symbol_element_type (symbol_element_type(t, ptr, width));
	nest = NULL;
	init = "";
	this->name=name;
	mat_init = "";
	category = "";
	offset = 0;
	size = get_type_size(type);
}
ST_entry* ST_entry::initialize (string init)
{
	this->init = init;
}
ST_entry* ST_entry::update(symbol_element_type* t)
{
	type = t;
	this -> size = get_type_size(t);
	return this;
}
ST_entry* ST_entry::update(type_e t)
{
	this->type = new symbol_element_type(t);
	this->size = get_type_size(this->type);
	return this;
}
void quad::update(int addr)
{
	this ->result = addr;
}
/*
quad_print_helper()	: helper function for printing a quad
input: 				string of result and argument 1
output:				printing of result and argument1 in correct format
*/
void quad_print_helper(string result, string arg1)
{
	cout<<result<<"="<<arg1;
}
/*
quad_print_goto_helper()	: helper function for printing a quad
input: 				string of result and argument 2
output:				printing of result and argument2 in correct format
*/
void quad_print_goto_helper(string arg2,string result)
{
	cout<<arg2<<" goto "<<result;
}
void quad_print_if_helper(string arg1)
{
	cout<<"if "<<arg1;
}
void quad::print () 
{
	switch(op)
	{
		// Shift Operations
		case EQUAL:			quad_print_helper(result,arg1);								break;
		case LEFTOP:		quad_print_helper(result,arg1); 	cout<< " << " << arg2;				break;
		case RIGHTOP:		quad_print_helper(result,arg1); 	cout<< " >> " << arg2;				break;

		// Binary Operations
		case ADD:			quad_print_helper(result,arg1); 	cout<< " + " << arg2;				break;
		case SUB:			quad_print_helper(result,arg1); 	cout<< " - " << arg2;				break;
		case MULT:			quad_print_helper(result,arg1); 	cout<< " * " << arg2;				break;
		case DIVIDE:		quad_print_helper(result,arg1); 	cout<< " / " << arg2;				break;
		case MODOP:			quad_print_helper(result,arg1); 	cout<< " % " << arg2;				break;
		case XOR:			quad_print_helper(result,arg1); 	cout<< " ^ " << arg2;				break;
		case INOR:			quad_print_helper(result,arg1); 	cout<< " | " << arg2;				break;
		case BAND:			quad_print_helper(result,arg1); 	cout<< " & " << arg2;				break;
		// Relational Operations
		case EQOP:			quad_print_if_helper(arg1); cout<<  " == "; 	quad_print_goto_helper(arg2,result);				break;
		case GT:			quad_print_if_helper(arg1); cout<< " > ";  		quad_print_goto_helper(arg2,result);				break;
		case GE:			quad_print_if_helper(arg1); cout<<  " >= "; 	quad_print_goto_helper(arg2,result);				break;
		case NOT_EQ_OP:			quad_print_if_helper(arg1); cout<<" != "; 		quad_print_goto_helper(arg2,result);				break;
		case LT:			quad_print_if_helper(arg1); cout<<" < ";  		quad_print_goto_helper(arg2,result);				break;
		case LE:			quad_print_if_helper(arg1); cout<<" <= "; 		quad_print_goto_helper(arg2,result);				break;
		case GOTOOP:		cout << "goto " << result;						break;

		//Unary Operators
		case ADDRESS:		cout << result << " = &" << arg1;				break;
		case PTRR:			cout << result	<< " = *" << arg1 ;				break;
		case PTRL:			cout << "*" << result	<< " = " << arg1 ;		break;
		case UMINUS:		cout << result 	<< " = -" << arg1;				break;
		case BNOT:			cout << result 	<< " = ~" << arg1;				break;
		case LNOT:			cout << result 	<< " = !" << arg1;				break;

		case ARRR:	 		cout << result << " = " << arg1 << "[" << arg2 << "]";			break;
		case ARRL:	 		cout << result << "[" << arg1 << "]" <<" = " <<  arg2;			break;
		case TRANSPOSE:		cout << result << " = " << arg1 << ".'";	break;
		case _RETURN: 		cout << "ret " << result;				break;
		case PARAM: 		cout << "param " << result;				break;
		case CALL: 			cout << result << " = " << "call " << arg1<< ", " << arg2;				break;
		case LABEL:			cout << result << ": ";					break;
		default:			cout << "op";							break;
	}
	cout << endl;

}



ST_entry* ST_entry::link_symbol_table(symbol_table* t)
{
	this->nest = t;
	this->category = "function";
}
void quad_vector::print_quad_heading()
{
	cout << "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Quad Table ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~" << endl;
	cout << setfill (' ') << left << setw(8) << "index";
	cout << setw(8) << " op";
	cout << setw(8) << "arg 1";
	cout << setw(8) << "arg 2";
	cout << setw(8) << "result" << endl;
}
void quad_vector::print_quad_array()
{
	print_quad_heading();
	vector<quad>::iterator it = array.begin();

	while (it!=array.end())
	{
		cout << left << setw(8) << it - array.begin();
		cout << left << setw(8) << return_op(it->op);
		cout << left << setw(8) << it->arg1;
		cout << left << setw(8) << it->arg2;
		cout << left << setw(8) << it->result << endl;
		it++;
	}
}
void symbol_table::offset_set()
{
	list<symbol_table*> tablelist;
	list <ST_entry>::iterator it = table.begin();
	int off;
	for (; it!=table.end();) 
	{
		if (it->nest!=NULL)
			tablelist.push_back (it->nest);
		
		if (it==table.begin())
		{
			it->offset = 0;
			off = it->size;

		}
		else if(it!=table.begin())
		{
			it->offset = off;
			off = it->offset + it->size;
		}

		it++;

	}

	nested_set_offset(tablelist);



}
/*
nested_set_offset:	correctly sets the off set of the nested symbol tables
input:				a stl list of the nested symbol tables
output:				computes the offset of the symbol table entries, returns nothing
*/
void nested_set_offset(list<symbol_table*>nested_list)
{
	list<symbol_table*>::iterator iterator = nested_list.begin();
	for (;iterator != nested_list.end();) 
	{
	    (*iterator)->offset_set();
	    iterator++;
	}
}

/*
merge:	used for merging a list of statements with another
input:	
*/
list<int> merge (list<int> &a, list <int> &b) 
{
	a.merge(b);
	return a;
}
void backpatch (list <int> l, int addr)
{
	list<int>::iterator it=l.begin();
	while (it!=l.end())
	{
		qarr.array[*it].result = tostr(addr);
		it++;
	}

}
/*
emit:	overloaded function for emitting ,i.e., entering a three address code into the quad array containing all the codes
input:	opcode , the result , argument1 and argument 2
output:	creates a new quad and putting that quad into the existing quad array
*/
void emit(opcode op, string result, int arg1, string arg2) 
{
	quad* tmp_quad= new quad(result,arg1,op,arg2);
	qarr.array.push_back(*tmp_quad);
}
void quad_vector::print () 
{
	vector<quad>::iterator it = array.begin();
	cout << setw(30) << setfill ('=') << "="<< endl;
	printf("Quad Translation\n");
	cout << setw(30) << setfill ('-') << "-"<< setfill (' ') << endl;
	while(it!=array.end())
	{
		if (it->op == LABEL)
		{
			cout << endl;
			it->print();
			cout <<endl;

		}
		else 
		{
			cout << setw(4) << it - array.begin() << "->\t";
			it->print();
		}
		it++;
	}
	cout << setw(30) << setfill ('-') << "-"<< endl;
}
/*
for2_handler(): handles the second for loop rule in the bison file
input:	required pointers to expressions and statements and intstruction
output:	correct backpatching and emmission of three address code , return none
*/
void for2_handler(statement* s0 ,int i4,expr_struct* e5, int i6, expr_struct* e8, int i10,statement* s11)
{
	convert_to_bool(e5);
	backpatch (e5->truelist, i10);
	backpatch (e8->nextlist, i4);
	backpatch (s11->nextlist, i6);
	emit (GOTOOP, tostr(i6));
	s0->nextlist = e5->falselist;	
}
/*
do_while_handler: 	deals with the backpatching part for do while loop statement
input:		necessary pointers to statements , expr_structessions and integers
output:		required backpatching calls , returns none
*/
void do_while_handler(statement* s0 ,int i2, statement* s3, int i4,expr_struct* e7)
{
	convert_to_bool(e7);
	backpatch (e7->truelist, i2);
	backpatch (s3->nextlist, i4);
	// Some bug in the next statement
	s0->nextlist = e7->falselist;
}

//for propagating expression pointers in the bison rules
expr_struct* prop_expression(expr_struct* e1 ,expr_struct* e2)
{
	e1=e2;
	return e1;
}
/*
for1_handler(): handles the first for loop rule in the bison file
input:	required pointers to expressions and statements and intstruction
output:	correct backpatching and emmission of three address code , return none
*/
void for1_handler(statement* s0,int i4, expr_struct* e5,int i7,statement* s8)
{
		convert_to_bool(e5);
		backpatch (e5->truelist, i7);
		backpatch (s8->nextlist, i4);
		emit (GOTOOP, tostr(i4));
		s0->nextlist = e5->falselist;
}
/*
not_eq_handler:	this function handles the not equal comparison expression in the bison rule
input:	required pointers to expressions from the parsing stack
output:	necessary emmitting of quads and creating of lists , returns none
*/
void not_eq_handler(expr_struct* e0,expr_struct* e1,expr_struct* e3)
{
	convert_from_bool (e1);
	convert_from_bool (e3);
	e0->isbool = true;
	e0->truelist = makelist (next_instruction());
	e0->falselist = makelist (next_instruction()+1);
	emit (NOT_EQ_OP,"", e1->symp->name, e3->symp->name);
	emit (GOTOOP, "");
}
/*
eq_cmp_handler:	this function handles the equal comparison expression in the bison rule
input:	required pointers to expressions from the parsing stack
output:	necessary emmitting of quads and creating of lists , returns none
*/
void eq_cmp_handler(expr_struct* e0,expr_struct* e1,expr_struct* e3)
{
	convert_from_bool (e0);
	convert_from_bool (e3);
	e0->isbool = true;
	e0->truelist = makelist (next_instruction());
	e0->falselist = makelist (next_instruction()+1);
	emit (EQOP, "", e1->symp->name, e3->symp->name);
	emit (GOTOOP, "");
}
/*
less_than_handler:	this function handles the less than '<' comparison expression in the bison rule
input:	required pointers to expressions from the parsing stack
output:	necessary emmitting of quads and creating of lists , returns none
*/
void less_than_handler(expr_struct* e0, expr_struct* e1 , expr_struct* e3)
{
	e0->isbool = true;
	e0->truelist = makelist (next_instruction());
	e0->falselist = makelist (next_instruction()+1);
	emit(LT, "", e1->symp->name, e3->symp->name);
	emit (GOTOOP, "");
}
/*
greater_than_handler:	this function handles the greater than '>' comparison expression in the bison rule
input:	required pointers to expressions from the parsing stack
output:	necessary emmitting of quads and creating of lists , returns none
*/
void greater_than_handler(expr_struct* e0, expr_struct* e1 , expr_struct* e3)
{
	e0->isbool = true;
	e0->truelist = makelist (next_instruction());
	e0->falselist = makelist (next_instruction()+1);
	emit(GT, "", e1->symp->name, e3->symp->name);
	emit (GOTOOP, "");
}
/*
less_equal_handler:	this function handles the less than or equal to '<=' comparison expression in the bison rule
input:	required pointers to expressions from the parsing stack
output:	necessary emmitting of quads and creating of lists , returns none
*/
void less_equal_handler(expr_struct* e0,expr_struct* e1,expr_struct* e3)
{
	e0->isbool = true;
	e0->truelist = makelist (next_instruction());
	e0->falselist = makelist (next_instruction()+1);
	emit(LE, "", e1->symp->name, e3->symp->name);
	emit (GOTOOP, "");
}
/*
great_than_handler:	this function handles the greater than or equal to '>=' comparison expression in the bison rule
input:	required pointers to expressions from the parsing stack
output:	necessary emmitting of quads and creating of lists , returns none
*/
void great_equal_handler(expr_struct* e0,expr_struct* e1,expr_struct* e3)
{
	e0->isbool = true;
	e0->truelist = makelist (next_instruction());
	e0->falselist = makelist (next_instruction()+1);
	emit(GE, "", e1->symp->name, e3->symp->name);
	emit (GOTOOP, "");
}
/*
if_handler:	this function handles the if statement in the bison rule
input:	required pointers to expressions, statement , expressions and integers from the parsing stack
output:	required backpatching of codes and merging as required , returns none
*/
void if_handler(statement* s0, expr_struct* e3, int i6, statement* s7, expr_struct* e8)
{
	backpatch (e8->nextlist, next_instruction());
	convert_to_bool(e3);
	backpatch (e3->truelist, i6);
	list<int> temp = merge (e3->falselist, s7->nextlist);
	s0->nextlist = merge (e8->nextlist, temp);
}
string return_op (int op) 
{
	switch(op) {
		case ADD:				return " + ";
		case SUB:				return " - ";
		case MULT:				return " * ";
		case DIVIDE:			return " / ";
		case EQUAL:				return " = ";
		case EQOP:				return " == ";
		case NOT_EQ_OP:				return " != ";
		case LT:				return " < ";
		case GT:				return " > ";
		case GE:				return " >= ";
		case LE:				return " <= ";
		case GOTOOP:			return " goto ";
		//Unary Operators
		case ADDRESS:			return " &";
		case PTRR:				return " *R";
		case PTRL:				return " *L";
		case UMINUS:			return " -";
		case BNOT:				return " ~";
		case LNOT:				return " !";

		case ARRR:	 			return " =[]R";
		case _RETURN: 			return " ret";
		case PARAM: 			return " param ";
		case CALL: 				return " call ";
		default:				return " op ";
	}
}
/*
if_else_handler:	this function handles the if-else statement in the bison rule
input:	required pointers to expressions, statement , expressions and integers from the parsing stack
output:	required backpatching of codes and merging as required , returns none
*/
void if_else_handler(statement* s0 ,expr_struct* e3, int i6, statement* s7, expr_struct* e8,int i10,statement* s11)
{
	backpatch (e8->nextlist, next_instruction());
	convert_to_bool(e3);
	backpatch (e3->truelist, i6);
	backpatch (e3->falselist, i10);
	list <int> temp = merge (s7->nextlist, e8->nextlist);
	s0->nextlist = merge (temp, s11->nextlist);
	
}
/*
while_handler:	this function handles the while loop statement in the bison rule
input:	required pointers to expressions, statement  and integers from the parsing stack
output:	required backpatching of codes and merging as required , returns none
*/
void while_handler(statement* s0 , int i2 , expr_struct* e4 , int i6 , statement * s7)
{
	convert_to_bool(e4);
	backpatch(s7->nextlist, i2);
	backpatch(e4->truelist, i6);
	s0->nextlist = e4->falselist;
	emit (GOTOOP, tostr(i2));
}
/*
typecheck():	overloaded function for checking the type of two symbol elements
input:		two pointers to the symbol element types
output:		boolean value indicating whether they are same type or not
*/
bool typecheck(ST_entry*& s1, ST_entry*& s2)
{ 	// Check if the symbols have same type or not
	symbol_element_type* type1 = s1->type;
	symbol_element_type* type2 = s2->type;
	if (typecheck(type1, type2)) 
		{
			return true;
		}
	else if (s1 = conv (s1, type2->cat) )
		{
			return true;
		}
	else if (s2 = conv (s2, type1->cat) ) 
		{
			return true;
		}
	return false;
}
/*
makelist():		creates a new list of integers and returns it
input :			integer which holds the intial value 
output:			a list of integer of size 1 and given initial value 
*/
list<int> makelist (int i) 
{
	list<int> l(1,i);
	return l;
}
/*
emit:	overloaded function for emitting ,i.e., entering a three address code into the quad array containing all the codes
input:	opcode , the result , argument1 and argument 2
output:	creates a new quad and putting that quad into the existing quad array
*/
void emit(opcode op, string result, string arg1, string arg2)
{
	quad* tmp_quad=(new quad(result,arg1,op,arg2));
	qarr.array.push_back(*tmp_quad);
}
expr_struct* convert_from_bool (expr_struct* e) 
{	// Convert any expression to bool
	if (e->isbool)
	{
		e->symp = gentemp("",_INT);
		backpatch (e->truelist, next_instruction());
		emit (EQUAL, e->symp->name, "true");
		emit (GOTOOP, tostr (next_instruction()+1));
		backpatch (e->falselist, next_instruction());
		emit (EQUAL, e->symp->name, "false");
	}
}
/*
next_instruction():		calculates the next instruction line number from the quad array size and returns it
input:			none
output:			returns the line number of next instruction
*/
int next_instruction() 
{
	int next_line = qarr.array.size();
	return next_line;
}
/*
num_to_string():	converts number to string 
input:			integer
output:			string of the integer
*/
string num_to_string ( int no ) 
{
	stringstream convert;
	convert << no;
	return convert.str();
}


expr_struct* convert_to_bool (expr_struct* e) 
{	// Convert any expression to bool
	if (!e->isbool) 
	{
		e->falselist = makelist (next_instruction());
		emit (EQOP, "", e->symp->name, "0");
		e->truelist = makelist (next_instruction());
		emit (GOTOOP, "");
	}
}

unary_expr* prop_unary (unary_expr* u1, unary_expr* u2)
{
	u1=u2;
	return u1;
}
/*
typecheck():	overloaded function for checking the type of two symbol elements
input:		two pointers to the symbol element types
output:		boolean value indicating whether they are same type or not
*/
bool typecheck(symbol_element_type* t1, symbol_element_type* t2)   //function for checking if the symbol_element are equal or not
{
	if (t1 != NULL || t2 != NULL) 
	{
		if (t1==NULL)
		{
			return false;
		}
		if (t2==NULL) 
		{
			return false;
		}
		if (t1->cat==t2->cat) 
		{
			return (t1->ptr, t2->ptr);
		}
		else
		{
			return false;
		}
	}
	return true;
}
/*
prop_stat(): for propagation of statements in the bison rules
input:	two pointers to a statement
output:	returns the pointer to the statement after propagating the second statement
*/
statement* prop_stat(statement* s1, statement* s2)
{
	s1=s2;
	return s1;
}
/*
conv():	converts a symbol table entry from one valid form to another
input:	a symbol table entry , and a enum type
output:	creates a temporary if not equals and emits necessary quads for conversion
*/
ST_entry* conv (ST_entry* s, type_e t)
{
	ST_entry * temp=NULL;
	if(s->type->cat!=t)
	{
		temp = gentemp("",t);
	}
	switch (s->type->cat) 
	{
		case _INT: 
		{
			switch (t) 
			{
				case MAT:
				{
					emit(EQUAL,temp->name,"int2Matrix("+s->name+")");
					return temp;
				}
				case _DOUBLE: 
				{
					emit (EQUAL, temp->name, "int2double(" + s->name + ")");
					return temp;
				}
				case _CHAR: 
				{
					emit (EQUAL, temp->name, "int2char(" + s->name + ")");
					return temp;
				}
			}
			return s;
		}
		case _DOUBLE:
		{
			switch (t) 
			{
				case MAT:
				{
					emit(EQUAL,temp->name,"double2Matrix("+s->name+")");
					return temp;
				}
				case _INT:
				{
					emit (EQUAL, temp->name, "double2int(" + s->name + ")");
					return temp;
				}
				case _CHAR:
				{
					emit (EQUAL, temp->name, "double2char(" + s->name + ")");
					return temp;
				}
			}
			return s;
		}
		case _CHAR:
		{
			switch (t) 
			{
				case _INT: 
				{
					emit (EQUAL, temp->name, "char2int(" + s->name + ")");
					return temp;
				}
				case _DOUBLE: 
				{
					emit (EQUAL, temp->name, "char2double(" + s->name + ")");
					return temp;
				}
			}
			return s;
		}
	}
	return s;
}
/*
changeTable() : modular function for changing the current symbol table to a new table
input:	pointer to new symbol table
output:	change of table , returns none
*/
void changeTable (symbol_table* newtable)
{
	table = newtable;
}

/*
char_quote(): helper function for returning the character with quotes on its sides, for initializing a character constant
input:	character
output:	string containing the quoted char
*/
string char_quote(char c)
{
	string stemp;
	char ctmp='\'';
	stemp.push_back(ctmp);
	stemp.push_back(c);
	stemp.push_back(ctmp);
	return stemp;
}
int  main (int argc, char* argv[])
{
	gTable = new symbol_table("Global");
	table = gTable;
	yyparse();
	table->offset_set();

	cout<<"symbol table printing start "<<endl;

	table->print(1);
	cout<<"%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%"<<endl;
	cout<<"quad array printing start"<<endl;
	qarr.print();

	qarr.print_quad_array();
	
};
