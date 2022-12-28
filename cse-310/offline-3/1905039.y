%{
#include <iostream>
#include <fstream>
#include <cstdlib>
#include <cstring>
#include <cmath>
#include <stack>
#include "1905039_SymbolTable.h"
#include "1905039_ParseTreeNode.h"

using namespace std;

SymbolTable *st;
// int yyparse(void);
int yylex(void);
extern FILE *yyin;
extern FILE *tokenout;
extern FILE *logout;

size_t depth = 0;

void yyerror(char *s)
{
	//write your code
}

std::stack<ParseTreeNode> parseTreeStack;

void PrintParseTree(ParseTreeNode &parseTreeNode, size_t depth)
{
	if(!parseTreeNode.terminal)
	{
		for(size_t i = 0; i < depth; ++i)
		{
			std::cout << ' ';
		}

		std::cout << parseTreeNode.name << " : ";

		for(size_t i = 0; i < parseTreeNode.children.size(); ++i)
		{
			std::cout << parseTreeNode.children[i].name << ' ';
		}

		std::cout << std::endl;

		for(size_t i = 0; i < parseTreeNode.children.size(); ++i)
		{
			PrintParseTree(parseTreeNode.children[i], depth + 1);
		}
	}
}

%}

%code requires
{
	#include "1905039_SymbolTable.h"
	#define YYSTYPE SymbolInfo*
}

%token IF ELSE FOR WHILE DO BREAK INT CHAR FLOAT DOUBLE VOID RETURN SWITCH CASE DEFAULT CONTINUE ADDOP MULOP INCOP RELOP ASSIGNOP LOGICOP BITOP NOT LPAREN RPAREN LCURL RCURL LSQUARE RSQUARE COMMA SEMICOLON CONST_INT CONST_FLOAT CONST_CHAR CONST_STRING ID

%%

start   :   program
	    {
			ParseTreeNode program_node = parseTreeStack.top();

			parseTreeStack.pop();

			ParseTreeNode start_node = {"start", false, {program_node}};

			parseTreeStack.push(start_node);
		}
	    ;

program :   program unit
        {
            ParseTreeNode unit_node = parseTreeStack.top();

			parseTreeStack.pop();

			ParseTreeNode program_node_child = parseTreeStack.top();

			parseTreeStack.pop();

			ParseTreeNode program_node = {"program", false, {program_node_child, unit_node}};

			parseTreeStack.push(program_node);
        }
	    |   unit
        {
            ParseTreeNode unit_node = parseTreeStack.top();

			parseTreeStack.pop();

			ParseTreeNode program_node = {"program", false, {unit_node}};

			parseTreeStack.push(program_node);
        }
	    ;
	
unit    :   var_declaration
		{
			ParseTreeNode var_declaration_node = parseTreeStack.top();

			parseTreeStack.pop();

			ParseTreeNode unit_node = {"unit", false, {var_declaration_node}};

			parseTreeStack.push(unit_node);
		}
        |   func_declaration
		{
			ParseTreeNode func_declaration_node = parseTreeStack.top();

			parseTreeStack.pop();

			ParseTreeNode unit_node = {"unit", false, {func_declaration_node}};

			parseTreeStack.push(unit_node);
		}
        |   func_definition
		{
			ParseTreeNode func_definition_node = parseTreeStack.top();

			parseTreeStack.pop();

			ParseTreeNode unit_node = {"unit", false, {func_definition_node}};

			parseTreeStack.push(unit_node);
		}
        ;
     
func_declaration    :   type_specifier ID LPAREN parameter_list RPAREN SEMICOLON
					{
						ParseTreeNode parameter_list_node = parseTreeStack.top();

						parseTreeStack.pop();

						ParseTreeNode type_specifier_node = parseTreeStack.top();

						parseTreeStack.pop();

						ParseTreeNode id_node = {"id", true, {}};
						ParseTreeNode lparen_node = {"LPAREN", true, {}};
						ParseTreeNode rparen_node = {"RPAREN", true, {}};
						ParseTreeNode semicolon_node = {"SEMICOLON", true, {}};
						ParseTreeNode func_declaration_node = {"func_declaration", false, {type_specifier_node, id_node, lparen_node, parameter_list_node, rparen_node, semicolon_node}};
					
						parseTreeStack.push(func_declaration_node);
					}
		            |   type_specifier ID LPAREN RPAREN SEMICOLON
					{
						ParseTreeNode type_specifier_node = parseTreeStack.top();

						parseTreeStack.pop();

						parseTreeNode id_node = {"ID", true, {}};
						ParseTreeNode lparen_node = {"LPAREN", true, {}};
						ParseTreeNode rparen_node = {"RPAREN", true, {}};
						ParseTreeNode semicolon_node = {"SEMICOLON", true, {}};
						ParseTreeNode func_declaration_node = {"func_declaration", false, {type_specifier_node, id_node, lparen_node, rparen_node, semicolon_node}};
					}
		            ;
		 
