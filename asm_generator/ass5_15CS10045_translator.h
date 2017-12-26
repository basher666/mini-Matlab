#ifndef TRANSLATOR
#define TRANSLATOR
#include <bits/stdc++.h>
#include <algorithm>
#include <iostream>
#include <vector>
#include <string>
#include <stdint.h>

#define size_of_char 		1
#define size_of_int  		4
#define size_of_double		8
#define size_of_pointer		4

extern  char* yytext;
extern  int yyparse();


using namespace std;

/********* Forward Declarations ************/

class ST_entry;						// Entry in a symbol table
class symbol_table;					// Symbol Table
class quad;						// Entry in quad array
class quad_vector;					// All quad_vector
class symbol_element_type;					// Type of a symbol in symbol table

/************** Enum types *****************/

enum type_e
{	// Type enumeration
_VOID, _CHAR, _INT, _DOUBLE, PTR, ARR , MAT //,FUNC
};
enum opcode
{
	EQUAL,EQUALSTR,EQUALCHAR,EQUAL_DOUBLE, FUNCEND,FUNC,INIT_MAT,MAT_ADD,MAT_SUB,MAT_MUL,MAT_DIV,ARRL_I,ARRR_I,ZERO_DOUBLE,
// Relational Operators
LT, GT, LE, GE, EQOP, NOT_EQ_OP,
GOTOOP, _RETURN,
// Arithmatic Operators
ADD, SUB, MULT, DIVIDE, RIGHTOP, LEFTOP, MODOP,
// Unary Operators
UMINUS, UPLUS, ADDRESS, RIGHT_POINTER, BNOT, LNOT, TRANSPOSE,
// Bit Operators
BAND, XOR, INOR,
// PTR Assign
PTRL, PTRR,
// ARR Assign
ARRR, ARRL,
// Function call
PARAM, CALL //,LABEL
};

/********** Class Definitions *************/
/*
symbol_element_type class is for defining the symbol element type in a symbol table entry of the symbol table 
*/
void computeActivationRecord(symbol_table *ss);
void AR(symbol_table* , int  , int );
class symbol_element_type 
{
public:
	/*
	constructor for symbol_element_type
	input:	enum type, symbol element type , width of the entry
	return: NA
	*/
	symbol_element_type(type_e cat, symbol_element_type* ptr = NULL, int width = 1);
	type_e cat;					//enum type specifier to indicate the type of the current primitive type
	int width;					//size of the entry
	symbol_element_type* ptr=NULL;	// this pointer recursively defines the data types for the array and matrix structures

};

class quad_vector 
{
public:
	vector <quad> array;;						// Vector of quads , stores all the three address code for a particular instance

	quad_vector () {array.reserve(300);}		//constructor for quad vector
	void print ();								//for printing
	void print_quad_heading();					//prints the required headings for pretty table 
	void print_quad_array();					// Print quad_vector in tabular form

};



/*
class symbol_table defines the data structures and functions required in a symbol table
*/
class symbol_table
{
public:
	string tname;				// stores the name of Table
	int tcount;					//count of temporary variables
	list <ST_entry> table; 		// The table of symbols
	map<string, int> ar;			//activation record


	symbol_table* parent;


	/*
	symbol_table(): constructor for construction a new symbol table.
	input:			string with the name of the new symbol table
	return:			returns an instance of a new symbol table
	*/
	symbol_table (string name="");
	
	/*
	lookup(): Method to search for an identifier in the symbol table , return it if already present and create one if it's not present yet
	input:	the name of the id
	return:	a symbol table entry
	*/
	ST_entry* lookup (string name);					
	
	bool search (string name);


	/*
	print(int):	for printing the the symbol table. prints the nested tables recursively if the input integer is non-zero.
	input:		integer
	return: 	none
	*/
	void print(int all = 0);					

	/*
	nested_table_print() : helper function for printing the nested symbol tables
	input:	list of the nested symbol table
	return: none
	*/
	void nested_table_print(list<symbol_table*> tablelist);

	/*
	st_heading_printer(): helper function for printing the headings of the symbol table, created for modularity of the code
	input:	none
	return: none
	*/
	void st_heading_printer();


	/*
	offset_set():	function for setting the offsets of the symbol table elements
	input:	none
	return:	none
	*/
	void offset_set();						// Compute offset of the whole symbol table recursively

};

class quad
{
public:
	opcode op;					// stores the enum opcode for operator
	string result;				// sotres the result of the three address code
	string arg1;				// argument 1 of the three address code
	string arg2;				// argument 2 of the three address code

	void print ();								// for printing the particular the three address code in specified format
	void update (int addr);						// Used for backpatching address
	quad (string result, string arg1, opcode op = EQUAL, string arg2 = ""); 		//constructor for creating a new quad
	quad (string result, int arg1, opcode op = EQUAL, string arg2 = "");			//constructor for creating a new quad
};

/*
ST_entry is the class which defines the each row in a symbol table
*/
typedef union
{
	double d_value;
	unsigned int d_ar[2];

} d_util;

typedef struct
{
	double d_value;
	string name;
} init_double;

class ST_entry 
{
public:
	string name;				// name of symbol
	symbol_element_type *type;	// type of Symbol
	string init;				// symbol initialisation
	symbol_table* nest;			// pointer to nested symbol table, if any
	string mat_init;			// variable for initialing matrix variables
	string category;			// local, temp or global
	int size;					// Size of the type of symbol
	int offset;					// offset of symbol computed
	bool is_global;  			//to check if the it is global
	bool re_init;				//to chekc if the global variable is reinitialized locally
	vector< pair < string, int> > mat_init_row_list;
	int row_maj_index;
	vector < vector < pair <string , int > > > mat_init_col_list;
	vector < int > dims;
	/*
	ST_entry:	constructor creating a new symbol table entry
	input:		name , type , symbol element type , width of the variable
	return:		a new symbol table entry
	*/
	ST_entry (string, type_e t=_INT, symbol_element_type* ptr = NULL, int width = 0);

