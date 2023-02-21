%{
#include <iostream>
#include <fstream>
#include <cstdlib>
#include <cstring>
#include <string>
#include <sstream>
#include <cmath>
#include <stack>
#include "1905039_SymbolTable.h"
#include "1905039_ParseTreeNode.h"
#include "1905039_Utils.h"

using namespace std;

SymbolTable *st;
// int yyparse(void);
int yylex(void);
extern FILE *yyin;
std::ofstream icgStream;
extern size_t lineCount;
extern size_t errorCount;
SymbolInfo *function;
SymbolInfo *present;
bool inVoidFunction;
bool functionReturns;
ParseTreeNode *root;
extern bool newScope;
bool endCompoundStatement;

void yyerror(char *s)
{
	
}

std::stack<ParseTreeNode> parseTreeStack;

std::string GetExpressionDataType(ParseTreeNode &root);

%}

%code requires
{
	#include "1905039_ParseTreeNode.h"
	#define YYSTYPE ParseTreeNode*
}

%token IF ELSE FOR WHILE DO BREAK INT CHAR FLOAT DOUBLE VOID RETURN SWITCH CASE DEFAULT CONTINUE ADDOP MULOP INCOP DECOP RELOP ASSIGNOP LOGICOP BITOP LPAREN RPAREN LCURL RCURL LSQUARE RSQUARE COMMA SEMICOLON CONST_INT CONST_FLOAT CONST_CHAR CONST_STRING ID PRINTLN
%nonassoc RPAREN
%nonassoc ELSE

%destructor
{
	DeleteTree($$);

	$$ = NULL;
}
<>

%%

start   :   program
	    {
			$$ = new ParseTreeNode();
			*$$ = {"start", false, {$1}, NULL};

			SetLine($$);

			// if(errorCount == 0)
			// {
			// 	GenerateICG($$);
			// }

			GenerateICG($$);
		}
	    ;

program :   program unit
        {
			$$ = new ParseTreeNode();
			*$$ = {"program", false, {$1, $2}, NULL};

			SetLine($$);
        }
	    |   unit
        {
            $$ = new ParseTreeNode();
			*$$ = {"program", false, {$1}, NULL};

			SetLine($$);
        }
	    ;
	
unit    :   var_declaration
		{
			$$ = new ParseTreeNode();
			*$$ = {"unit", false, {$1}, NULL};

			SetLine($$);
		}
        |   func_declaration
		{
			$$ = new ParseTreeNode();
			*$$ = {"unit", false, {$1}, NULL};

			SetLine($$);
		}
        |   func_definition
		{
			$$ = new ParseTreeNode();
			*$$ = {"unit", false, {$1}, NULL};

			SetLine($$);
		}
        ;
     
