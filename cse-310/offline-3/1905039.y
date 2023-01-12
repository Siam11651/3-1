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
std::ofstream parseTreeStream;
extern std::ofstream logStream;
extern size_t lineCount;
extern size_t errorCount;
SymbolInfo *function;
SymbolInfo *present;

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
			parseTreeStream << ' ';
		}

		parseTreeStream << parseTreeNode.name << " : " << parseTreeNode.symbolInfo->GetName() << "\t<Line: " << parseTreeNode.symbolInfo->GetSymbolStart() << '>' << std::endl;
	}
	else
	{
		for(size_t i = 0; i < depth; ++i)
		{
			parseTreeStream << ' ';
		}

		parseTreeStream << parseTreeNode.name << " : ";

		for(size_t i = 0; i < parseTreeNode.children.size(); ++i)
		{
			parseTreeStream << parseTreeNode.children[i].name << ' ';
		}

		parseTreeStream << "\t<Line: " << parseTreeNode.startLine << '-' << parseTreeNode.endLine << '>' << std::endl;

		for(size_t i = 0; i < parseTreeNode.children.size(); ++i)
		{
			PrintParseTree(parseTreeNode.children[i], depth + 1);
		}
	}
}

void SetLine(ParseTreeNode &parseTreeNode)
{
	size_t start = SIZE_MAX;
	size_t end = 0;

	for(size_t i = 0; i < parseTreeNode.children.size(); ++i)
	{
		ParseTreeNode &child = parseTreeNode.children[i];

		if(child.terminal)
		{
			start = std::min(start, child.symbolInfo->GetSymbolStart());
			end = std::max(end, child.symbolInfo->GetSymbolEnd());
		}
		else
		{
			start = std::min(start, child.startLine);
			end = std::max(end, child.endLine);
		}
	}

	parseTreeNode.startLine = start;
	parseTreeNode.endLine = end;
}

void InsertID(ParseTreeNode &root, const std::string dataType, SymbolTable *symbolTable)
{
	if(root.terminal && root.name == "ID")
	{
		if(dataType == "void")
		{
			// void data type declaration
		}
		else
		{
			root.symbolInfo->SetDataType(dataType);
			symbolTable->Insert(root.symbolInfo);
		}
	}
	else
	{
		for(size_t i = 0; i < root.children.size(); ++i)
		{
			InsertID(root.children[i], dataType, symbolTable);
		}
	}
}

void SetParams(ParseTreeNode &root, std::vector<std::string> &paramList)
{
	if(root.children.size() == 3 || root.children.size() == 4)
	{
		std::pair<std::string, std::string> param = {root.children[2].children[0].name, if(root.children.size() == 4) ? root.children[3].children[0].name : ""};
		paramList.push_back(param);

		SetParams(root.children[0], paramList);
	}
	else if(root.children.size() == 2 || root.children.size() == 1)
	{
		std::pair<std::string, std::string> param = {root.children[2].children[0].name, if(root.children.size() == 2) ? root.children[1].children[0].name : ""};
		paramList.push_back(param);
	}
}

std::string GetVariableDataType(ParseTreeNode &root)
{
	return root.children[0].symbolInfo->GetDataType();
}

std::string GetFactorDataType(ParseTreeNode &root)
{
	if(root.children.size() == 1)
	{
		if(root.children[0].name == "variable")
		{
			return GetVariableDataType(root.children[0]);
		}
		else
		{
			if(root.children[0].name == "CONST_FLOAT")
			{
				return "float";
			}
			else
			{
				return "int";
			}
		}
	}
	else if(root.children.size() == 2)
	{
		return GetVariableDataType(root.children[0]);
	}
	else if(root.children.size() == 3)
	{
		return GetExpressionDataType(root.children[1]);
	}
	else
	{
		SymbolInfo* function = st->LookUpFunction(root.children[0].symbolInfo->GetName());

		return function->GetDataType();
	}
}

std::string GetUnaryExpressionDataType(ParseTreeNode &root)
{
	if(root.children.size() == 1)
	{
		return GetFactorDataType(root.children[0]);
	}
	else
	{
		std::string type = GetUnaryExpressionDataType(root.children[1]);

		if(type == "void")
		{
			// void in expression error

			return "";
		}
		else
		{
			return type;
		}
	}
}

std::string GetTermDataType(ParseTreeNode &root)
{
	if(root.children.size() == 1)
	{
		return GetUnaryExpressionDataType(root.children[0]);
	}
	else
	{
		std::string term = GetTermDataType(root.children[0]);
		std::string unaryExpession = GetUnaryExpressionDataType(root.children[2]);

		if(unaryExpession == "")
		{
			return "";
		}
		else if(term == "void" || unaryExpession == "void")
		{
			// void in expression error

			return "";
		}
		else
		{
			if(term == "float" || unaryExpession == "float")
			{
				if(root.children[1].symbol->GetName() == "%")
				{
					// operands of modulus warning
				}

				return "float";
			}
			else
			{
				return "int";
			}
		}
	}
}

std::string GetSimpleExpressionDataType(ParseTreeNode &root)
{
	if(root.children.size() == 1)
	{
		return GetTermDataType(root.children[0]);
	}
	else
	{
		std::string simpleExpression = GetSimpleExpressionDataType(root.children[0]);
		std::string term = GetTermDataType(root.children[2]);

		if(simpleExpression == "" || term == "")
		{
			return "";
		}
		else if(term == "void")
		{
			// void in expression error

			return "";
		}
		else if(simpleExpression == "float" || term == "float")
		{
			return "float";
		}
		else
		{
			return "int";
		}
	}
}

