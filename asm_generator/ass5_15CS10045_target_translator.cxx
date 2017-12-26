#include "ass5_15CS10045_translator.h"
#include <iostream>
#include <cstring>
#include <string>
#include <stdint.h>

extern FILE *yyin;
extern vector<string> allstrings;
extern vector<init_double> alldoubles;

using namespace std;

int labelCount=0;							// Label count in asm file
std::map<int, int> labelMap;				// map from quad number to label number
//ofstream out;								// asm file stream
//ofstream out;

vector <quad> array;						// quad array
string asmfilename="ass5_15CS10045_";		// asm file name
string inputfile="ass5_15CS10045_test";		// input file name

ofstream asmfile;



void computeActivationRecord(symbol_table* st) 
{
	int param = -20;
	int local = -24;
	AR(st, param ,local);

}





void genasm() 
{
	array = qarr.array;

	for (vector<quad>::iterator it = array.begin(); it!=array.end(); it++) 
	{
		int i;
		if (it->op==GOTOOP || it->op==LT || it->op==GT || it->op==LE || it->op==GE || it->op==EQOP || it->op==NOT_EQ_OP) 
		{
			i = atoi(it->result.c_str());
			labelMap [i] = 1;
		}
	}

	int count = 0;

	
	for (std::map<int,int>::iterator it=labelMap.begin();it!=labelMap.end();)
	{

		it->second = count++;
		it++;
	}
	
	list<symbol_table*> tablelist;

	list <ST_entry>::iterator itn = gTable->table.begin();
	while( itn!=gTable->table.end()) 
	{
		if (itn->nest!=NULL) 
		{
			tablelist.push_back (itn->nest);
		}
		itn++;
	}

	for (list<symbol_table*>::iterator iterator = tablelist.begin();iterator != tablelist.end(); ++iterator) 
	{
		computeActivationRecord(*iterator);
	}

	//asmfile
	
	asmfile << "\t.file	\"test.mm\"\n";

	int global_double_count=0;
	for (list <ST_entry>::iterator it = table->table.begin(); it!=table->table.end();) 
	{
		if (it->category!="function") 
		{
			if (it->type->cat==_CHAR) 
			{ // Global char
				if (it->init!="") 
				{
					asmfile << "\t.globl\t" << it->name << "\n";
					asmfile << "\t.type\t" << it->name << ", @object\n";
					asmfile << "\t.size\t" << it->name << ", 1\n";
					asmfile << it->name <<":\n";
					asmfile << "\t.byte\t" << atoi( it->init.c_str()) << "\n";
					it->is_global=true;
				}
				else 
				{
					asmfile << "\t.comm\t" << it->name << ",1,1\n";
				}
			}
			else if (it->type->cat==_INT) 
			{ // Global int
				if (it->init!="") 
				{
					asmfile << "\t.globl\t" << it->name << "\n";
					asmfile << "\t.data\n";
					asmfile << "\t.align 4\n";
					asmfile << "\t.type\t" << it->name << ", @object\n";
					asmfile << "\t.size\t" << it->name << ", 4\n";
					asmfile << it->name <<":\n";
					asmfile << "\t.long\t" << it->init << "\n";
					it->is_global=true;
				}
				else 
				{
					asmfile << "\t.comm\t" << it->name << ",4,4\n";
				}

			}
			else if (it->type->cat==_DOUBLE) 
			{ // Global double
				if (it->init!="") 
				{
					asmfile << "\t.globl\t" << it->name << "\n";
					asmfile << "\t.data\n";
					asmfile << "\t.align 8\n";
					asmfile << "\t.type\t" << it->name << ", @object\n";
					asmfile << "\t.size\t" << it->name << ", 8\n";
					asmfile << it->name <<":\n";
					double d_tmp = atof(it->init.c_str());
					d_util d_bytes;
					d_bytes.d_value=d_tmp;

					//uint32_t d_lower,d_upper;
					//memcpy(&d_upper, &d_tmp, sizeof(d_tmp)/2);
					//d_tmp=d_tmp<<32;
					//memcpy(&d_lower, (&d_tmp), sizeof(d_tmp)/2);
					asmfile << "\t.long\t" << d_bytes.d_ar[0] << "\n";
					asmfile << "\t.long\t" << d_bytes.d_ar[1] << "\n";
					it->is_global=true;

					global_double_count++;
				}
				else 
				{
					asmfile << "\t.comm\t" << it->name << ",4,4\n";
				}

			}
			
		}

		it++;
	}
	global_double_count=global_double_count/2;
	if (allstrings.size()+alldoubles.size()-global_double_count) 
	{
		asmfile << "\t.section\t.rodata\n";
		for (vector<string>::iterator it = allstrings.begin(); it!=allstrings.end(); it++) 
		{

			asmfile << ".LC" << it - allstrings.begin() << ":\n";
			asmfile << "\t.string\t" << *it << "\n";	
		}
		vector<init_double>::iterator it2 = alldoubles.begin();
		it2 +=global_double_count;
		for(;it2!=alldoubles.end();it2++)
		{
			//if(!it->is_global)
			//{
				asmfile << "\t.align 8" << endl;
				asmfile << ".LC" << it2->name << ":\n";
				d_util d_bytes;
				d_bytes.d_value=it2->d_value;
				asmfile << "\t.long\t" << d_bytes.d_ar[0] << "\n";
				asmfile << "\t.long\t" << d_bytes.d_ar[1] << "\n";
			//}
		}
	}

	asmfile << "\t.text	\n";

	vector<string> params;

	std::map<string, int> theMap;

	for (vector<quad>::iterator it = array.begin(); it!=array.end(); it++) 
	{
		for(;labelMap.count(it - array.begin());) 
		{
			asmfile << ".L" << (2*labelCount+labelMap.at(it - array.begin()) + 2 )<< ": " << endl;
			break;
		}

		opcode op = it->op;
		string result = it->result;
		string arg1 = it->arg1;
		string arg2 = it->arg2;
		string s=arg2;

		if(op==PARAM)
		{
			params.push_back(result);
		}
		else 
		{
			asmfile << "\t";
			// Binary Operations
			if (op==ADD) 
			{
				bool flag=true;
				if(s.empty() || ((!isdigit(s[0])) && (s[0] != '-') && (s[0] != '+')))
					flag=false ;
				else
				{
					char * p ;
					strtol(s.c_str(), &p, 10) ;
					if(*p == 0) flag=true ;
					else flag=false;
				}
				if (flag) 
				{
					asmfile << "\tmovl\t" << table->ar[arg1] <<"(%rbp), %eax " << endl;
					asmfile << "\taddl \t$" << atoi(arg2.c_str()) << ", %eax" << endl;
					asmfile << "\tmovl\t%eax, " << table->ar[result] << "(%rbp)" << endl;
				}
				else 
				{
					if(table->lookup(arg1)->type->cat==MAT) //case like t1=m+t2 //doesn't calculated the address, just assigns t1=t2
					{
						//asmfile << "leaq\t" << table->ar[arg1] << "(%rbp), " << "%rax" << endl;
						asmfile << "\tmovl\t" << table->ar[arg2] << "(%rbp), " << "%eax" << endl;
						//asmfile << "\taddq\t%rdx, %rax"<<endl;
						asmfile << "\tmovl\t%eax, " << table->ar[result] << "(%rbp)" <<endl;
					}
					else if(table->lookup(arg1)->type->cat==_DOUBLE && table->lookup(arg2)->type->cat==_DOUBLE)
					{
						asmfile << "\tmovsd\t" << table->ar[arg1] << "(%rbp), %xmm0" << endl;
						asmfile << "\tmovsd\t" << table->ar[arg2] << "(%rbp), %xmm1" << endl;
						asmfile << "\taddsd\t%xmm0, %xmm1" <<endl;
						asmfile << "\tmovsd\t%xmm1, " << table->ar[result] << "(%rbp)" <<endl;
					}
					else
					{
						asmfile << "movl \t" << table->ar[arg1] << "(%rbp), " << "%eax" << endl;
						asmfile << "\tmovl \t" << table->ar[arg2] << "(%rbp), " << "%edx" << endl;
						asmfile << "\taddl \t%edx, %eax\n";
						asmfile << "\tmovl \t%eax, " << table->ar[result] << "(%rbp)";
					}
				}
			}
			else if(op==SUB) 
			{
				// target_sub_handler(table, result, arg1, arg2);

				if(table->lookup(arg1)->type->cat==_DOUBLE && table->lookup(arg2)->type->cat==_DOUBLE)
					{
						asmfile << "\tmovsd\t" << table->ar[arg1] << "(%rbp), %xmm1" << endl;
						asmfile << "\tmovsd\t" << table->ar[arg2] << "(%rbp), %xmm0" << endl;
						asmfile << "\tsubsd\t%xmm0, %xmm1" <<endl;
						asmfile << "\tmovsd\t%xmm1, " << table->ar[result] << "(%rbp)" <<endl;
					}
				else
				{
					asmfile << "movl \t" << table->ar[arg1] << "(%rbp), " << "%eax" << endl;
					asmfile << "\tmovl \t" << table->ar[arg2] << "(%rbp), " << "%edx" << endl;
					asmfile << "\tsubl \t%edx, %eax\n";
					asmfile << "\tmovl \t%eax, " << table->ar[result] << "(%rbp)";
				}
			}
			else if(op==MULT) 
			{
				if(table->lookup(arg1)->type->cat==_DOUBLE && table->lookup(arg2)->type->cat==_DOUBLE)
					{
						asmfile << "\tmovsd\t" << table->ar[arg1] << "(%rbp), %xmm0" << endl;
						asmfile << "\tmovsd\t" << table->ar[arg2] << "(%rbp), %xmm1" << endl;
						asmfile << "\tmulsd\t%xmm0, %xmm1" <<endl;
						asmfile << "\tmovsd\t%xmm1, " << table->ar[result] << "(%rbp)" <<endl;
					}
				else
					{
						asmfile << "movl \t" << table->ar[arg1] << "(%rbp), " << "%eax" << endl;
						bool flag=true;
						if(s.empty() || ((!isdigit(s[0])) && (s[0] != '-') && (s[0] != '+'))) flag=false ;
						else
						{
							char * p ;
							strtol(s.c_str(), &p, 10) ;
							if(*p == 0) flag=true ;
							else flag=false;
						}
						if(flag) 
						{
							asmfile << "\timull \t$" << atoi(arg2.c_str()) << ", " << "%eax" << endl;
							symbol_table* t = table;
							string val;
							for (list <ST_entry>::iterator it = t->table.begin(); it!=t->table.end(); it++) 
							{
								if(it->name==arg1) val=it->init; 
							}
							theMap[result]=atoi(arg2.c_str())*atoi(val.c_str());
						}
						else 
							asmfile << "\timull \t" << table->ar[arg2] << "(%rbp), " << "%eax" << endl;
						asmfile << "\tmovl \t%eax, " << table->ar[result] << "(%rbp)";			
					}
			}
			else if(op==DIVIDE) 
			{

				if(table->lookup(arg1)->type->cat==_DOUBLE && table->lookup(arg2)->type->cat==_DOUBLE)
					{
						asmfile << "\tmovsd\t" << table->ar[arg1] << "(%rbp), %xmm0" << endl;
						asmfile << "\tmovsd\t" << table->ar[arg2] << "(%rbp), %xmm1" << endl;
						asmfile << "\tdivsd\t%xmm0, %xmm1" <<endl;
						asmfile << "\tmovsd\t%xmm1, " << table->ar[result] << "(%rbp)" <<endl;
					}
				else
					{
						asmfile << "movl \t" << table->ar[arg1] << "(%rbp), " << "%eax" << endl;
						asmfile << "\tcltd" << endl;
						asmfile << "\tidivl \t" << table->ar[arg2] << "(%rbp)" << endl;
						asmfile << "\tmovl \t%eax, " << table->ar[result] << "(%rbp)";		
					}
			}

			// Bit Operators /* Ignored */
			else if (op==MODOP)		
				asmfile << result << " = " << arg1 << " % " << arg2;
			else if (op==XOR)			
				asmfile << result << " = " << arg1 << " ^ " << arg2;
			else if (op==INOR)		
				asmfile << result << " = " << arg1 << " | " << arg2;
			else if (op==BAND)		
				asmfile << result << " = " << arg1 << " & " << arg2;
			// Shift Operations /* Ignored */
			else if (op==LEFTOP)		
				asmfile << result << " = " << arg1 << " << " << arg2;
			else if (op==RIGHTOP)		
				asmfile << result << " = " << arg1 << " >> " << arg2;
			else if (op==TRANSPOSE)
			{
				int m_row=table->lookup(arg1)->type->width;
				int m_col = table->lookup(arg1)->type->ptr->width;

				for(int ii=0; ii< m_row ; ii++)
				{
					for(int jj=0; jj < m_col ; jj++)
					{
						cout << "m_row=" << m_row << endl;
						cout << "m_col=" << m_col << endl;
						cout << "ii=" << ii << "jj=" << jj << endl;
						cout << "jj*m_row+ii=" << (jj*m_row + ii)*8 << "ii*m_col + jj=" << (ii*m_col + jj)*8 << endl; 
						//asmfile << "\tmovq\t" << table->ar[arg1] + (jj*m_row + ii)*8 << ", %rax" <<endl;
						//asmfile << "\tmovq\t%rax, " << table->ar[result] + ii*m_col*8 + jj*8 << endl;
					}
				}
			}
			else if (op==EQUAL)	
			{
				if(table->lookup(arg1)->type->cat==MAT && table->lookup(result)->type->cat==MAT)
				{

					if(table->lookup(result)->size > table->lookup(arg1)->size)
					{
						table->lookup(arg1)->size = table->lookup(result)->size;
					}
					else if(table->lookup(result)->size < table->lookup(arg1)->size)
					{
						table->lookup(result)->size = table->lookup(arg1)->size;
					}
					for(int ii=0;ii<max(table->lookup(result)->size,table->lookup(arg1)->size);ii+=8)
					{
						asmfile <<"\tmovq\t" << table->ar[arg1]+ii << "(%rbp), %rax" << endl;
						asmfile <<"\tmovq\t" << "%rax, " << table->ar[result]+ii << "(%rbp)" <<endl;
					}
				}
				else
				{
						s=arg1;
						bool flag=true;
						if(s.empty() || ((!isdigit(s[0])) && (s[0] != '-') && (s[0] != '+'))) 
							flag=false ;
						else
						{
							char * p ;
							strtol(s.c_str(), &p, 10) ;
							for(;*p == 0;)
							{
								flag=true ;
								break;
							}
							if (*p!=0)
								flag=false;
						}
						if(flag)
						{
							asmfile << "movl\t$" << atoi(arg1.c_str()) << ", " << "%eax" << endl;
							asmfile << "\tmovl\t%eax, " << table->ar[result] << "(%rbp)" << endl;
						}
						else
						{
							for(;table->lookup(result)->type->cat==PTR;)
							{
								if(table->lookup(result)->type->ptr!=NULL && table->lookup(result)->type->ptr->cat==_CHAR)
								{
									asmfile << "movq\t" << table->ar[arg1] << "(%rbp), " << "%rax" << endl;		
									asmfile << "\tmovq\t%rax, " << table->ar[result] << "(%rbp)"<<endl;
								}
								else
								{
									asmfile << "movl\t" << table->ar[arg1] << "(%rbp), " << "%eax" << endl;
									asmfile << "\tmovl\t%eax, " << table->ar[result] << "(%rbp)"<<endl;
								}
								break;
							}
							if(table->lookup(result)->type->cat==_DOUBLE)
							{
								asmfile << "movq\t" << table->ar[arg1] << "(%rbp), " << "%rax" << endl;		
								asmfile << "\tmovq\t%rax, " << table->ar[result] << "(%rbp)"<<endl;
							}
							else
							{
								asmfile << "movl\t" << table->ar[arg1] << "(%rbp), " << "%eax" << endl;
								asmfile << "\tmovl\t%eax, " << table->ar[result] << "(%rbp)"<<endl;
							}
						}

						//asmfile << "\tmovq\t%rax, " << table->ar[result] << "(%rbp)"<<endl;
						if((gTable->search(result) && gTable->lookup(result)->is_global))
						{
							asmfile << "\tmovq\t%rax, " << result << "(%rip)";
							gTable->lookup(result)->re_init=true;
						}
						// else if(( table->search(result) && table->lookup(result)->init!=""))
						// {
						// 	cout<<"bb2"<<endl;
						// 	asmfile << "\tmovq\t%rax, " << table->ar[result] << "(%rip)";				
						// }
				}
			}	
			else if(op==ZERO_DOUBLE)
			{
				asmfile << "movq\t$0, " << table->ar[result] << "(%rbp)" << endl;
			}	
			else if(op==EQUAL_DOUBLE)
			{
				if(gTable->search(result) && gTable->lookup(result)->is_global)
				{
					asmfile << "movq\t" << result << "(%rip), " << "%rax" << endl;
					asmfile << "\tmovq \t%rax, " << table->ar[result] << "(%rbp)";
				}
				else
				{
					asmfile << "movq\t" <<".LC"<< result << "(%rip), " << "%rax" << endl;
					asmfile << "\tmovq \t%rax, " << table->ar[result] << "(%rbp)";
				}
				//asmfile << "movq \t$.LC" << arg1 << ", " << table->ar[result] << "(%rbp)";
			}	
			else if (op==EQUALSTR)	
			{
				asmfile << "movq \t$.LC" << arg1 << ", " << table->ar[result] << "(%rbp)";
			}
			else if (op==EQUALCHAR)	
			{
				asmfile << "movb\t$" << atoi(arg1.c_str()) << ", " << table->ar[result] << "(%rbp)";
			}					
			// Relational Operations
			else if (op==EQOP) 
			{
				asmfile << "movl\t" << table->ar[arg1] << "(%rbp), %eax\n";
				asmfile << "\tcmpl\t" << table->ar[arg2] << "(%rbp), %eax\n";
				asmfile << "\tje .L" << (2*labelCount+labelMap.at(atoi( result.c_str() )) +2 );
			}
			else if (op==NOT_EQ_OP) 
			{
				asmfile << "movl\t" << table->ar[arg1] << "(%rbp), %eax\n";
				asmfile << "\tcmpl\t" << table->ar[arg2] << "(%rbp), %eax\n";
				asmfile << "\tjne .L" << (2*labelCount+labelMap.at(atoi( result.c_str() )) +2 );
			}
			else if (op==LT) 
			{
				asmfile << "movl\t" << table->ar[arg1] << "(%rbp), %eax\n";
				asmfile << "\tcmpl\t" << table->ar[arg2] << "(%rbp), %eax\n";
				asmfile << "\tjl .L" << (2*labelCount+labelMap.at(atoi( result.c_str() )) +2 );
			}
			else if (op==GT) 
			{
				asmfile << "movl\t" << table->ar[arg1] << "(%rbp), %eax\n";
				asmfile << "\tcmpl\t" << table->ar[arg2] << "(%rbp), %eax\n";
				asmfile << "\tjg .L" << (2*labelCount+labelMap.at(atoi( result.c_str() )) +2 );
			}
			else if (op==GE) 
			{
				asmfile << "movl\t" << table->ar[arg1] << "(%rbp), %eax\n";
				asmfile << "\tcmpl\t" << table->ar[arg2] << "(%rbp), %eax\n";
				asmfile << "\tjge .L" << (2*labelCount+labelMap.at(atoi( result.c_str() )) +2 );
			}
			else if (op==LE) 
			{
				asmfile << "movl\t" << table->ar[arg1] << "(%rbp), %eax\n";
				asmfile << "\tcmpl\t" << table->ar[arg2] << "(%rbp), %eax\n";
				asmfile << "\tjle .L" << (2*labelCount+labelMap.at(atoi( result.c_str() )) +2 );
			}
			else if (op==GOTOOP) 
			{
				asmfile << "jmp .L" << (2*labelCount+labelMap.at(atoi( result.c_str() )) +2 );
			}
			// Unary Operators
			else if (op==ADDRESS) 
			{
				asmfile << "leaq\t" << table->ar[arg1] << "(%rbp), %rax\n";
				asmfile << "\tmovq \t%rax, " <<  table->ar[result] << "(%rbp)";
			}
			else if (op==PTRR) 
			{
				asmfile << "movl\t" << table->ar[arg1] << "(%rbp), %eax\n";
				asmfile << "\tmovl\t(%eax),%eax\n";
				asmfile << "\tmovl \t%eax, " <<  table->ar[result] << "(%rbp)";	
			}
			else if (op==PTRL) 
			{
				asmfile << "movl\t" << table->ar[result] << "(%rbp), %eax\n";
				asmfile << "\tmovl\t" << table->ar[arg1] << "(%rbp), %edx\n";
				asmfile << "\tmovl\t%edx, (%eax)";
			} 			
			else if (op==UMINUS) 
			{
				asmfile << "negl\t" << table->ar[arg1] << "(%rbp)";
			}
			else if (op==BNOT)		
				asmfile << result 	<< " = ~" << arg1;
			else if (op==LNOT)			
				asmfile << result 	<< " = !" << arg1;
			else if (op==ARRR) 
			{
				int off=0;
				off=theMap[arg2]*(-1)+table->ar[arg1];
//				asmfile << "movq\t" << table->ar[arg2] << "(%rbp), "<<"%rax" << endl;
				asmfile << "leaq\t" << table->ar[arg1] << "(%rbp), " << "%rdx" << endl;
				asmfile << "\tmovl\t" << table->ar[arg2] << "(%rbp), %eax" << endl;
				asmfile << "\tmovq\t(%rdx,%rax), %rax" <<endl;
				asmfile << "\tmovq\t%rax, " << table->ar[result] <<"(%rbp)"<<endl;

				//asmfile << "movq\t" << off << "(%rbp), "<<"%rax" << endl;
				//asmfile << "\tmovq \t%rax, " <<  table->ar[result] << "(%rbp)";
			}	 			
			else if (op==ARRL) 
			{
				int off=0;
				off=theMap[arg1]*(-1)+table->ar[result];
				//asmfile << "leaq\t" << table->ar[result] << "(%rbp)" << ", %r12" << endl;
				//asmfile << ""
				asmfile << "movl\t" << table->ar[arg1] << "(%rbp), "<<"%eax" << endl;
				asmfile << "\tleaq\t" << table->ar[result] << "(%rbp), " << "%rdx" << endl;
				asmfile << "\tleaq\t(%rdx,%rax), %rax" << endl;
				asmfile << "\tmovq\t" << table->ar[arg2] << "(%rbp), %rdx" << endl;
				asmfile << "\tmovq\t%rdx, (%rax)" <<endl;
				//asmfile << "movq\t" << table->ar[arg2] << "(%rbp), " <<"%rdx" << endl;
				//asmfile << "\tmovq\t" << "%rdx, " << off << "(%rbp)";
			}
			else if (op==ARRR_I) 
			{
				
//				asmfile << "movq\t" << table->ar[arg2] << "(%rbp), "<<"%rax" << endl;
				asmfile << "leaq\t" << table->ar[arg1] << "(%rbp), " << "%rdx" << endl;
				asmfile << "\tmovl\t$" << arg2 << ", %eax" << endl;
				asmfile << "\tmovq\t(%rdx,%rax), %rax" <<endl;
				asmfile << "\tmovq\t%rax, " << table->ar[result] <<"(%rbp)"<<endl;

				//asmfile << "movq\t" << off << "(%rbp), "<<"%rax" << endl;
				//asmfile << "\tmovq \t%rax, " <<  table->ar[result] << "(%rbp)";
			}	 			
			else if (op==ARRL_I) 
			{
				//asmfile << "leaq\t" << table->ar[result] << "(%rbp)" << ", %r12" << endl;
				//asmfile << ""
				//asmfile << "movl\t" << table->ar[arg1] << "(%rbp), "<<"%eax" << endl;
				asmfile << "movl\t$" << arg1 << ", %eax" <<endl;
				asmfile << "\tleaq\t" << table->ar[result] << "(%rbp), " << "%rdx" << endl;
				asmfile << "\tleaq\t(%rdx,%rax), %rax" << endl;
				asmfile << "\tmovq\t" << table->ar[arg2] << "(%rbp), %rdx" << endl;
				asmfile << "\tmovq\t%rdx, (%rax)" <<endl;
				//asmfile << "movq\t" << table->ar[arg2] << "(%rbp), " <<"%rdx" << endl;
				//asmfile << "\tmovq\t" << "%rdx, " << off << "(%rbp)";
			}	
			else if(op==INIT_MAT)
			{
				asmfile << "movq\t" << table->ar[arg2] << "(%rbp), %rdx" << endl;
				asmfile << "\tmovq\t%rdx, " << table->ar[result]+atoi(arg1.c_str()) << "(%rbp)" << endl;
			} 
			else if (op==_RETURN) 
			{
				if(result!="") 
					asmfile << "movl\t" << table->ar[result] << "(%rbp), "<<"%eax";
				else 
					asmfile << "nop";
			}
			else if (op==PARAM) 
			{
				params.push_back(result);
			}
			else if (op==CALL) 
			{
				// Function Table
				symbol_table* t = gTable->lookup(arg1)->nest;
				int i,j=0;	// index
				for (list <ST_entry>::iterator it = t->table.begin(); it!=t->table.end(); it++) 
				{
					i = distance ( t->table.begin(), it);

					if (it->category== "param") 
					{
						if(j==0) 
						{
							if(table->search(params[i]) && table->lookup(params[i])->type->cat==_DOUBLE)
							{
								asmfile << "movl \t" << table->ar[params[i]] << "(%rbp), " << "%eax" << endl;
								asmfile << "\tmovsd \t" << table->ar[params[i]] << "(%rbp), " << "%xmm0" << endl;
								asmfile << "\tcvtsd2ss\t" << "%xmm0, " << "%xmm0" <<endl;
								//asmfile << "\tmovss\t" << "%xmm0, " << "%xmm0" <<endl;
								
							}
							else if(table->lookup(params[i])->category=="temp" && table->search(params[i]) && table->lookup(params[i])->type->cat==PTR)
							{
								///cout<<"here"<<endl;
								asmfile << "movl \t" << table->ar[params[i]] << "(%rbp), " << "%eax" << endl;
								asmfile << "\tmovq \t" << table->ar[params[i]] << "(%rbp), " << "%rdi" << endl;	
							}
							else if(gTable->lookup(params[i])->is_global && gTable->lookup(params[i])->type->cat==_INT)
							{
								asmfile << "movl \t" << table->ar[params[i]] << "(%rbp), " << "%eax" << endl;
								asmfile << "\tmovl \t" << params[i] << "(%rip), " << "%edi" << endl; 
							}
							else if(gTable->lookup(params[i])->is_global && gTable->lookup(params[i])->type->cat==_DOUBLE)
							{
								asmfile << "movl \t" << table->ar[params[i]] << "(%rbp), " << "%eax" << endl;
								asmfile << "\tmovsd \t" << params[i] << "(%rip), " << "%xmm0" << endl;
								asmfile << "\tcvtsd2ss\t" << "%xmm0, " << "%xmm0" <<endl;
							}
							else
							{
								asmfile << "movl \t" << table->ar[params[i]] << "(%rbp), " << "%eax" << endl;
								asmfile << "\tmovq \t" << table->ar[params[i]] << "(%rbp), " << "%rdi" << endl;
							}			
							//asmfile << "\tmovl \t%eax, " << (t->ar[it->name]-8 )<< "(%rsp)\n\t";
							j++;
						}
						else if(j==1) 
						{
							if(table->search(params[i]) && table->lookup(params[i])->type->cat==PTR)
							{
								asmfile << "movl \t" << table->ar[params[i]] << "(%rbp), " << "%eax" << endl;
								asmfile << "\tmovq \t" << table->ar[params[i]] << "(%rbp), " << "%rsi" << endl;	
							}
							else if(gTable->lookup(params[i])->is_global && gTable->lookup(params[i])->type->cat==_INT)
							{
								asmfile << "movl \t" << table->ar[params[i]] << "(%rbp), " << "%eax" << endl;
								asmfile << "\tmovq \t" << params[i] << "(%rip), " << "%rsi" << endl; 
							}
							else if(gTable->lookup(params[i])->is_global && gTable->lookup(params[i])->type->cat==_DOUBLE)
							{
								asmfile << "movl \t" << table->ar[params[i]] << "(%rbp), " << "%eax" << endl;
								asmfile << "\tmovsd \t" << params[i] << "(%rip), " << "%xmm1" << endl;
								asmfile << "\tcvtsd2ss\t" << "%xmm1, " << "%xmm1" <<endl;

							}
							else
							{
							asmfile << "movl \t" << table->ar[params[i]] << "(%rbp), " << "%eax" << endl;
							asmfile << "\tmovq \t" << table->ar[params[i]] << "(%rbp), " << "%rsi" << endl;
							}
							//asmfile << "\tmovl \t%eax, " << (t->ar[it->name]-8 )<< "(%rsp)\n\t";
							j++;
						}
						else if(j==2) 
						{
							if(table->search(params[i]) && table->lookup(params[i])->type->cat==PTR)
							{
								asmfile << "movl \t" << table->ar[params[i]] << "(%rbp), " << "%eax" << endl;
								asmfile << "\tmovq \t" << table->ar[params[i]] << "(%rbp), " << "%rdx" << endl;	
							}
							else if(gTable->lookup(params[i])->is_global && gTable->lookup(params[i])->type->cat==_INT)
							{
								asmfile << "movl \t" << table->ar[params[i]] << "(%rbp), " << "%eax" << endl;
								asmfile << "\tmovq \t" << params[i] << "(%rip), " << "%rdx" << endl; 
							}
							else if(gTable->lookup(params[i])->is_global && gTable->lookup(params[i])->type->cat==_DOUBLE)
							{
								asmfile << "movl \t" << table->ar[params[i]] << "(%rbp), " << "%eax" << endl;
								asmfile << "\tmovsd \t" << params[i] << "(%rip), " << "%xmm2" << endl;
								asmfile << "\tcvtsd2ss\t" << "%xmm2, " << "%xmm2" <<endl;

							}
							else
							{
								asmfile << "movl \t" << table->ar[params[i]] << "(%rbp), " << "%eax" << endl;
								asmfile << "\tmovq \t" << table->ar[params[i]] << "(%rbp), " << "%rdx" << endl;
							}
							//asmfile << "\tmovl \t%eax, " << (t->ar[it->name]-8 )<< "(%rsp)\n\t";
							j++;
						}
						else if(j==3) 
						{
							asmfile << "movl \t" << table->ar[params[i]] << "(%rbp), " << "%eax" << endl;
							asmfile << "\tmovq \t" << table->ar[params[i]] << "(%rbp), " << "%rcx" << endl;
							//asmfile << "\tmovl \t%eax, " << (t->ar[it->name]-8 )<< "(%rsp)\n\t";
							j++;
						}
						else 
						{
							asmfile << "\tmovq \t" << table->ar[params[i]] << "(%rbp), " << "%rdi" << endl;							
						}
					}
					else 
						break;
				}
				params.clear();
				asmfile << "\tcall\t"<< arg1 << endl;
				asmfile << "\tmovl\t%eax, " << table->ar[result] << "(%rbp)";
			}
			else if (op==FUNC) 
			{
				
				asmfile <<".globl\t" << result << "\n";
				asmfile << "\t.type\t"	<< result << ", @function\n";
				asmfile << result << ": \n";
				asmfile << ".LFB" << labelCount <<":" << endl;
				asmfile << "\t.cfi_startproc" << endl;
				asmfile << "\tpushq \t%rbp" << endl;
				asmfile << "\t.cfi_def_cfa_offset 8" << endl;
				asmfile << "\t.cfi_offset 5, -8" << endl;
				asmfile << "\tmovq \t%rsp, %rbp" << endl;
				asmfile << "\t.cfi_def_cfa_register 5" << endl;
				table = gTable->lookup(result)->nest;
				asmfile << "\tsubq\t$" << table->table.back().offset+24 << ", %rsp"<<endl;
				

				symbol_table* t = table;
				int i=0;
				for (list <ST_entry>::iterator it = t->table.begin(); it!=t->table.end(); it++) 
				{
					if (it->category== "param") 
					{
						if (i==0) 
						{
							asmfile << "\tmovq\t%rdi, " << table->ar[it->name] << "(%rbp)";
							i++;
						}
						else if(i==1) 
						{
							asmfile << "\n\tmovq\t%rsi, " << table->ar[it->name] << "(%rbp)";
							i++;
						}
						else if (i==2) 
						{
							asmfile << "\n\tmovq\t%rdx, " << table->ar[it->name] << "(%rbp)";
							i++;
						}
						else if(i==3) 
						{
							asmfile << "\n\tmovq\t%rcx, " << table->ar[it->name] << "(%rbp)";
							i++;
						}
					}
					else break;
				}
			}		
			else if (op==FUNCEND) 
			{
				asmfile << "leave\n";
				asmfile << "\t.cfi_restore 5\n";
				asmfile << "\t.cfi_def_cfa 4, 4\n";
				asmfile << "\tret\n";
				asmfile << "\t.cfi_endproc" << endl;
				asmfile << ".LFE" << labelCount++ <<":" << endl;
				asmfile << "\t.size\t"<< result << ", .-" << result;
			}
			else asmfile << "op";
			asmfile << endl;
		}
	}
	asmfile << 	"\t.ident\t	\"Compiled by 15CS10045 - swastik\"\n";
	asmfile << 	"\t.section\t.note.GNU-stack,\"\",@progbits\n";
	asmfile.close();
}


template<class T>
ostream& operator<<(ostream& os, const vector<T>& v)
{
	copy(v.begin(), v.end(), ostream_iterator<T>(os, " ")); 
	return os;
}

int main(int ac, char* av[]) 
{
	inputfile=inputfile+string(av[ac-1])+string(".mm");
	asmfilename=asmfilename+string(av[ac-1])+string(".s");
	gTable = new symbol_table("Global");
	table = gTable;
	yyin = fopen(inputfile.c_str(),"r"); 
	yyparse();
	gTable->offset_set();
	gTable->print(1);
	qarr.print();
	qarr.print_quad_array();
	asmfile.open(asmfilename.c_str());
	genasm();
}