func_declaration    :	type_specifier ID LPAREN parameter_list RPAREN SEMICOLON
					{
						if($1->children[0]->name == "VOID")
						{
							inVoidFunction = true;
						}

						$2->symbolInfo->SetIDType("FUNCTION");
						$2->symbolInfo->SetArray(false);
						$2->symbolInfo->SetDataType($1->children[0]->name);
						
						present = st->LookUp($2->symbolInfo->GetName());
						function = $2->symbolInfo;

						if(present == NULL)
						{
							st->Insert($2->symbolInfo);

							std::vector<std::pair<std::string, std::string>> paramList;

							bool error = false;

							SetParams($4, paramList, error, false);
							function->SetParamList(paramList);
							function->SetDefined(false);
						}
						else
						{
							if(present->GetIDType() == "FUNCTION")
							{
								++errorCount;

								std::cerr << "Line " << $2->symbolInfo->GetSymbolStart() << ": Function already declared" << std::endl;
							}
							else
							{
								++errorCount;

								std::cerr << "Line " << $2->symbolInfo->GetSymbolStart() << ": Another identifier of same name" << std::endl;
							}
						}

						$$ = new ParseTreeNode();
						*$$ = {"func_declaration", false, {$1, $2, $3, $4, $5, $6}, NULL};
					
						SetLine($$);

						inVoidFunction = false;
						function = NULL;
						present = NULL;
					}
					|	type_specifier ID LPAREN error RPAREN SEMICOLON
					{
						++errorCount;

						std::cerr << "Line " << $2->symbolInfo->GetSymbolStart() << ": Invalid parameters" << std::endl;

						if($1->children[0]->name == "VOID")
						{
							inVoidFunction = true;
						}

						$2->symbolInfo->SetIDType("FUNCTION");
						$2->symbolInfo->SetArray(false);
						$2->symbolInfo->SetDataType($1->children[0]->name);
						
						present = st->LookUp($2->symbolInfo->GetName());
						function = $2->symbolInfo;

						if(present == NULL)
						{
							++errorCount;

							std::cerr << "Line " << $2->symbolInfo->GetSymbolStart() << ": Function already declared" << std::endl;
						}
						else
						{
							if(present->GetIDType() == "FUNCTION")
							{
								++errorCount;

								std::cerr << "Line " << $2->symbolInfo->GetSymbolStart() << ": Function already declared" << std::endl;	
							}
							else
							{
								++errorCount;

								std::cerr << "Line " << $2->symbolInfo->GetSymbolStart() << ": Another identifier of same name" << std::endl;
							}
						}

						SymbolInfo *errorInfo = new SymbolInfo("error", "parameter_list");

						errorInfo->SetSymbolStart($3->startLine);
						DeleteTree($6);

						$4 = new ParseTreeNode();
						*$4 = {"parameter_list", true, {}, errorInfo};
						$$ = new ParseTreeNode();
						*$$ = {"func_declaration", false, {$1, $2, $3, $4, $5}, NULL};
					
						SetLine($$);

						inVoidFunction = false;
						function = NULL;
						present = NULL;
					}
		            |	type_specifier ID LPAREN RPAREN SEMICOLON
					{
						if($1->children[0]->name == "VOID")
						{
							inVoidFunction = true;
						}

						$2->symbolInfo->SetIDType("FUNCTION");
						$2->symbolInfo->SetArray(false);
						$2->symbolInfo->SetDataType($1->children[0]->name);
						
						present = st->LookUp($2->symbolInfo->GetName());
						function = $2->symbolInfo;

						if(present == NULL)
						{
							st->Insert($2->symbolInfo);
							function->SetDefined(false);
						}
						else
						{
							if(present->GetIDType() == "FUNCTION")
							{
								++errorCount;

								std::cerr << "Line " << $2->symbolInfo->GetSymbolStart() << ": Function already declared" << std::endl;
							}
							else
							{
								++errorCount;

								std::cerr << "Line " << $2->symbolInfo->GetSymbolStart() << ": Another identifier of same name" << std::endl;
							}
						}

						$$ = new ParseTreeNode();
						*$$ = {"func_declaration", false, {$1, $2, $3, $4, $5}, NULL};
					
						SetLine($$);

						inVoidFunction = false;
						function = NULL;
						present = NULL;
					}
		            ;
		 
