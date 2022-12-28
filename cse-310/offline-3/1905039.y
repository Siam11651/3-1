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
	if(parseTreeNode.terminal)
	{
		for(size_t i = 0; i < depth; ++i)
		{
			std::cout << ' ';
		}

		std::cout << parseTreeNode.name << std::endl;
	}
	else
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
%nonassoc RPAREN
%nonassoc ELSE

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

						ParseTreeNode id_node = {"ID", true, {}};
						ParseTreeNode lparen_node = {"LPAREN", true, {}};
						ParseTreeNode rparen_node = {"RPAREN", true, {}};
						ParseTreeNode semicolon_node = {"SEMICOLON", true, {}};
						ParseTreeNode func_declaration_node = {"func_declaration", false, {type_specifier_node, id_node, lparen_node, rparen_node, semicolon_node}};

						parseTreeStack.push(func_declaration_node);
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

compound_statement	:	LCURL statements RCURL
					{
						ParseTreeNode statements_node = parseTreeStack.top();

						parseTreeStack.pop();

						ParseTreeNode lcurl_node = {"LCURL", true, {}};
						ParseTreeNode rcurl_node = {"RCURL", true, {}};
						ParseTreeNode compound_statement_node = {"compound_statement", false, {lcurl_node, statements_node, rcurl_node}};

						parseTreeStack.push(compound_statement_node);
					}
 		            |	LCURL RCURL
					{
						ParseTreeNode lcurl_node = {"LCURL", true, {}};
						ParseTreeNode rcurl_node = {"RCURL", true, {}};
						ParseTreeNode compound_statement_node = {"compound_statement", false, {lcurl_node, rcurl_node}};

						parseTreeStack.push(compound_statement_node);
					}
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
				}
 		        |   FLOAT
				{
					ParseTreeNode float_node = {"FLOAT", true, {}};
					ParseTreeNode type_specifier_node = {"type_specifier", false, {float_node}};
					
					parseTreeStack.push(type_specifier_node);
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
					{
						ParseTreeNode declaration_list_node_child = parseTreeStack.top();

						parseTreeStack.pop();

						ParseTreeNode comma_node = {"COMMA", true, {}};
						ParseTreeNode id_node = {"ID", true, {}};
						ParseTreeNode lsquare_node = {"LSQUARE", true, {}};
						ParseTreeNode const_int_node = {"CONST_INT", true, {}};
						ParseTreeNode rsquare_node = {"RSQUARE", true, {}};
						ParseTreeNode declaration_list_node = {"declaration_list", false, {declaration_list_node_child, comma_node, id_node, lsquare_node, const_int_node, rsquare_node}};

						parseTreeStack.push(declaration_list_node);
					}
 		            |   ID
					{
						ParseTreeNode id_node = {"ID", true, {}};
						ParseTreeNode declaration_list_node = {"declaration_list", false, {id_node}};
						
						parseTreeStack.push(declaration_list_node);
					}
 		            |   ID LSQUARE CONST_INT RSQUARE
					{
						ParseTreeNode id_node = {"ID", true, {}};
						ParseTreeNode lsquare_node = {"LSQUARE", true, {}};
						ParseTreeNode const_int_node = {"CONST_INT", true, {}};
						ParseTreeNode rsquare_node = {"RSQUARE", true, {}};
						ParseTreeNode declaration_list_node = {"declaration_list", false, {id_node, lsquare_node, const_int_node, rsquare_node}};

						parseTreeStack.push(declaration_list_node);
					}
 		            ;
 		  
statements  :   statement
			{
				ParseTreeNode statement_node = parseTreeStack.top();

				parseTreeStack.pop();

				ParseTreeNode statements_node = {"statements", false, {statement_node}};

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

statement	:   var_declaration
			{
				ParseTreeNode var_declaration_node = parseTreeStack.top();

				parseTreeStack.pop();

				ParseTreeNode statement_node = {"statement", false, {var_declaration_node}};

				parseTreeStack.push(statement_node);
			}
			|   expression_statement
			{
				ParseTreeNode expression_statement_node = parseTreeStack.top();

				parseTreeStack.pop();

				ParseTreeNode statement_node = {"statement", false, {expression_statement_node}};

				parseTreeStack.push(statement_node);
			}
			|   compound_statement
			{
				ParseTreeNode compound_statement_node = parseTreeStack.top();

				parseTreeStack.pop();

				ParseTreeNode statement_node = {"statement", false, {compound_statement_node}};

				parseTreeStack.push(statement_node);
			}
			|   FOR LPAREN expression_statement expression_statement expression RPAREN statement
			{
				ParseTreeNode statement_node_child = parseTreeStack.top();

				parseTreeStack.pop();

				ParseTreeNode expression_node = parseTreeStack.top();

				parseTreeStack.pop();

				ParseTreeNode expression_statement_node2 = parseTreeStack.top();

				parseTreeStack.pop();

				ParseTreeNode expression_statement_node1 = parseTreeStack.top();

				parseTreeStack.pop();

				ParseTreeNode for_node = {"FOR", true, {}};
				ParseTreeNode lparen_node = {"LPAREN", true, {}};
				ParseTreeNode rparen_node = {"RPAREN", true, {}};
				ParseTreeNode statement_node = {"statement", false, {for_node, lparen_node, expression_statement_node1, expression_statement_node2, expression_node, rparen_node, statement_node_child}};

				parseTreeStack.push(statement_node);
			}
			|   WHILE LPAREN expression RPAREN statement
			{
				ParseTreeNode statement_node_child = parseTreeStack.top();

				parseTreeStack.pop();

				ParseTreeNode expression_node = parseTreeStack.top();

				parseTreeStack.pop();

				ParseTreeNode while_node = {"WHILE", true, {}};
				ParseTreeNode lparen_node = {"LPAREN", true, {}};
				ParseTreeNode rparen_node = {"RPAREN", true, {}};
				ParseTreeNode statement_node = {"statement", false, {while_node, lparen_node, expression_node, rparen_node, statement_node_child}};

				parseTreeStack.push(statement_node);
			}
			|   RETURN expression SEMICOLON
			{
				ParseTreeNode expression_node = parseTreeStack.top();

				parseTreeStack.pop();

				ParseTreeNode return_node = {"RETURN", true, {}};
				ParseTreeNode semicolon_node = {"SEMICOLON", true, {}};
				ParseTreeNode statement_node = {"statement", false, {return_node, expression_node, semicolon_node}};

				parseTreeStack.push(statement_node);
			}
			| IF LPAREN expression RPAREN statement
			{
				ParseTreeNode statement_node_child = parseTreeStack.top();

				parseTreeStack.pop();

				ParseTreeNode expression_node = parseTreeStack.top();

				parseTreeStack.pop();

				ParseTreeNode if_node = {"IF", true, {}};
				ParseTreeNode lparen_node = {"LPAREN", true, {}};
				ParseTreeNode rparen_node = {"RPAREN", true, {}};
				ParseTreeNode statement_node = {"statement", false, {if_node, lparen_node, expression_node, rparen_node, statement_node_child}};

				parseTreeStack.push(statement_node);
			}
	  		| IF LPAREN expression RPAREN statement ELSE statement
			{
				ParseTreeNode statement_node2 = parseTreeStack.top();

				parseTreeStack.pop();

				ParseTreeNode statement_node1 = parseTreeStack.top();

				parseTreeStack.pop();

				ParseTreeNode expression_node = parseTreeStack.top();

				parseTreeStack.pop();

				ParseTreeNode if_node = {"IF", true, {}};
				ParseTreeNode lparen_node = {"LPAREN", true, {}};
				ParseTreeNode rparen_node = {"RPAREN", true, {}};
				ParseTreeNode else_node = {"ELSE", true, {}};
				ParseTreeNode statement_node = {"statement", false, {if_node, lparen_node, expression_node, rparen_node, statement_node1, else_node, statement_node2}};

				parseTreeStack.push(statement_node);
			}
			;
	  
expression_statement    :   SEMICOLON
						{
							ParseTreeNode semicolon_node = {"SEMICOLON", true, {}};
							ParseTreeNode expression_statement_node = {"expression_statement", false, {semicolon_node}};

							parseTreeStack.push(expression_statement_node);
						}
			            |   expression SEMICOLON
						{
							ParseTreeNode expression_node = parseTreeStack.top();

							parseTreeStack.pop();

							ParseTreeNode semicolon_node = {"SEMICOLON", true, {}};
							ParseTreeNode expression_statement_node = {"expression_statement", false, {expression_node, semicolon_node}};

							parseTreeStack.push(expression_statement_node);
						}
			            ;
	  
variable    :   ID
			{
				ParseTreeNode id_node = {"ID", true, {}};
				ParseTreeNode variable_node = {"variable", false, {id_node}};

				parseTreeStack.push(variable_node);
			}
	        |   ID LSQUARE expression RSQUARE 
			{
				ParseTreeNode expression_node = parseTreeStack.top();

				parseTreeStack.pop();

				ParseTreeNode id_node = {"ID", true, {}};
				ParseTreeNode lsquare_node = {"LSQUARE", true, {}};
				ParseTreeNode rsquare_node = {"RSQUARE", true, {}};
				ParseTreeNode variable_node = {"variable", false, {id_node, lsquare_node, expression_node, rsquare_node}};

				parseTreeStack.push(variable_node);
			}
	        ;
	 
expression  :   logic_expression
			{
				ParseTreeNode logic_expression_node = parseTreeStack.top();

				parseTreeStack.pop();

				ParseTreeNode expression_node = {"expression", false, {logic_expression_node}};

				parseTreeStack.push(expression_node);
			}
	        |   variable ASSIGNOP logic_expression
			{
				ParseTreeNode logic_expression_node = parseTreeStack.top();

				parseTreeStack.pop();

				ParseTreeNode variable_node = parseTreeStack.top();

				parseTreeStack.pop();

				ParseTreeNode assignop_node = {"ASSIGNOP", true, {}};
				ParseTreeNode expression_node = {"expression", false, {variable_node, assignop_node, logic_expression_node}};

				parseTreeStack.push(expression_node);
			}
	        ;
			
logic_expression    :   rel_expression
					{
						ParseTreeNode rel_expression_node = parseTreeStack.top();

						parseTreeStack.pop();

						ParseTreeNode logic_expression_node = {"logic_expression", false, {rel_expression_node}};

						parseTreeStack.push(logic_expression_node);
					}
		            |   rel_expression LOGICOP rel_expression
					{
						ParseTreeNode rel_expression_node2 = parseTreeStack.top();

						parseTreeStack.pop();

						ParseTreeNode rel_expression_node1 = parseTreeStack.top();

						parseTreeStack.pop();

						ParseTreeNode logicop_node = {"LOGICOP", true, {}};
						ParseTreeNode logic_expression_node = {"logic_expression", false, {rel_expression_node1, logicop_node, rel_expression_node2}};

						parseTreeStack.push(logic_expression_node);
					}
		            ;
			
rel_expression  :   simple_expression
				{
					ParseTreeNode simple_expression_node = parseTreeStack.top();

					parseTreeStack.pop();

					ParseTreeNode rel_expression_node = {"rel_expression", false, {simple_expression_node}};

					parseTreeStack.push(rel_expression_node);
				}
		        |   simple_expression RELOP simple_expression
				{
					ParseTreeNode simple_expression_node2 = parseTreeStack.top();

					parseTreeStack.pop();

					ParseTreeNode simple_expression_node1 = parseTreeStack.top();

					parseTreeStack.pop();

					ParseTreeNode relop_node = {"RELOP", true, {}};
					ParseTreeNode rel_expression_node = {"rel_expression", false, {simple_expression_node1, relop_node, simple_expression_node2}};

					parseTreeStack.push(rel_expression_node);
				}
		        ;
				
simple_expression   :   term
					{
						ParseTreeNode term_node = parseTreeStack.top();

						parseTreeStack.pop();

						ParseTreeNode simple_expression_node = {"simple_expression", false, {term_node}};

						parseTreeStack.push(simple_expression_node);
					}
		            |   simple_expression ADDOP term
					{
						ParseTreeNode term_node = parseTreeStack.top();

						parseTreeStack.pop();

						ParseTreeNode simple_expression_node_child = parseTreeStack.top();

						parseTreeStack.pop();

						ParseTreeNode addop_node = {"ADDOP", true, {}};
						ParseTreeNode simple_expression_node = {"simple_expression", false, {simple_expression_node_child, addop_node, term_node}};

						parseTreeStack.push(simple_expression_node);
					}
		            ;
					
term    :	unary_expression
		{
			ParseTreeNode unary_expression_node = parseTreeStack.top();

			parseTreeStack.pop();

			ParseTreeNode term_node = {"term", false, {unary_expression_node}};

			parseTreeStack.push(term_node);
		}
        |   term MULOP unary_expression
		{
			ParseTreeNode unary_expression_node = parseTreeStack.top();

			parseTreeStack.pop();

			ParseTreeNode term_node_child = parseTreeStack.top();

			parseTreeStack.pop();

			ParseTreeNode mulop_node = {"MULOP", true, {}};
			ParseTreeNode term_node = {"term", false, {term_node_child, mulop_node, unary_expression_node}};

			parseTreeStack.push(term_node);
		}
        ;

unary_expression    :   ADDOP unary_expression
					{
						ParseTreeNode unary_expression_node_child = parseTreeStack.top();

						parseTreeStack.pop();

						ParseTreeNode addop_node = {"ADDOP", true, {}};
						ParseTreeNode unary_expression_node = {"unary_expression", false, {addop_node, unary_expression_node_child}};

						parseTreeStack.push(unary_expression_node);
					}
		            |   NOT unary_expression
					{
						ParseTreeNode unary_expression_node_child = parseTreeStack.top();

						parseTreeStack.pop();

						ParseTreeNode not_node = {"NOT", true, {}};
						ParseTreeNode unary_expression_node = {"unary_expression", false, {not_node, unary_expression_node_child}};

						parseTreeStack.push(unary_expression_node);
					}
		            |   factor
					{
						ParseTreeNode factor_node = parseTreeStack.top();

						parseTreeStack.pop();

						ParseTreeNode unary_expression_node = {"unary_expression", false, {factor_node}};

						parseTreeStack.push(unary_expression_node);
					}
		            ;
	
factor  :   variable
		{
			ParseTreeNode variable_node = parseTreeStack.top();

			parseTreeStack.pop();

			ParseTreeNode factor_node = {"factor", false, {variable_node}};

			parseTreeStack.push(factor_node);
		}
	    |   ID LPAREN argument_list RPAREN
		{
			ParseTreeNode argument_list_node = parseTreeStack.top();

			parseTreeStack.pop();

			ParseTreeNode id_node = {"ID", true, {}};
			ParseTreeNode lparen_node = {"LPAREN", true, {}};
			ParseTreeNode rparen_node = {"RPAREN", true, {}};
			ParseTreeNode factor_node = {"factor", false, {id_node, lparen_node, argument_list_node, rparen_node}};

			parseTreeStack.push(factor_node);
		}
	    |   LPAREN expression RPAREN
		{
			ParseTreeNode expression_node = parseTreeStack.top();

			parseTreeStack.pop();

			ParseTreeNode lparen_node = {"LPAREN", true, {}};
			ParseTreeNode rparen_node = {"RPAREN", true, {}};
			ParseTreeNode factor_node = {"factor", false, {lparen_node, expression_node, rparen_node}};

			parseTreeStack.push(factor_node);
		}
	    |   CONST_INT
		{
			ParseTreeNode const_int_node = {"CONST_INT", true, {}};
			ParseTreeNode factor_node = {"factor", false, {const_int_node}};

			parseTreeStack.push(factor_node);
		}
	    |   CONST_FLOAT
		{
			ParseTreeNode const_float_node = {"CONST_FLOAT", true, {}};
			ParseTreeNode factor_node = {"factor", false, {const_float_node}};

			parseTreeStack.push(factor_node);
		}
	    |   variable INCOP
		{
			ParseTreeNode variable_node = parseTreeStack.top();

			parseTreeStack.pop();

			ParseTreeNode incop_node = {"INCOP", true, {}};
			ParseTreeNode factor_node = {"factor", false, {variable_node, incop_node}};

			parseTreeStack.push(factor_node);
		}
	    ;
	
argument_list   :   arguments
				{
					ParseTreeNode arguments_node = parseTreeStack.top();

					parseTreeStack.pop();

					ParseTreeNode argument_list_node = {"argument_list", true, {arguments_node}};

					parseTreeStack.push(argument_list_node);
				}
			    |
                ;
	
arguments   :   arguments COMMA logic_expression
			{
				ParseTreeNode logic_expression_node = parseTreeStack.top();

				parseTreeStack.pop();

				ParseTreeNode arguments_node_child = parseTreeStack.top();

				parseTreeStack.pop();

				ParseTreeNode comma_node = {"COMMA", true, {}};
				ParseTreeNode arguments_node = {"arguments", false, {arguments_node_child, comma_node, logic_expression_node}};

				parseTreeStack.push(arguments_node);
			}
	        |   logic_expression
			{
				ParseTreeNode logic_expression_node = parseTreeStack.top();

				parseTreeStack.pop();

				ParseTreeNode arguments_node = {"arguments", false, {logic_expression_node}};

				parseTreeStack.push(arguments_node);
			}
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