	/*
	update:	overloaded function for updating the symbol table entry using symbol element type and nested table pointer
	input:	symbol element type
	return: symbol table entry
	*/
	ST_entry* update(symbol_element_type * t); 	// Update using type object and nested table pointer

	/*
	update:	overloaded function for updating the symbol table entry using the enum type provided
	input:	enum type
	return:	symbol table entry
	*/
	ST_entry* update(type_e t);


	/*
	initialize():	function for setting the initial value of the symbol table entry
	input:		string which has the initial value of the variable
	output:		symbol table entry
	*/
	ST_entry* initialize (string);

	/*
	link_symbol_table():	function for linking a symbol table with a symbol table entry
	input:	a pointer to a symbol table
	return:	symbol table entry
	*/
	ST_entry* link_symbol_table(symbol_table* t);
};


/*********** Global Function Definitions *********/

ST_entry* gentemp ( string init = "",type_e t=_INT);					// Generate a temporary variable and insert it in symbol table
ST_entry* gentemp (string init = "",symbol_element_type* t=NULL);		// Generate a temporary variable and insert it in symbol table


void backpatch (list <int>, int);
void emit(opcode opL, string result, string arg1="", string arg2 = "");
void emit(opcode op, string result, int arg1, string arg2 = "");

list<int> makelist (int);							// Make a new list contaninig an integer
list<int> merge (list<int> &, list <int> &);		// Merge two lists

int get_type_size (symbol_element_type*);							// Calculate size of any type
string convert_to_string (const symbol_element_type*);			// For printing type structure
string return_op(int);

ST_entry* conv (ST_entry*, type_e);							// Convert symbol to different type
bool typecheck(ST_entry* &s1, ST_entry* &s2);					// Checks if two symbbol table entries have same type
bool typecheck(symbol_element_type* s1, symbol_element_type* s2);			// Check if the type objects are equivalent

int next_instruction();									// Returns the address of the next instruction
string num_to_string(int);							// Converts a number to string mainly used for storing numbers

void changeTable (symbol_table* newtable);

void print_table_helper(const ST_entry* it);
void quad_print_helper(string result, string arg1);
void quad_print_goto_helper(string arg2,string result);
void quad_print_if_helper(string arg1);
void nested_set_offset(list<symbol_table*>nested_list);

/*** Global variables declared in cxx file****/

extern symbol_table* table;			// Current Symbbol Table
extern symbol_table* gTable;			// Global Symbbol Table
extern quad_vector qarr;				// quad_vector
extern ST_entry* current_symbol;			// Pointer to just encountered symbol

/** Attributes for Boolean Expression***/

struct expr_struct 
{
	bool isbool;				// Boolean variable that stores if the expression is bool

	ST_entry* symp;						// Pointer to the symbol table entry

	list <int> truelist;				// Truelist valid for boolean
	list <int> falselist;				// Falselist valid for boolean expressions

	list <int> nextlist;
	vector < int > dims;
	
};
struct statement
{
	list <int> nextlist;				// nextlist for statement
};

struct unary_expr
{
	type_e cat;
	ST_entry* loc;					// temporary used for computing array address
	ST_entry* symp;					// pointer to symbol table
	symbol_element_type* type;		// type of the subarray generated
	bool start_trans;				//for indicating the start of a transpose operation
	vector < int > dims;
	list <int> t_list;
	list <int> f_list;
	list <int> n_list;
	bool bool_is;
};

// Utility functions
template <typename T> string tostr(const T& t) 
{
   ostringstream os;
   os<<t;
   return os.str();
}
symbol_element_type* copy_symbol_element_type(symbol_element_type* t1,symbol_element_type* t2);
string char_quote(char c);
void not_eq_handler(expr_struct* e0,expr_struct* e1,expr_struct* e3);
void eq_cmp_handler(expr_struct* e0,expr_struct* e1,expr_struct* e3);
void less_than_handler(expr_struct* e0, expr_struct* e1 , expr_struct* e3);
void greater_than_handler(expr_struct* e0, expr_struct* e1 , expr_struct* e3);
void less_equal_handler(expr_struct* e0,expr_struct* e1,expr_struct* e3);
void great_equal_handler(expr_struct* e0,expr_struct* e1,expr_struct* e3);
void debugger( string prompt);
expr_struct* convert_to_bool (expr_struct*);				// convert any expression to bool
expr_struct* convert_from_bool (expr_struct*);			// convert bool to expression
void if_handler(statement* , expr_struct* , int , statement* , expr_struct*);
void if_else_handler(statement* ,expr_struct* , int , statement* , expr_struct* ,int ,statement* );
void while_handler(statement* s0 , int i2 , expr_struct* e4 , int i6 , statement * s7);
void do_while_handler(statement* s0 ,int i2,statement* s3,int i4,expr_struct* e7);				// handles do while loops in parser
void for1_handler(statement* s0,int i4, expr_struct* e5,int i7,statement* s8);
void for2_handler(statement* s0 ,int i4,expr_struct* e5, int i6, expr_struct* e8, int i10,statement* s11);
statement* prop_stat(statement* s1, statement* s2); 	//for propagating statement pointers
unary_expr* prop_unary (unary_expr* u1, unary_expr* u2);		// for propagating unary pointer in bison rules, created for easy understanding
expr_struct* prop_expression(expr_struct* e1 ,expr_struct* e2);	// for propagating expression pointers in bison rules 
#endif