func_definition	:	type_specifier ID LPAREN parameter_list RPAREN
				{
					if($1->children[0]->name == "VOID")
					{
						inVoidFunction = true;
					}

					$2->symbolInfo->SetIDType("FUNCTION");
					$2->symbolInfo->SetArray(false);
					$2->symbolInfo->SetDataType($1->children[0]->name);
					
					present = st->LookUp($2->symbolInfo->GetName());
					function = $2->symbolInfo;

					if(present == NULL)
					{
						st->Insert($2->symbolInfo);
					}

					newScope = true;

					st->EnterScope();

					if(present == NULL)
					{
						std::vector<std::pair<std::string, std::string>> paramList;
						bool error = false;

						SetParams($4, paramList, error, true);
						function->SetParamList(paramList);
					}
					else
					{
						if(present->GetIDType() == "FUNCTION")
						{
							if(present->GetDefined())
							{
								++errorCount;

								std::cerr << "Line " << $2->symbolInfo->GetSymbolStart() << ": Function already defined" << std::endl;
							}
							else
							{
								std::vector<std::pair<std::string, std::string>> paramList;
								bool error = false;
					
								SetParams($4, paramList, error, true);

								if(present->GetDataType() == function->GetDataType())
								{
									bool ok = true;

									std::vector<std::pair<std::string, std::string>> presentParamList = present->GetParamList();

									if(paramList.size() == presentParamList.size())
									{
										for(size_t i = 0; i < paramList.size(); ++i)
										{
											if(paramList[i].first != presentParamList[i].first)
											{
												ok = false;

												break;
											}
										}

										if(ok)
										{
											present->SetDefined(true);
										}
										else
										{
											++errorCount;

											std::cerr << "Line " << ": Definition parameter does not match with declaration" << std::endl;
										}
									}
									else
									{
										++errorCount;
										ok = false;

										std::cerr << "Line " << $2->symbolInfo->GetSymbolStart() << ": Definition parameter does not match with declaration" << std::endl;
									}

									if(ok)
									{
										function->SetParamList(paramList);
									}
								}
								else
								{
									++errorCount;

									std::cerr << "Line " << $2->symbolInfo->GetSymbolStart() << ": Definition return type does not match declarration" << std::endl;
								}
							}
						}
						else
						{
							++errorCount;

							std::cerr << "Line " << $2->symbolInfo->GetSymbolStart() << ": Another identifier of same name" << std::endl;
						}
					}
				}
				compound_statement
				{
					$$ = new ParseTreeNode();
					*$$ = {"func_definition", false, {$1, $2, $3, $4, $5, $7}, NULL};
				
					SetLine($$);

					if(!inVoidFunction && !functionReturns)
					{
						++errorCount;

						std::cerr << "Line " << $2->symbolInfo->GetSymbolStart() << ": Non void function not returning anything" << std::endl;
					}

					functionReturns = false;
					inVoidFunction = false;
					function = NULL;
					present = NULL;

					st->ExitScope();
				}
				|	type_specifier ID LPAREN error RPAREN
				{
					++errorCount;

					std::cerr << "Line " << $2->symbolInfo->GetSymbolStart() << ": Invalid parameters" << std::endl;

					if($1->children[0]->name == "VOID")
					{
						inVoidFunction = true;
					}

					$2->symbolInfo->SetIDType("FUNCTION");
					$2->symbolInfo->SetArray(false);
					$2->symbolInfo->SetDataType($1->children[0]->name);
					
					present = st->LookUp($2->symbolInfo->GetName());
					function = $2->symbolInfo;

					if(present == NULL)
					{
						st->Insert($2->symbolInfo);
					}

					newScope = true;

					st->EnterScope();

					if(present == NULL)
					{

					}
					else
					{
						if(present->GetIDType() == "FUNCTION")
						{
							if(present->GetDefined())
							{
								++errorCount;

								std::cerr << "Line " << $2->symbolInfo->GetSymbolStart() << ": Redefinition of function" << std::endl;
							}
							else
							{
								if(present->GetDataType() == function->GetDataType())
								{
									
								}
								else
								{
									++errorCount;

									std::cerr << "Line " << $2->symbolInfo->GetSymbolStart() << ": Definition return type does not match declarration" << std::endl;
								}
							}
						}
						else
						{
							++errorCount;

							std::cerr << "Line " << $2->symbolInfo->GetSymbolStart() << ": Another identifier of same name" << std::endl;
						}
					}
				}
				compound_statement
				{
					SymbolInfo *errorInfo = new SymbolInfo("error", "parameter_list");
					errorInfo->SetSymbolStart($3->startLine);

					$4 = new ParseTreeNode();
					*$4 = {"parameter_list", true, {}, errorInfo};
					$$ = new ParseTreeNode();
					*$$ = {"func_declaration", false, {$1, $2, $3, $4, $5}, NULL};

					DeleteTree($7);				
					SetLine($$);

					if(!inVoidFunction && !functionReturns)
					{
						++errorCount;

						std::cerr << "Line " << $2->symbolInfo->GetSymbolStart() << ": Non void function not returning anything" << std::endl;						
					}

					functionReturns = false;
					inVoidFunction = false;
					function = NULL;
					present = NULL;

					st->ExitScope();
				}
				|	type_specifier ID LPAREN RPAREN
				{
					if($1->children[0]->name == "VOID")
					{
						inVoidFunction = true;
					}

					$2->symbolInfo->SetIDType("FUNCTION");
					$2->symbolInfo->SetArray(false);
					$2->symbolInfo->SetDataType($1->children[0]->name);
					
					present = st->LookUp($2->symbolInfo->GetName());
					function = $2->symbolInfo;

					if(present == NULL)
					{
						st->Insert($2->symbolInfo);
					}

					newScope = true;

					st->EnterScope();

					if(present == NULL)
					{
								
					}
					else
					{
						if(present->GetIDType() == "FUNCTION")
						{
							if(present->GetDefined())
							{
								++errorCount;

								std::cerr << "Line " << $2->symbolInfo->GetSymbolStart() << ": Redefinition of function" << std::endl;
							}
							else
							{
								if(present->GetDataType() == function->GetDataType())
								{
									std::vector<std::pair<std::string, std::string>> presentParamList = present->GetParamList();

									if(presentParamList.size() > 0)
									{
										++errorCount;

										std::cerr << "Line " << $2->symbolInfo->GetSymbolStart() << ": Missing parameters" << std::endl;
									}
									else
									{
										present->SetDefined(true);
									}
								}
								else
								{
									++errorCount;

									std::cerr << "Line " << $2->symbolInfo->GetSymbolStart() << ": Non void function not returning anything" << std::endl;
								}
							}
						}
						else
						{
							++errorCount;

							std::cerr << "Line " << $2->symbolInfo->GetSymbolStart() << ": Another identifier of same name" << std::endl;
						}
					}
				}
				compound_statement
				{
					function->SetDefined(true);

					$$ = new ParseTreeNode();
					*$$ = {"func_definition", false, {$1, $2, $3, $4, $6}, NULL};
				
					SetLine($$);

					if(!inVoidFunction && !functionReturns)
					{
						++errorCount;

						std::cerr << "Line " << $2->symbolInfo->GetSymbolStart() << ": Non void function not returning anything" << std::endl;
					}

					functionReturns = false;
					inVoidFunction = false;
					function = NULL;
					present = NULL;

					st->ExitScope();
				}
 				;