func_definition	:	type_specifier ID LPAREN parameter_list RPAREN compound_statement
				{
					ParseTreeNode compound_statement_node = parseTreeStack.top();

					parseTreeStack.pop();

					ParseTreeNode parameter_list_node = parseTreeStack.top();

					parseTreeStack.pop();

					ParseTreeNode type_specifier_node = parseTreeStack.top();

					parseTreeStack.pop();

					ParseTreeNode id_node = {"ID", true, {}};
					ParseTreeNode lparen_node = {"LPAREN", true, {}};
					ParseTreeNode rparen_node = {"RPAREN", true, {}};
					ParseTreeNode func_definition_node = {"func_definition", false, {type_specifier_node, id_node, lparen_node, parameter_list_node, rparen_node, compound_statement_node}};

					parseTreeStack.push(func_definition_node);
				}
				|	type_specifier ID LPAREN RPAREN compound_statement
				{
					ParseTreeNode compound_statement_node = parseTreeStack.top();

					parseTreeStack.pop();

					ParseTreeNode type_specifier_node = parseTreeStack.top();

					parseTreeStack.pop();

					ParseTreeNode id_node = {"ID", true, {}};
					ParseTreeNode lparen_node = {"LPAREN", true, {}};
					ParseTreeNode rparen_node = {"RPAREN", true, {}};
					ParseTreeNode func_definition_node = {"func_definition", false, {type_specifier_node, id_node, lparen_node, rparen_node, compound_statement_node}};

					parseTreeStack.push(func_definition_node);
				}
 				;

parameter_list	:	parameter_list COMMA type_specifier ID
				{
					ParseTreeNode type_specifier_node = parseTreeStack.top();

					parseTreeStack.pop();

					ParseTreeNode parameter_list_node_child = parseTreeStack.top();

					parseTreeStack.pop();

					ParseTreeNode comma_node = {"COMMA", true, {}};
					ParseTreeNode id_node = {"ID", true, {}};
					ParseTreeNode parameter_list_node = {"parameter_list", false, {parameter_list_node_child, comma_node, type_specifier_node, id_node}};

					parseTreeStack.push(parameter_list_node);
				}
				|	parameter_list COMMA type_specifier
				{
					ParseTreeNode type_specifier_node = parseTreeStack.top();

					parseTreeStack.pop();

					ParseTreeNode parameter_list_node_child = parseTreeStack.top();

					parseTreeStack.pop();

					ParseTreeNode comma_node = {"COMMA", true, {}};
					ParseTreeNode parameter_list_node = {"parameter_list", false, {parameter_list_node_child, comma_node, type_specifier_node}};

					parseTreeStack.push(parameter_list_node);
				}
 				|	type_specifier ID
				{
					ParseTreeNode type_specifier_node = parseTreeStack.top();

					parseTreeStack.pop();
					
					ParseTreeNode id_node = {"ID", true, {}};
					ParseTreeNode parameter_list_node = {"parameter_list", false, {type_specifier_node, id_node}};

					parseTreeStack.push(parameter_list_node);
				}
				|	type_specifier
				{
					ParseTreeNode type_specifier_node = parseTreeStack.top();

					parseTreeStack.pop();
					
					ParseTreeNode parameter_list_node = {"parameter_list", false, {type_specifier_node}};

					parseTreeStack.push(parameter_list_node);
				}
 				;

compound_statement  :   LCURL statements RCURL
 		            |	LCURL RCURL
 		            ;
 		    
var_declaration :   type_specifier declaration_list SEMICOLON
				{
					ParseTreeNode declaration_list_node = parseTreeStack.top();

					parseTreeStack.pop();

					ParseTreeNode type_specifier_node = parseTreeStack.top();

					parseTreeStack.pop();

					ParseTreeNode semicolon_node = {"SEMICOLON", true, {}};
					ParseTreeNode var_declaration_node = {"var_declaration", false, {type_specifier_node, declaration_list_node, semicolon_node}};

					parseTreeStack.push(var_declaration_node);
				}
 		        ;
 		 
type_specifier  :   INT
				{
					ParseTreeNode int_node = {"INT", true, {}};
					ParseTreeNode type_specifier_node = {"type_specifier", false, {int_node}};
					
					parseTreeStack.push(type_specifier_node);

					std::cout << "int found" << std::endl;
				}
 		        |   FLOAT
				{
					ParseTreeNode float_node = {"FLOAT", true, {}};
					ParseTreeNode type_specifier_node = {"type_specifier", false, {float_node}};
					
					parseTreeStack.push(type_specifier_node);

					std::cout << "float found" << std::endl;
				}
 		        |   VOID
				{
					ParseTreeNode void_node = {"VOID", true, {}};
					ParseTreeNode type_specifier_node = {"type_specifier", false, {void_node}};
					
					parseTreeStack.push(type_specifier_node);
				}
 		        ;
 		