std::string GetRelExpressionDataType(ParseTreeNode &root)
{
	if(root.children.size() == 1)
	{
		return GetSimpleExpressionDataType(root.children[0]);
	}
	else
	{
		return "int"; // relop always give int
	}
}

std::string GetLoginExpressionDataType(ParseTreeNode &root)
{
	if(root.children.size() == 1)
	{
		return GetRelExpressionDataType(root.children[0]);
	}
	else // else 3
	{
		return "int"; // logic op always give int
	}
}

std::string GetExpressionDataType(ParseTreeNode &root)
{
	if(root.children.size() == 1)
	{
		return GetLoginExpressionDataType(root);
	}
	else // else 3
	{
		return GetVariableDataType(root.children[0]);
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
			logStream << "start : program" << std::endl;

			ParseTreeNode program_node = parseTreeStack.top();

			parseTreeStack.pop();

			ParseTreeNode start_node = {"start", false, {program_node}, NULL, 0, 0};

			SetLine(start_node);
			parseTreeStack.push(start_node);
		}
	    ;

program :   program unit
        {
			logStream << "program : program unit" << std::endl;

            ParseTreeNode unit_node = parseTreeStack.top();

			parseTreeStack.pop();

			ParseTreeNode program_node_child = parseTreeStack.top();

			parseTreeStack.pop();

			ParseTreeNode program_node = {"program", false, {program_node_child, unit_node}, NULL};

			SetLine(program_node);
			parseTreeStack.push(program_node);
        }
	    |   unit
        {
			logStream << "program : unit" << std::endl;

            ParseTreeNode unit_node = parseTreeStack.top();

			parseTreeStack.pop();

			ParseTreeNode program_node = {"program", false, {unit_node}, NULL};

			SetLine(program_node);
			parseTreeStack.push(program_node);
        }
	    ;
	
unit    :   var_declaration
		{
			logStream << "unit : var_declaration" << std::endl;

			ParseTreeNode var_declaration_node = parseTreeStack.top();

			parseTreeStack.pop();

			ParseTreeNode unit_node = {"unit", false, {var_declaration_node}, NULL};

			SetLine(unit_node);
			parseTreeStack.push(unit_node);
		}
        |   func_declaration
		{
			logStream << "unit : func_declaration" << std::endl;

			ParseTreeNode func_declaration_node = parseTreeStack.top();

			parseTreeStack.pop();

			ParseTreeNode unit_node = {"unit", false, {func_declaration_node}, NULL};

			SetLine(unit_node);
			parseTreeStack.push(unit_node);
		}
        |   func_definition
		{
			logStream << "unit : func_definition" << std::endl;

			ParseTreeNode func_definition_node = parseTreeStack.top();

			parseTreeStack.pop();

			ParseTreeNode unit_node = {"unit", false, {func_definition_node}, NULL};

			SetLine(unit_node);
			parseTreeStack.push(unit_node);
		}
        ;

func_start	:	type_specifier ID LPAREN
			{
				ParseTreeNode type_specifier_node = parseTreeStack.top();

				parseTreeStack.pop();

				$2->SetIDType("FUNCTION");
				$2->SetArray(false);
				$2->SetDataType(type_specifier_node.children[0].name);
				
				present = NULL;
				function = NULL;

				if(present == NULL)
				{
					st->InsertFunction($2);
					function = $2;
				}
				else
				{
					function = present;
				}

				ParseTreeNode id_node = {"ID", true, {}, $2};
				ParseTreeNode lparen_node = {"LPAREN", true, {}, $3};

				ParseTreeNode func_start_node = {"func_start", false, {type_specifier_node, id_node, lparen_node}, NULL};

				parseTreeStack.push(func_start_node);
				st->EnterScope();
			}
			;
     
func_declaration    :	func_start parameter_list RPAREN SEMICOLON
					{
						logStream << "func_declaration : type_specifier ID LPAREN parameter_list RPAREN SEMICOLON" << std::endl;

						ParseTreeNode parameter_list_node = parseTreeStack.top();

						parseTreeStack.pop();

						ParseTreeNode func_start_node = parseTreeStack.top();

						parseTreeStack.pop();

						if(present == NULL)
						{
							std::vector<std::string> paramList;
							SetParams(parameter_list_node, paramList);

							bool ok = true;

							for(size_t i = 0; ok && (i < paramList.size() - 1); ++i)
							{
								for(size_t j = i + 1; ok && (j < paramList.size()); ++j)
								{
									if(paramList[i].second == paramList[j].second)
									{
										ok = false;
									}
								}
							}

							if(ok)
							{
								function->SetParamList(paramList);
							}
							else
							{
								// Redefinition of parameter
							}
						}
						else
						{
							// redeclaration of same function
						}

						ParseTreeNode rparen_node = {"RPAREN", true, {}, $3};
						ParseTreeNode semicolon_node = {"SEMICOLON", true, {}, $4};
						ParseTreeNode func_declaration_node = {"func_declaration", false, {func_start_node.children[0], func_start_node.children[1], func_start_node.children[2], parameter_list_node, rparen_node, semicolon_node}, NULL};
					
						parseTreeStack.push(func_declaration_node);
						SetLine(parseTreeStack.top());
						st->ExitScope();
						st->FalseScope();
					}
		            |	func_start RPAREN SEMICOLON
					{
						logStream << "func_declaration : type_specifier ID LPAREN RPAREN SEMICOLON" << std::endl;

						ParseTreeNode func_start_node = parseTreeStack.top();

						parseTreeStack.pop();

						if(present != NULL)
						{
							// redeclaration
						}

						ParseTreeNode rparen_node = {"RPAREN", true, {}, $2};
						ParseTreeNode semicolon_node = {"SEMICOLON", true, {}, $3};
						ParseTreeNode func_declaration_node = {"func_declaration", false, {func_start_node.children[0], func_start_node.children[1], func_start_node.children[2], rparen_node, semicolon_node}, NULL};
					
						parseTreeStack.push(func_declaration_node);
						SetLine(parseTreeStack.top());
						st->ExitScope();
						st->FalseScope();
					}
		            ;
		 
func_definition	:	func_start parameter_list RPAREN compound_statement
				{
					logStream << "func_definition : type_specifier ID LPAREN parameter_list RPAREN compound_statement" << std::endl;

					ParseTreeNode compound_statement_node = parseTreeStack.top();

					parseTreeStack.pop();

					ParseTreeNode parameter_list_node = parseTreeStack.top();

					parseTreeStack.pop();

					ParseTreeNode func_start_node = parseTreeStack.top();

					parseTreeStack.pop();

					function->SetDefined(true);

					if(present == NULL)
					{
						std::vector<std::string> paramList;

						SetParams(parameter_list_node, paramList);

						bool ok = true;

						for(size_t i = 0; ok && (i < paramList.size() - 1); ++i)
						{
							for(size_t j = i + 1; ok && (j < paramList.size()); ++j)
							{
								if(paramList[i].second == paramList[j].second)
								{
									ok = false;
								}
							}
						}

						if(ok)
						{
							function->SetParamList(paramList);
						}
						else
						{
							// Redefinition of parameter
						}
					}
					else
					{
						if(present->GetIDType() == "FUNCTION")
						{
							if(present->GetDefined())
							{
								// redefinition
							}
							else
							{
								if(present->GetDataType() == function->GetDataType())
								{
									std::vector<std::string> paramList;
						
									SetParams(parameter_list_node, paramList);

									bool ok = true;

									for(size_t i = 0; ok && (i < paramList.size() - 1); ++i)
									{
										for(size_t j = i + 1; ok && (j < paramList.size()); ++j)
										{
											if(paramList[i].second == paramList[j].second)
											{
												ok = false;
											}
										}
									}

									if(ok)
									{
										function->SetParamList(paramList);
									}
									else
									{
										// Redefinition of parameter
									}
								}
								else
								{
									// Conflicting types for
								}
							}
						}
						else
						{
							// redeclared as different kind of symbol
						}
					}

					ParseTreeNode rparen_node = {"RPAREN", true, {}, $3};
					ParseTreeNode func_definition_node = {"func_definition", false, {func_start_node.children[0], func_start_node.children[1], func_start_node.children[2], parameter_list_node, rparen_node, compound_statement_node}, NULL};
				
					SetLine(func_definition_node);
					parseTreeStack.push(func_definition_node);
				}
				|	func_start RPAREN compound_statement
				{
					logStream << "func_definition : type_specifier ID LPAREN RPAREN compound_statement" << std::endl;

					ParseTreeNode compound_statement_node = parseTreeStack.top();

					parseTreeStack.pop();

					ParseTreeNode func_start_node = parseTreeStack.top();

					parseTreeStack.pop();

					function->SetDefined(true);

					if(present == NULL)
					{
						std::vector<std::string> paramList;

						SetParams(parameter_list_node, paramList);
						function->SetParamList(paramList);
					}
					else
					{
						if(present->GetIDType() == "FUNCTION")
						{
							if(present->GetDefined())
							{
								// redefinition
							}
							else
							{
								if(present->GetDataType() == function->GetDataType())
								{
									std::vector<std::string> paramList;
						
									SetParams(parameter_list_node, paramList);
									function->SetParamList(paramList);
								}
								else
								{
									// Conflicting types for
								}
							}
						}
						else
						{
							// redeclared as different kind of symbol
						}
					}

					ParseTreeNode rparen_node = {"RPAREN", true, {}, $2};
					ParseTreeNode func_definition_node = {"func_definition", false, {func_start_node.children[0], func_start_node.children[1], func_start_node.children[2], rparen_node, compound_statement_node}, NULL};
				
					SetLine(func_definition_node);
					parseTreeStack.push(func_definition_node);
				}
 				;

parameter_list	:	parameter_list COMMA type_specifier ID
				{
					logStream << "parameter_list  : parameter_list COMMA type_specifier ID" << std::endl;

					ParseTreeNode type_specifier_node = parseTreeStack.top();

					$4->SetIDType("VARIABLE");
					$4->SetDataType(type_specifier_node.children[0].name);
					$4->SetArray(false);
					st->Insert($4);

					parseTreeStack.pop();

					ParseTreeNode parameter_list_node_child = parseTreeStack.top();

					parseTreeStack.pop();

					ParseTreeNode comma_node = {"COMMA", true, {}, $2};
					ParseTreeNode id_node = {"ID", true, {}, $4};
					ParseTreeNode parameter_list_node = {"parameter_list", false, {parameter_list_node_child, comma_node, type_specifier_node, id_node}, NULL};

					SetLine(parameter_list_node);
					parseTreeStack.push(parameter_list_node);
				}
				|	parameter_list COMMA type_specifier
				{
					logStream << "parameter_list  : parameter_list COMMA type_specifier" << std::endl;

					ParseTreeNode type_specifier_node = parseTreeStack.top();

					parseTreeStack.pop();

					ParseTreeNode parameter_list_node_child = parseTreeStack.top();

					parseTreeStack.pop();

					ParseTreeNode comma_node = {"COMMA", true, {}, $2};
					ParseTreeNode parameter_list_node = {"parameter_list", false, {parameter_list_node_child, comma_node, type_specifier_node}, NULL};

					SetLine(parameter_list_node);
					parseTreeStack.push(parameter_list_node);
				}
 				|	type_specifier ID
				{
					logStream << "parameter_list  : type_specifier ID" << std::endl;

					ParseTreeNode type_specifier_node = parseTreeStack.top();

					$2->SetIDType("VARIABLE");
					$2->SetDataType(type_specifier_node.children[0].name);
					$2->SetArray(false);
					st->Insert($2);

					// std::cout << "Line no: " << $2->GetSymbolStart() << ' ' << $2 << ' ' << $2->GetName() << std::endl;

					parseTreeStack.pop();
					
					ParseTreeNode id_node = {"ID", true, {}, $2};
					ParseTreeNode parameter_list_node = {"parameter_list", false, {type_specifier_node, id_node}, NULL};

					SetLine(parameter_list_node);
					parseTreeStack.push(parameter_list_node);
				}
				|	type_specifier
				{
					logStream << "parameter_list  : type_specifier" << std::endl;

					ParseTreeNode type_specifier_node = parseTreeStack.top();

					parseTreeStack.pop();
					
					ParseTreeNode parameter_list_node = {"parameter_list", false, {type_specifier_node}, NULL};

					SetLine(parameter_list_node);
					parseTreeStack.push(parameter_list_node);
				}
 				;

compound_statement	:	LCURL statements RCURL
					{
						logStream << "compound_statement : LCURL statements RCURL" << std::endl;

						st->PrintAllScope();
						st->ExitScope();

						ParseTreeNode statements_node = parseTreeStack.top();

						parseTreeStack.pop();

						ParseTreeNode lcurl_node = {"LCURL", true, {}, $1};
						ParseTreeNode rcurl_node = {"RCURL", true, {}, $3};
						ParseTreeNode compound_statement_node = {"compound_statement", false, {lcurl_node, statements_node, rcurl_node}};

						SetLine(compound_statement_node);
						parseTreeStack.push(compound_statement_node);
					}
 		            |	LCURL RCURL
					{
						st->PrintAllScope();
						st->ExitScope();

						logStream << "compund_statement : LCURL RCURL" << std::endl;

						ParseTreeNode lcurl_node = {"LCURL", true, {}, $1};
						ParseTreeNode rcurl_node = {"RCURL", true, {}, $2};
						ParseTreeNode compound_statement_node = {"compound_statement", false, {lcurl_node, rcurl_node}, NULL};

						SetLine(compound_statement_node);
						parseTreeStack.push(compound_statement_node);
					}
 		            ;
 		    
var_declaration :   type_specifier declaration_list SEMICOLON
				{
					logStream << "var_declaration : type_specifier declaration_list SEMICOLON" << std::endl;

					ParseTreeNode declaration_list_node = parseTreeStack.top();

					parseTreeStack.pop();

					ParseTreeNode type_specifier_node = parseTreeStack.top();

					parseTreeStack.pop();

					ParseTreeNode semicolon_node = {"SEMICOLON", true, {}, $3};
					ParseTreeNode var_declaration_node = {"var_declaration", false, {type_specifier_node, declaration_list_node, semicolon_node}, NULL};

					SetLine(var_declaration_node);
					parseTreeStack.push(var_declaration_node);

					InsertID(declaration_list_node, type_specifier_node.children[0].name, st);
				}
 		        ;
 		 
type_specifier  :   INT
				{
					logStream << "type_specifier\t: INT" << std::endl;

					ParseTreeNode int_node = {"INT", true, {}, $1};
					ParseTreeNode type_specifier_node = {"type_specifier", false, {int_node}, NULL};
					
					SetLine(type_specifier_node);
					parseTreeStack.push(type_specifier_node);
				}
 		        |   FLOAT
				{
					logStream << "type_specifier\t: FLOAT" << std::endl;

					ParseTreeNode float_node = {"FLOAT", true, {}, $1};
					ParseTreeNode type_specifier_node = {"type_specifier", false, {float_node}, NULL};
					
					SetLine(type_specifier_node);
					parseTreeStack.push(type_specifier_node);
				}
 		        |   VOID
				{
					logStream << "type_specifier\t: VOID" << std::endl;

					ParseTreeNode void_node = {"VOID", true, {}, $1};
					ParseTreeNode type_specifier_node = {"type_specifier", false, {void_node}, NULL};
					
					SetLine(type_specifier_node);
					parseTreeStack.push(type_specifier_node);
				}
 		        ;
 		
declaration_list    :   declaration_list COMMA ID
					{
						$3->SetIDType("VARIABLE");
						$3->SetArray(false);

						logStream << "declaration_list : declaration_list COMMA ID" << std::endl;

						ParseTreeNode declaration_list_node_child = parseTreeStack.top();
						ParseTreeNode comma_node = {"COMMA", true, {}, $2};
						ParseTreeNode id_node = {"ID", true, {}, $3};
						ParseTreeNode declaration_list_node = {"declaration_list", false, {declaration_list_node_child, comma_node, id_node}, NULL};

						parseTreeStack.pop();
						SetLine(declaration_list_node);
						parseTreeStack.push(declaration_list_node);
					}
 		            |   declaration_list COMMA ID LSQUARE CONST_INT RSQUARE
					{
						$3->SetIDType("VARIABLE");
						$3->SetArray(true);

						logStream << "declaration_list : declaration_list COMMA ID LSQUARE CONST_INT RSQUARE" << std::endl;

						ParseTreeNode declaration_list_node_child = parseTreeStack.top();

						parseTreeStack.pop();

						ParseTreeNode comma_node = {"COMMA", true, {}, $2};
						ParseTreeNode id_node = {"ID", true, {}, $3};
						ParseTreeNode lsquare_node = {"LSQUARE", true, {}, $4};
						ParseTreeNode const_int_node = {"CONST_INT", true, {}, $5};
						ParseTreeNode rsquare_node = {"RSQUARE", true, {}, $6};
						ParseTreeNode declaration_list_node = {"declaration_list", false, {declaration_list_node_child, comma_node, id_node, lsquare_node, const_int_node, rsquare_node}, NULL};

						SetLine(declaration_list_node);
						parseTreeStack.push(declaration_list_node);
					}
 		            |   ID
					{
						$1->SetIDType("VARIABLE");
						$1->SetArray(false);

						logStream << "declaration_list : ID" << std::endl;

						ParseTreeNode id_node = {"ID", true, {}, $1};
						ParseTreeNode declaration_list_node = {"declaration_list", false, {id_node}, NULL};
						
						SetLine(declaration_list_node);
						parseTreeStack.push(declaration_list_node);
					}
 		            |   ID LSQUARE CONST_INT RSQUARE
					{
						$1->SetIDType("VARIABLE");
						$1->SetArray(true);

						logStream << "declaration_list : ID LSQUARE CONST_INT RSQUARE" << std::endl;

						ParseTreeNode id_node = {"ID", true, {}, $1};
						ParseTreeNode lsquare_node = {"LSQUARE", true, {}, $2};
						ParseTreeNode const_int_node = {"CONST_INT", true, {}, $3};
						ParseTreeNode rsquare_node = {"RSQUARE", true, {}, $4};
						ParseTreeNode declaration_list_node = {"declaration_list", false, {id_node, lsquare_node, const_int_node, rsquare_node}, NULL};

						SetLine(declaration_list_node);
						parseTreeStack.push(declaration_list_node);
					}
 		            ;
 		  
statements  :   statement
			{
				logStream << "statements : statement" << std::endl;

				ParseTreeNode statement_node = parseTreeStack.top();

				parseTreeStack.pop();

				ParseTreeNode statements_node = {"statements", false, {statement_node}, NULL};

				SetLine(statements_node);
				parseTreeStack.push(statements_node);
			}
	        |   statements statement
			{
				logStream << "statements : statements statement" << std::endl;

				ParseTreeNode statement_node = parseTreeStack.top();
				
				parseTreeStack.pop();

				ParseTreeNode statements_node_child = parseTreeStack.top();

				parseTreeStack.pop();

				ParseTreeNode statements_node = {"statements", false, {statements_node_child, statement_node}, NULL};

				SetLine(statements_node);
				parseTreeStack.push(statements_node);
			}
	        ;

statement	:   var_declaration
			{
				logStream << "statement : var_declaration" << std::endl;

				ParseTreeNode var_declaration_node = parseTreeStack.top();

				parseTreeStack.pop();

				ParseTreeNode statement_node = {"statement", false, {var_declaration_node}, NULL};

				SetLine(statement_node);
				parseTreeStack.push(statement_node);
			}
			|   expression_statement
			{
				logStream << "statement : expression_statement" << std::endl;

				ParseTreeNode expression_statement_node = parseTreeStack.top();

				parseTreeStack.pop();

				ParseTreeNode statement_node = {"statement", false, {expression_statement_node}, NULL};

				SetLine(statement_node);
				parseTreeStack.push(statement_node);
			}
			|   compound_statement
			{
				st->PrintAllScope();
				st->ExitScope();

				logStream << "statement : compound_statement" << std::endl;

				ParseTreeNode compound_statement_node = parseTreeStack.top();

				parseTreeStack.pop();

				ParseTreeNode statement_node = {"statement", false, {compound_statement_node}, NULL};

				SetLine(statement_node);
				parseTreeStack.push(statement_node);
			}
			|   FOR 
			{
				st->EnterScope();
			}
			LPAREN expression_statement expression_statement expression RPAREN statement
			{
				logStream << "statement : FOR LPAREN expression_statement expression_statement expression RPAREN statement" << std::endl;

				ParseTreeNode statement_node_child = parseTreeStack.top();

				parseTreeStack.pop();

				ParseTreeNode expression_node = parseTreeStack.top();

				parseTreeStack.pop();

				ParseTreeNode expression_statement_node2 = parseTreeStack.top();

				parseTreeStack.pop();

				ParseTreeNode expression_statement_node1 = parseTreeStack.top();

				parseTreeStack.pop();

				ParseTreeNode for_node = {"FOR", true, {}, $1};
				ParseTreeNode lparen_node = {"LPAREN", true, {}, $2};
				ParseTreeNode rparen_node = {"RPAREN", true, {}, $6};
				ParseTreeNode statement_node = {"statement", false, {for_node, lparen_node, expression_statement_node1, expression_statement_node2, expression_node, rparen_node, statement_node_child}, NULL};

				SetLine(statement_node);
				parseTreeStack.push(statement_node);
			}
			|   WHILE
			{
				st->EnterScope();
			}
			LPAREN expression RPAREN statement
			{
				logStream << "statement : WHILE LPAREN expression RPAREN statement" << std::endl;

				ParseTreeNode statement_node_child = parseTreeStack.top();

				parseTreeStack.pop();

				ParseTreeNode expression_node = parseTreeStack.top();

				parseTreeStack.pop();

				ParseTreeNode while_node = {"WHILE", true, {}, $1};
				ParseTreeNode lparen_node = {"LPAREN", true, {}, $2};
				ParseTreeNode rparen_node = {"RPAREN", true, {}, $4};
				ParseTreeNode statement_node = {"statement", false, {while_node, lparen_node, expression_node, rparen_node, statement_node_child}, NULL};

				SetLine(statement_node);
				parseTreeStack.push(statement_node);
			}
			|   RETURN expression SEMICOLON
			{
				logStream << "statement : RETURN expression SEMICOLON" << std::endl;

				ParseTreeNode expression_node = parseTreeStack.top();

				parseTreeStack.pop();

				ParseTreeNode return_node = {"RETURN", true, {}, $1};
				ParseTreeNode semicolon_node = {"SEMICOLON", true, {}, $3};
				ParseTreeNode statement_node = {"statement", false, {return_node, expression_node, semicolon_node}, NULL};

				SetLine(statement_node);
				parseTreeStack.push(statement_node);
			}
			| IF LPAREN expression RPAREN statement
			{
				logStream << "statement : IF LPAREN expression RPAREN statement" << std::endl;

				ParseTreeNode statement_node_child = parseTreeStack.top();

				parseTreeStack.pop();

				ParseTreeNode expression_node = parseTreeStack.top();

				parseTreeStack.pop();

				ParseTreeNode if_node = {"IF", true, {}, $1};
				ParseTreeNode lparen_node = {"LPAREN", true, {}, $2};
				ParseTreeNode rparen_node = {"RPAREN", true, {}, $4};
				ParseTreeNode statement_node = {"statement", false, {if_node, lparen_node, expression_node, rparen_node, statement_node_child}, NULL};

				SetLine(statement_node);
				parseTreeStack.push(statement_node);
			}
	  		| IF LPAREN expression RPAREN statement ELSE
			{
				st->EnterScope();
			}
			statement
			{
				logStream << "statement : IF LPAREN expression RPAREN statement ELSE statement" << std::endl;

				ParseTreeNode statement_node2 = parseTreeStack.top();

				parseTreeStack.pop();

				ParseTreeNode statement_node1 = parseTreeStack.top();

				parseTreeStack.pop();

				ParseTreeNode expression_node = parseTreeStack.top();

				parseTreeStack.pop();

				ParseTreeNode if_node = {"IF", true, {}, $1};
				ParseTreeNode lparen_node = {"LPAREN", true, {}, $2};
				ParseTreeNode rparen_node = {"RPAREN", true, {}, $4};
				ParseTreeNode else_node = {"ELSE", true, {}, $6};
				ParseTreeNode statement_node = {"statement", false, {if_node, lparen_node, expression_node, rparen_node, statement_node1, else_node, statement_node2}, NULL};

				SetLine(statement_node);
				parseTreeStack.push(statement_node);
			}
			;
	  
expression_statement    :   SEMICOLON
						{
							logStream << "expression_statement : SEMICOLON" << std::endl;

							ParseTreeNode semicolon_node = {"SEMICOLON", true, {}, $1};
							ParseTreeNode expression_statement_node = {"expression_statement", false, {semicolon_node}, NULL};

							SetLine(expression_statement_node);
							parseTreeStack.push(expression_statement_node);
						}
			            |   expression SEMICOLON
						{
							logStream << "expression_statement : expression SEMICOLON" << std::endl;

							ParseTreeNode expression_node = parseTreeStack.top();

							parseTreeStack.pop();

							ParseTreeNode semicolon_node = {"SEMICOLON", true, {}, $2};
							ParseTreeNode expression_statement_node = {"expression_statement", false, {expression_node, semicolon_node}, NULL};

							SetLine(expression_statement_node);
							parseTreeStack.push(expression_statement_node);
						}
			            ;
	  
variable    :   ID
			{
				logStream << "variable : ID" << std::endl;

				SymbolInfo *variablePtr = st->LookUp($2->GetName());

				if(variablePtr == NULL)
				{
					// undeclared variable
				}
				else
				{
					if(variablePtr->GetIDType() == "FUNCTION")
					{
						// undeclared variable
					}
					else
					{

					}
				}

				ParseTreeNode id_node = {"ID", true, {}, $1};
				ParseTreeNode variable_node = {"variable", false, {id_node}, NULL};

				SetLine(variable_node);
				parseTreeStack.push(variable_node);
			}
	        |   ID LSQUARE expression RSQUARE
			{
				logStream << "variable : ID LSQUARE expression RSQUARE" << std::endl;

				if(variablePtr == NULL)
				{
					// undeclared variable
				}
				else
				{
					if(variablePtr->GetIDType() == "FUNCTION")
					{
						// undeclared variable
					}
					else
					{
						if(variablePtr->IsArray())
						{
							if(GetExpressionDataType(expression) == "int")
							{

							}
							else
							{
								// Array subscript is not an integer
							}
						}
						else
						{
							// not an array
						}
					}
				}

				ParseTreeNode expression_node = parseTreeStack.top();

				parseTreeStack.pop();

				ParseTreeNode id_node = {"ID", true, {}, $1};
				ParseTreeNode lsquare_node = {"LSQUARE", true, {}, $2};
				ParseTreeNode rsquare_node = {"RSQUARE", true, {}, $4};
				ParseTreeNode variable_node = {"variable", false, {id_node, lsquare_node, expression_node, rsquare_node}, NULL};

				SetLine(variable_node);
				parseTreeStack.push(variable_node);
			}
	        ;
	 
expression  :   logic_expression
			{
				logStream << "expression \t: logic_expression" << std::endl;

				ParseTreeNode logic_expression_node = parseTreeStack.top();

				parseTreeStack.pop();

				ParseTreeNode expression_node = {"expression", false, {logic_expression_node}, NULL};

				SetLine(expression_node);
				parseTreeStack.push(expression_node);
			}
	        |   variable ASSIGNOP logic_expression
			{
				logStream << "expression \t: variable ASSIGNOP logic_expression" << std::endl;

				ParseTreeNode logic_expression_node = parseTreeStack.top();

				parseTreeStack.pop();

				ParseTreeNode variable_node = parseTreeStack.top();

				parseTreeStack.pop();

				ParseTreeNode assignop_node = {"ASSIGNOP", true, {}, $2};
				ParseTreeNode expression_node = {"expression", false, {variable_node, assignop_node, logic_expression_node}, NULL};

				SetLine(expression_node);
				parseTreeStack.push(expression_node);
			}
	        ;
			
logic_expression    :   rel_expression
					{
						logStream << "logic_expression : rel_expression" << std::endl;

						ParseTreeNode rel_expression_node = parseTreeStack.top();

						parseTreeStack.pop();

						ParseTreeNode logic_expression_node = {"logic_expression", false, {rel_expression_node}, NULL};

						SetLine(logic_expression_node);
						parseTreeStack.push(logic_expression_node);
					}
		            |   rel_expression LOGICOP rel_expression
					{
						logStream << "logic_expression : rel_expression LOGICOP rel_expression" << std::endl;

						ParseTreeNode rel_expression_node2 = parseTreeStack.top();

						parseTreeStack.pop();

						ParseTreeNode rel_expression_node1 = parseTreeStack.top();

						parseTreeStack.pop();

						ParseTreeNode logicop_node = {"LOGICOP", true, {}, $2};
						ParseTreeNode logic_expression_node = {"logic_expression", false, {rel_expression_node1, logicop_node, rel_expression_node2}, NULL};

						SetLine(logic_expression_node);
						parseTreeStack.push(logic_expression_node);
					}
		            ;
			
rel_expression  :   simple_expression
				{
					logStream << "rel_expression\t: simple_expression" << std::endl;

					ParseTreeNode simple_expression_node = parseTreeStack.top();

					parseTreeStack.pop();

					ParseTreeNode rel_expression_node = {"rel_expression", false, {simple_expression_node}, NULL};

					SetLine(rel_expression_node);
					parseTreeStack.push(rel_expression_node);
				}
		        |   simple_expression RELOP simple_expression
				{
					logStream << "rel_expression\t: simple_expression RELOP simple_expression" << std::endl;

					ParseTreeNode simple_expression_node2 = parseTreeStack.top();

					parseTreeStack.pop();

					ParseTreeNode simple_expression_node1 = parseTreeStack.top();

					parseTreeStack.pop();

					ParseTreeNode relop_node = {"RELOP", true, {}, $2};
					ParseTreeNode rel_expression_node = {"rel_expression", false, {simple_expression_node1, relop_node, simple_expression_node2}, NULL};

					SetLine(rel_expression_node);
					parseTreeStack.push(rel_expression_node);
				}
		        ;
				
simple_expression   :   term
					{
						logStream << "simple_expression : term" << std::endl;

						ParseTreeNode term_node = parseTreeStack.top();

						parseTreeStack.pop();

						ParseTreeNode simple_expression_node = {"simple_expression", false, {term_node}, NULL};

						SetLine(simple_expression_node);
						parseTreeStack.push(simple_expression_node);
					}
		            |   simple_expression ADDOP term
					{
						logStream << "simple_expression : simple_expression ADDOP term" << std::endl;

						ParseTreeNode term_node = parseTreeStack.top();

						parseTreeStack.pop();

						ParseTreeNode simple_expression_node_child = parseTreeStack.top();

						parseTreeStack.pop();

						ParseTreeNode addop_node = {"ADDOP", true, {}, $2};
						ParseTreeNode simple_expression_node = {"simple_expression", false, {simple_expression_node_child, addop_node, term_node}, NULL};

						SetLine(simple_expression_node);
						parseTreeStack.push(simple_expression_node);
					}
		            ;
					
term    :	unary_expression
		{
			logStream << "term :\tunary_expression" << std::endl;

			ParseTreeNode unary_expression_node = parseTreeStack.top();

			parseTreeStack.pop();

			ParseTreeNode term_node = {"term", false, {unary_expression_node}, NULL};

			SetLine(term_node);
			parseTreeStack.push(term_node);
		}
        |   term MULOP unary_expression
		{
			logStream << "term :\tterm MULOP unary_expression" << std::endl;

			ParseTreeNode unary_expression_node = parseTreeStack.top();

			parseTreeStack.pop();

			ParseTreeNode term_node_child = parseTreeStack.top();

			parseTreeStack.pop();

			ParseTreeNode mulop_node = {"MULOP", true, {}, $2};
			ParseTreeNode term_node = {"term", false, {term_node_child, mulop_node, unary_expression_node}, NULL};

			SetLine(term_node);
			parseTreeStack.push(term_node);
		}
        ;

unary_expression    :   ADDOP unary_expression
					{
						logStream << "unary_expression : ADDOP unary_expression" << std::endl;

						ParseTreeNode unary_expression_node_child = parseTreeStack.top();

						parseTreeStack.pop();

						ParseTreeNode addop_node = {"ADDOP", true, {}, $1};
						ParseTreeNode unary_expression_node = {"unary_expression", false, {addop_node, unary_expression_node_child}, NULL};

						SetLine(unary_expression_node);
						parseTreeStack.push(unary_expression_node);
					}
		            |   NOT unary_expression
					{
						logStream << "unary_expression : NOT unary_expression" << std::endl;

						ParseTreeNode unary_expression_node_child = parseTreeStack.top();

						parseTreeStack.pop();

						ParseTreeNode not_node = {"NOT", true, {}, $1};
						ParseTreeNode unary_expression_node = {"unary_expression", false, {not_node, unary_expression_node_child}, NULL};

						SetLine(unary_expression_node);
						parseTreeStack.push(unary_expression_node);
					}
		            |   factor
					{
						logStream << "unary_expression : factor" << std::endl;

						ParseTreeNode factor_node = parseTreeStack.top();

						parseTreeStack.pop();

						ParseTreeNode unary_expression_node = {"unary_expression", false, {factor_node}, NULL};

						SetLine(unary_expression_node);
						parseTreeStack.push(unary_expression_node);
					}
		            ;
	
factor  :   variable
		{
			logStream << "factor\t: variable" << std::endl;

			ParseTreeNode variable_node = parseTreeStack.top();

			parseTreeStack.pop();

			ParseTreeNode factor_node = {"factor", false, {variable_node}, NULL};

			SetLine(factor_node);
			parseTreeStack.push(factor_node);
		}
	    |   ID LPAREN argument_list RPAREN
		{
			SymbolInfo *function = st->LookUpFunction($1->GetName());

			if(function == NULL)
			{
				// undeclared function
			}

			logStream << "factor\t: ID LPAREN argument_list RPAREN" << std::endl;

			ParseTreeNode argument_list_node = parseTreeStack.top();

			parseTreeStack.pop();

			ParseTreeNode id_node = {"ID", true, {}, $1};
			ParseTreeNode lparen_node = {"LPAREN", true, {}, $2};
			ParseTreeNode rparen_node = {"RPAREN", true, {}, $4};
			ParseTreeNode factor_node = {"factor", false, {id_node, lparen_node, argument_list_node, rparen_node}, NULL};

			SetLine(factor_node);
			parseTreeStack.push(factor_node);
		}
	    |   LPAREN expression RPAREN
		{
			logStream << "factor\t: LPAREN expression RPAREN" << std::endl;

			ParseTreeNode expression_node = parseTreeStack.top();

			parseTreeStack.pop();

			ParseTreeNode lparen_node = {"LPAREN", true, {}, $1};
			ParseTreeNode rparen_node = {"RPAREN", true, {}, $3};
			ParseTreeNode factor_node = {"factor", false, {lparen_node, expression_node, rparen_node}, NULL};

			SetLine(factor_node);
			parseTreeStack.push(factor_node);
		}
	    |   CONST_INT
		{
			logStream << "factor\t: CONST_INT" << std::endl;

			ParseTreeNode const_int_node = {"CONST_INT", true, {}, $1};
			ParseTreeNode factor_node = {"factor", false, {const_int_node}, NULL};

			SetLine(factor_node);
			parseTreeStack.push(factor_node);
		}
	    |   CONST_FLOAT
		{
			logStream << "factor\t: CONST_FLOAT" << std::endl;

			ParseTreeNode const_float_node = {"CONST_FLOAT", true, {}, $1};
			ParseTreeNode factor_node = {"factor", false, {const_float_node}, NULL};

			SetLine(factor_node);
			parseTreeStack.push(factor_node);
		}
	    |   variable INCOP
		{
			logStream << "factor\t: variable INCOP" << std::endl;

			ParseTreeNode variable_node = parseTreeStack.top();

			parseTreeStack.pop();

			ParseTreeNode incop_node = {"INCOP", true, {}, $2};
			ParseTreeNode factor_node = {"factor", false, {variable_node, incop_node}, NULL};

			SetLine(factor_node);
			parseTreeStack.push(factor_node);
		}
	    ;
	
argument_list   :   arguments
				{
					logStream << "argument_list : arguments" << std::endl;

					ParseTreeNode arguments_node = parseTreeStack.top();

					parseTreeStack.pop();

					ParseTreeNode argument_list_node = {"argument_list", false, {arguments_node}, NULL};

					SetLine(argument_list_node);
					parseTreeStack.push(argument_list_node);
				}
			    |
                ;
	
arguments   :   arguments COMMA logic_expression
			{
				logStream << "arguments : arguments COMMA logic_expression" << std::endl;

				ParseTreeNode logic_expression_node = parseTreeStack.top();

				parseTreeStack.pop();

				ParseTreeNode arguments_node_child = parseTreeStack.top();

				parseTreeStack.pop();

				ParseTreeNode comma_node = {"COMMA", true, {}, $2};
				ParseTreeNode arguments_node = {"arguments", false, {arguments_node_child, comma_node, logic_expression_node}, NULL};

				SetLine(arguments_node);
				parseTreeStack.push(arguments_node);
			}
	        |   logic_expression
			{
				logStream << "arguments : logic_expression" << std::endl;

				ParseTreeNode logic_expression_node = parseTreeStack.top();

				parseTreeStack.pop();

				ParseTreeNode arguments_node = {"arguments", false, {logic_expression_node}, NULL};

				SetLine(arguments_node);
				parseTreeStack.push(arguments_node);
			}
	        ;
 
%%

int main(int argc,char *argv[])
{
	parseTreeStream.open("1905039_parsetree.txt");
	logStream.open("1905039_log.txt");

	st = new SymbolTable(11, &logStream);
	FILE *fp = fopen(argv[1], "r");

	if(fp == NULL)
	{
		printf("Cannot Open Input File.\n");
		exit(1);
	}

	yyin = fp;

	yyparse();
	PrintParseTree(parseTreeStack.top(), 0);

	logStream << "Total Lines: " << lineCount << std::endl;
	logStream << "Total Errors: " << errorCount << std::endl;

	fclose(fp);
	parseTreeStream.close();
	logStream.close();
	
	return 0;
}