parameter_list	:	parameter_list COMMA type_specifier ID
				{
					$4->symbolInfo->SetIDType("VARIABLE");
					$4->symbolInfo->SetDataType($3->children[0]->name);
					$4->symbolInfo->SetArray(false);

					$$ = new ParseTreeNode();
					*$$ = {"parameter_list", false, {$1, $2, $3, $4}, NULL};

					SetLine($$);
				}
				|	parameter_list COMMA type_specifier
				{
					$$ = new ParseTreeNode();
					*$$ = {"parameter_list", false, {$1, $2, $3}, NULL};

					SetLine($$);
				}
 				|	type_specifier ID
				{
					$2->symbolInfo->SetIDType("VARIABLE");
					$2->symbolInfo->SetDataType($1->children[0]->name);
					$2->symbolInfo->SetArray(false);
					
					$$ = new ParseTreeNode();
					*$$ = {"parameter_list", false, {$1, $2}, NULL};

					SetLine($$);
				}
				|	type_specifier
				{					
					$$ = new ParseTreeNode();
					*$$ = {"parameter_list", false, {$1}, NULL};

					SetLine($$);
				}
 				;

lcurl	:	LCURL
		{
			$$ = $1;

			st->EnterScope();
		}

compound_statement	:	lcurl statements RCURL
					{
						$$ = new ParseTreeNode();
						*$$ = {"compound_statement", false, {$1, $2, $3}};

						SetLine($$);
						st->ExitScope();
					}
					|	lcurl error RCURL
					{
						SymbolInfo *errorInfo = new SymbolInfo("error", "statements");
						errorInfo->SetSymbolStart($1->startLine);

						$2 = new ParseTreeNode();
						*$2 = {"parameter_list", true, {}, errorInfo};
						$$ = new ParseTreeNode();
						*$$ = {"compound_statement", false, {$1, $2, $3}};
						++errorCount;

						std::cerr << "Line " << $3->symbolInfo->GetSymbolStart() << ": Invalid compund statement" << std::endl;

						SetLine($$);
						st->ExitScope();
					}
 		            |	lcurl RCURL
					{
						$$ = new ParseTreeNode();
						*$$ = {"compound_statement", false, {$1, $2}, NULL};

						SetLine($$);
						st->ExitScope();
					}
 		            ;
 		    