declaration_list    :   declaration_list COMMA ID
					{
						ParseTreeNode declaration_list_node_child = parseTreeStack.top();
						ParseTreeNode comma_node = {"COMMA", true, {}};
						ParseTreeNode id_node = {"ID", true, {}};
						ParseTreeNode declaration_list_node = {"declaration_list", false, {declaration_list_node_child, comma_node, id_node}};

						parseTreeStack.pop();
						parseTreeStack.push(declaration_list_node);
					}
 		            |   declaration_list COMMA ID LSQUARE CONST_INT RSQUARE
 		            |   ID
					{
						ParseTreeNode id_node = {"ID", true, {}};
						ParseTreeNode declaration_list_node = {"type_specifier", false, {id_node}};
						
						parseTreeStack.push(declaration_list_node);
					}
 		            |   ID LSQUARE CONST_INT RSQUARE
 		            ;
 		  
statements  :   statement
			{
				ParseTreeNode statement_node = parseTreeStack.top();

				parseTreeStack.pop();

				ParseTreeNode statements_node = {"statements", false, {statement}};

				parseTreeStack.push(statements_node);
			}
	        |   statements statement
			{
				ParseTreeNode statement_node = parseTreeStack.top();
				
				parseTreeStack.pop();

				ParseTreeNode statements_node_child = parseTreeStack.top();

				parseTreeStack.pop();

				ParseTreeNode statements_node = {"statements", false, {statements_node_child, statement_node}};

				parseTreeStack.push(statements_node);
			}
	        ;

statement   :   open_statement
			{
				ParseTreeNode open_statement_node = parseTreeStack.top();

				parseTreeStack.pop();

				ParseTreeNode statement_node = {"statement", false, {open_statement_node}};

				parseTreeStack.push(statement_node);
			}
            |   closed_statement
			{
				ParseTreeNode closed_statement_node = parseTreeStack.top();

				parseTreeStack.pop();

				ParseTreeNode statement_node = {"statement", false, {closed_statement_node}};

				parseTreeStack.push(statement_node);
			}
            ;

open_statement	:	IF LPAREN expression RPAREN statement
				|	IF LPAREN expression RPAREN closed_statement ELSE open_statement
				;

closed_statement	:	other_statement
					|	IF LPAREN expression RPAREN closed_statement ELSE closed_statement
					;

other_statement :   var_declaration
	            |   expression_statement
	            |   compound_statement
	            |   FOR LPAREN expression_statement expression_statement expression RPAREN statement
	            |   WHILE LPAREN expression RPAREN statement
	            |   RETURN expression SEMICOLON
	            ;
	  
expression_statement    :   SEMICOLON			
			            |   expression SEMICOLON 
			            ;
	  
variable    :   ID
	        |   ID LSQUARE expression RSQUARE 
	        ;
	 
expression  :   logic_expression	
	        |   variable ASSIGNOP logic_expression 	
	        ;
			
logic_expression    :   rel_expression 	
		            |   rel_expression LOGICOP rel_expression 	
		            ;
			
rel_expression  :   simple_expression 
		        |   simple_expression RELOP simple_expression	
		        ;
				
simple_expression   :   term 
		            |   simple_expression ADDOP term 
		            ;
					
term    :	unary_expression
        |   term MULOP unary_expression
        ;

unary_expression    :   ADDOP unary_expression  
		            |   NOT unary_expression 
		            |   factor 
		            ;
	
factor  :   variable 
	    |   ID LPAREN argument_list RPAREN
	    |   LPAREN expression RPAREN
	    |   CONST_INT 
	    |   CONST_FLOAT
	    |   variable INCOP
	    ;
	
argument_list   :   arguments
			    |
                ;
	
arguments   :   arguments COMMA logic_expression
	        |   logic_expression
	        ;
 
%%

int main(int argc,char *argv[])
{
	st = new SymbolTable(10);

	tokenout = fopen("1905039_tokenout.txt", "w");
	logout = fopen("1905039_logout.txt", "w");
	FILE *fp = fopen("sample_input/noerror.c", "r");

	if(fp == NULL)
	{
		printf("Cannot Open Input File.\n");
		exit(1);
	}

	yyin = fp;

	yyparse();
	PrintParseTree(parseTreeStack.top(), 0);
	fclose(fp);
	fclose(tokenout);
	fclose(logout);
	
	return 0;
}