var_declaration :   type_specifier declaration_list SEMICOLON
				{					
					$$ = new ParseTreeNode();
					*$$ = {"var_declaration", false, {$1, $2, $3}, NULL};

					SetLine($$);

					// InsertID($2, $1->children[0]->name, st);

					std::vector<ParseTreeNode *> variables = GetDeclaredVariables($2);

					for(size_t i = 0; i < variables.size(); ++i)
					{
						variables[i]->symbolInfo->SetDataType($1->children[0]->name);

						if(!st->Insert(variables[i]->symbolInfo))
						{
							++errorCount;

							std::cout << "Line " << $3->symbolInfo->GetSymbolStart() << ": Identifier with same name already exists" << std::endl;
						}
					}
				}
				|	type_specifier error SEMICOLON
				{					
					SymbolInfo *errorInfo = new SymbolInfo("error", "declaration_list");
					errorInfo->SetSymbolStart($1->startLine);

					$2 = new ParseTreeNode();
					*$2 = {"declaration_list", true, {}, errorInfo};
					$$ = new ParseTreeNode();
					*$$ = {"var_declaration", false, {$1, $2, $3}, NULL};

					++errorCount;

					std::cerr << "Line " << $3->symbolInfo->GetSymbolStart() << ": Invalid variable declaration" << std::endl;

					SetLine($$);
				}
 		        ;
 		 
type_specifier  :   INT
				{
					$$ = new ParseTreeNode();
					*$$ = {"type_specifier", false, {$1}, NULL};
					
					SetLine($$);
				}
 		        |   FLOAT
				{
					$$ = new ParseTreeNode();
					*$$ = {"type_specifier", false, {$1}, NULL};
					
					SetLine($$);
				}
 		        |   VOID
				{
					$$ = new ParseTreeNode();
					*$$ = {"type_specifier", false, {$1}, NULL};
					
					SetLine($$);
				}
 		        ;
 		
declaration_list    :   declaration_list COMMA ID
					{
						$3->symbolInfo->SetIDType("VARIABLE");
						$3->symbolInfo->SetArray(false);

						$$ = new ParseTreeNode();
						*$$ = {"declaration_list", false, {$1, $2, $3}, NULL};

						SetLine($$);
					}
 		            |   declaration_list COMMA ID LSQUARE CONST_INT RSQUARE
					{
						$3->symbolInfo->SetIDType("VARIABLE");
						$3->symbolInfo->SetArray(true);

						std::stringstream ss($5->symbolInfo->GetName());
						size_t arraySize;

						ss >> arraySize;

						$3->symbolInfo->SetArraySize(arraySize);

						$$ = new ParseTreeNode();
						*$$ = {"declaration_list", false, {$1, $2, $3, $4, $5, $6}, NULL};

						SetLine($$);
					}
 		            |   ID
					{
						$1->symbolInfo->SetIDType("VARIABLE");
						$1->symbolInfo->SetArray(false);

						$$ = new ParseTreeNode();
						*$$ = {"declaration_list", false, {$1}, NULL};
						
						SetLine($$);
					}
 		            |   ID LSQUARE CONST_INT RSQUARE
					{
						$1->symbolInfo->SetIDType("VARIABLE");
						$1->symbolInfo->SetArray(true);

						std::stringstream ss($3->symbolInfo->GetName());
						size_t arraySize;

						ss >> arraySize;

						$1->symbolInfo->SetArraySize(arraySize);

						$$ = new ParseTreeNode();
						*$$ = {"declaration_list", false, {$1, $2, $3, $4}, NULL};

						SetLine($$);
					}
 		            ;

if_	: IF
	{
		$$ = $1;

		st->EnterScope();
	};
 		  
statements  :   statement
			{
				$$ = new ParseTreeNode();
				*$$ = {"statements", false, {$1}, NULL};

				SetLine($$);
			}
	        |   statements statement
			{
				$$ = new ParseTreeNode();
				*$$ = {"statements", false, {$1, $2}, NULL};

				SetLine($$);
			}
	        ;

statement	:   var_declaration
			{
				$$ = new ParseTreeNode();
				*$$ = {"statement", false, {$1}, NULL};

				SetLine($$);
			}
			|   expression_statement
			{
				$$ = new ParseTreeNode();
				*$$ = {"statement", false, {$1}, NULL};

				SetLine($$);
			}
			|   compound_statement
			{
				$$ = new ParseTreeNode();
				*$$ = {"statement", false, {$1}, NULL};

				SetLine($$);
			}
			|   FOR 
			{
				$1->symbolInfo->SetScopeID(st->GetCurrentScope()->GetID());

				newScope = true;

				st->EnterScope();
			}
			LPAREN expression_statement expression_statement expression RPAREN statement
			{
				$$ = new ParseTreeNode();
				*$$ = {"statement", false, {$1, $3, $4, $5, $6, $7, $8}, NULL};

				SetLine($$);

				// if(st->GetCurrentScope()->GetID() != $1->symbolInfo->GetScopeID())
				// {
				// 	st->ExitScope();
				// }

				st->ExitScope();
			}
			|   WHILE
			{
				$1->symbolInfo->SetScopeID(st->GetCurrentScope()->GetID());

				newScope = true;

				st->EnterScope();
			}
			LPAREN expression RPAREN statement
			{
				$$ = new ParseTreeNode();
				*$$ = {"statement", false, {$1, $3, $4, $5, $6}, NULL};

				SetLine($$);

				// if(st->GetCurrentScope()->GetID() != $1->symbolInfo->GetScopeID())
				// {
				// 	st->ExitScope();
				// }
				st->ExitScope();
			}
			|   RETURN expression SEMICOLON
			{
				if(inVoidFunction)
				{
					++errorCount;

					std::cerr << "Line " << $1->symbolInfo->GetSymbolStart() << ": Void function can have no return statement" << std::endl;
				}

				functionReturns = true;
				$$ = new ParseTreeNode();
				*$$ = {"statement", false, {$1, $2, $3}, NULL};

				SetLine($$);
			}
			| if_ LPAREN expression RPAREN statement
			{
				$$ = new ParseTreeNode();
				*$$ = {"statement", false, {$1, $2, $3, $4, $5}, NULL};

				SetLine($$);

				// if(st->GetCurrentScope()->GetID() != $1->symbolInfo->GetScopeID())
				// {
				// 	st->ExitScope();
				// }

				st->ExitScope();
			}
	  		| if_ LPAREN expression RPAREN statement ELSE
			{
				newScope = true;

				// if(st->GetCurrentScope()->GetID() != $1->symbolInfo->GetScopeID())
				// {
				// 	st->ExitScope();
				// }

				st->ExitScope();
				st->EnterScope();
			}
			statement
			{
				$$ = new ParseTreeNode();
				*$$ = {"statement", false, {$1, $2, $3, $4, $5, $6, $8}, NULL};

				SetLine($$);

				// if(st->GetCurrentScope()->GetID() != $1->symbolInfo->GetScopeID())
				// {
				// 	st->ExitScope();
				// }

				st->ExitScope();
			}
			|	PRINTLN LPAREN variable RPAREN SEMICOLON
			{
				SymbolInfo *variablePtr = st->LookUp($3->children[0]->symbolInfo->GetName());

				if(variablePtr == NULL)
				{
					++errorCount;

					std::cerr << "Line " << $1->symbolInfo->GetSymbolStart() << ": Variable not declared" << std::endl;
				}

				$$ = new ParseTreeNode();
				*$$ = {"statement", false, {$1, $2, $3, $4, $5}, NULL};

				SetLine($$);
			}
			;
	  
expression_statement    :   SEMICOLON
						{
							$$ = new ParseTreeNode();
							*$$ = {"expression_statement", false, {$1}, NULL};

							SetLine($$);
						}
			            |   expression SEMICOLON
						{
							GetExpressionDataType($1);

							$$ = new ParseTreeNode();
							*$$ = {"expression_statement", false, {$1, $2}, NULL};

							SetLine($$);
						}
						|	error SEMICOLON
						{
							SymbolInfo *errorInfo = new SymbolInfo("error", "expression");
							errorInfo->SetSymbolStart($2->startLine);

							$1 = new ParseTreeNode();
							*$1 = {"expression", true, {}, errorInfo};
							$$ = new ParseTreeNode();
							*$$ = {"expression_statement", false, {$1, $2}, NULL};
							++errorCount;

							std::cerr << "Line " << $2->symbolInfo->GetSymbolStart() << ": Invalid expression statement" << std::endl;

							SetLine($$);
						}
			            ;
	  
variable    :   ID
			{
				SymbolInfo *variablePtr = st->LookUp($1->symbolInfo->GetName());

				$$ = new ParseTreeNode();
				*$$ = {"variable", false, {$1}, NULL};

				SetLine($$);
			}
	        |   ID LSQUARE expression RSQUARE
			{
				SymbolInfo *variablePtr = st->LookUp($1->symbolInfo->GetName());

				if(variablePtr == NULL)
				{
					++errorCount;

					std::cerr << "Line " << $1->symbolInfo->GetSymbolStart() << ": Undeclared variable" << std::endl;
				}
				else
				{
					if(variablePtr->GetIDType() == "FUNCTION")
					{
						++errorCount;

						std::cerr << "Line " << $1->symbolInfo->GetSymbolStart() << ": Undeclared variable" << std::endl;
					}
					else
					{
						if(variablePtr->IsArray())
						{
							if(GetExpressionDataType($3) == "INT")
							{
								
							}
							else
							{
								++errorCount;

								std::cerr << "Line " << $1->symbolInfo->GetSymbolStart() << ": Array index not integer" << std::endl;
							}
						}
						else
						{
							++errorCount;

							std::cerr << "Line " << $1->symbolInfo->GetSymbolStart() << ": Not an array" << std::endl;
						}
					}
				}

				$$ = new ParseTreeNode();
				*$$ = {"variable", false, {$1, $2, $3, $4}, NULL};

				SetLine($$);
			}
	        ;
	 
expression  :   logic_expression
			{
				$$ = new ParseTreeNode();
				*$$ = {"expression", false, {$1}, NULL};

				SetLine($$);
			}
	        |   variable ASSIGNOP logic_expression
			{
				$$ = new ParseTreeNode();
				*$$ = {"expression", false, {$1, $2, $3}, NULL};

				SetLine($$);
			}
	        ;
			
logic_expression    :   rel_expression
					{
						$$ = new ParseTreeNode();
						*$$ = {"logic_expression", false, {$1}, NULL};

						SetLine($$);
					}
		            |   rel_expression LOGICOP rel_expression
					{
						$$ = new ParseTreeNode();
						*$$ = {"logic_expression", false, {$1, $2, $3}, NULL};

						SetLine($$);
					}
		            ;
			
rel_expression  :   simple_expression
				{
					$$ = new ParseTreeNode();
					*$$ = {"rel_expression", false, {$1}, NULL};

					SetLine($$);
				}
		        |   simple_expression RELOP simple_expression
				{
					$$ = new ParseTreeNode();
					*$$ = {"rel_expression", false, {$1, $2, $3}, NULL};

					SetLine($$);
				}
		        ;
				
simple_expression   :   term
					{
						$$ = new ParseTreeNode();
						*$$ = {"simple_expression", false, {$1}, NULL};

						SetLine($$);
					}
		            |   simple_expression ADDOP term
					{
						$$ = new ParseTreeNode();
						*$$ = {"simple_expression", false, {$1, $2, $3}, NULL};

						SetLine($$);
					}
		            ;
					
term    :	unary_expression
		{
			$$ = new ParseTreeNode();
			*$$ = {"term", false, {$1}, NULL};

			SetLine($$);
		}
        |   term MULOP unary_expression
		{
			$$ = new ParseTreeNode();
			*$$ = {"term", false, {$1, $2, $3}, NULL};

			SetLine($$);
		}
        ;

unary_expression    :   ADDOP unary_expression
					{
						$$ = new ParseTreeNode();
						*$$ = {"unary_expression", false, {$1, $2}, NULL};

						SetLine($$);
					}
		            |   LOGICOP unary_expression
					{
						$$ = new ParseTreeNode();
						*$$ = {"unary_expression", false, {$1, $2}, NULL};

						SetLine($$);
					}
		            |   factor
					{
						$$ = new ParseTreeNode();
						*$$ = {"unary_expression", false, {$1}, NULL};

						SetLine($$);
					}
		            ;
	
factor  :   variable
		{
			$$ = new ParseTreeNode();
			*$$ = {"factor", false, {$1}, NULL};

			SetLine($$);
		}
	    |   ID LPAREN argument_list RPAREN
		{
			SymbolInfo *function = st->LookUpFunction($1->symbolInfo->GetName());

			if(function == NULL)
			{
				std::vector<std::string> argumentTypeList;

				++errorCount;

				if($3->children.size() > 0)
				{
					SetArgumentTypeList($3->children[0], argumentTypeList);
				}
			}
			else
			{
				std::vector<std::pair<std::string, std::string>> paramList = function->GetParamList();
				std::vector<std::string> argumentTypeList;

				if($3->children.size() > 0)
				{
					SetArgumentTypeList($3->children[0], argumentTypeList);
				}

				if(argumentTypeList.size() > paramList.size())
				{
					++errorCount;

					std::cerr << "Line " << $1->symbolInfo->GetSymbolStart() << ": Too many arguments" << std::endl;
				}
				else if(argumentTypeList.size() < paramList.size())
				{
					++errorCount;

					std::cerr << "Line " << $1->symbolInfo->GetSymbolStart() << ": Too few arguments" << std::endl;
				}
				else
				{
					for(size_t i = 0; i < paramList.size(); ++i)
					{
						if(argumentTypeList[i] != "" && paramList[i].first != argumentTypeList[i])
						{
							++errorCount;

							std::cerr << "Line " << $1->symbolInfo->GetSymbolStart() << ": Unmatched arguments" << std::endl;
						}
					}
				}
			}

			$$ = new ParseTreeNode();

			if($3->children.size() == 0)
			{
				*$$ = {"factor", false, {$1, $2, $4}, NULL};
			}
			else
			{
				*$$ = {"factor", false, {$1, $2, $3, $4}, NULL};
			}

			SetLine($$);
		}
	    |   LPAREN expression RPAREN
		{
			$$ = new ParseTreeNode();
			*$$ = {"factor", false, {$1, $2, $3}, NULL};

			SetLine($$);
		}
	    |   CONST_INT
		{
			$$ = new ParseTreeNode();
			*$$ = {"factor", false, {$1}, NULL};

			SetLine($$);
		}
	    |   CONST_FLOAT
		{
			$$ = new ParseTreeNode();
			*$$ = {"factor", false, {$1}, NULL};

			SetLine($$);
		}
	    |   variable INCOP
		{
			$$ = new ParseTreeNode();
			*$$ = {"factor", false, {$1, $2}, NULL};

			SetLine($$);
		}
		| variable DECOP
		{
			$$ = new ParseTreeNode();
			*$$ = {"factor", false, {$1, $2}, NULL};

			SetLine($$);
		}
	    ;
	
argument_list   :   arguments
				{
					$$ = new ParseTreeNode();
					*$$ = {"argument_list", false, {$1}, NULL};

					SetLine($$);
				}
			    |	arguments error
				{
					SymbolInfo *errorInfo = new SymbolInfo("error", "arguments");
					errorInfo->SetSymbolStart($1->startLine);

					$2 = new ParseTreeNode();
					*$2 = {"parameter_list", true, {}, errorInfo};
					$$ = new ParseTreeNode();
					*$$ = {"argument_list", false, {$1, $2}, NULL};

					++errorCount;

					std::cerr << "Line " << $1->startLine << ": Invalid arguments" << std::endl;

					SetLine($$);
				}
				|
				{
					$$ = new ParseTreeNode();
					*$$ = {"argument_list", false, {}, NULL};

					SetLine($$);
				}
                ;
	
arguments   :   arguments COMMA logic_expression
			{
				$$ = new ParseTreeNode();
				*$$ = {"arguments", false, {$1, $2, $3}, NULL};

				SetLine($$);
			}
	        |   logic_expression
			{
				$$ = new ParseTreeNode();
				*$$ = {"arguments", false, {$1}, NULL};

				SetLine($$);
			}
	        ;
 
%%

int main(int argc,char *argv[])
{
	endCompoundStatement = false;
	newScope = false;
	functionReturns = false;
	inVoidFunction = false;

	icgStream.open("1905039_i_code.asm");

	st = new SymbolTable(11, NULL);
	FILE *fp = fopen(argv[1], "r");

	if(fp == NULL)
	{
		printf("Cannot Open Input File.\n");
		exit(1);
	}

	yyin = fp;

	yyparse();

	fclose(fp);
	icgStream.close();

	// DeleteTree(root);
	delete st;
	
	return 0;
}