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
std::ofstream parseTreeStream;
std::ofstream errorStream;
extern std::ofstream logStream;
extern size_t lineCount;
extern size_t errorCount;
SymbolInfo *function;
SymbolInfo *present;
bool inVoidFunction;
bool functionReturns;
ParseTreeNode *root;

void yyerror(char *s)
{
	logStream << "Error at line no " << lineCount << " : syntax error" << std::endl;
}

std::stack<ParseTreeNode> parseTreeStack;

std::string GetExpressionDataType(ParseTreeNode &root);

%}

%code requires
{
	#include "1905039_ParseTreeNode.h"
	#define YYSTYPE ParseTreeNode*
}

%token IF ELSE FOR WHILE DO BREAK INT CHAR FLOAT DOUBLE VOID RETURN SWITCH CASE DEFAULT CONTINUE ADDOP MULOP INCOP RELOP ASSIGNOP LOGICOP BITOP NOT LPAREN RPAREN LCURL RCURL LSQUARE RSQUARE COMMA SEMICOLON CONST_INT CONST_FLOAT CONST_CHAR CONST_STRING ID
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
			logStream << "start : program" << std::endl;

			$$ = new ParseTreeNode();
			*$$ = {"start", false, {$1}, NULL};
			// root = $$;

			SetLine($$);
			PrintParseTree($$, 0);
		}
	    ;

program :   program unit
        {
			logStream << "program : program unit" << std::endl;

			$$ = new ParseTreeNode();
			*$$ = {"program", false, {$1, $2}, NULL};

			SetLine($$);
        }
	    |   unit
        {
			logStream << "program : unit" << std::endl;

            $$ = new ParseTreeNode();
			*$$ = {"program", false, {$1}, NULL};

			SetLine($$);
        }
	    ;
	
unit    :   var_declaration
		{
			logStream << "unit : var_declaration" << std::endl;

			$$ = new ParseTreeNode();
			*$$ = {"unit", false, {$1}, NULL};

			SetLine($$);
		}
        |   func_declaration
		{
			logStream << "unit : func_declaration" << std::endl;

			$$ = new ParseTreeNode();
			*$$ = {"unit", false, {$1}, NULL};

			SetLine($$);
		}
        |   func_definition
		{
			logStream << "unit : func_definition" << std::endl;

			$$ = new ParseTreeNode();
			*$$ = {"unit", false, {$1}, NULL};

			SetLine($$);
		}
        ;
     
func_declaration    :	type_specifier ID LPAREN parameter_list RPAREN SEMICOLON
					{
						logStream << "func_declaration : type_specifier ID LPAREN parameter_list RPAREN SEMICOLON" << std::endl;

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
								errorStream << "Line# " << function->GetSymbolStart() << ": Redefinition of function \'" << function->GetName() << "\'" << std::endl;

								++errorCount;	
							}
							else
							{
								errorStream << "Line# " << function->GetSymbolStart() << ": \'" << function->GetName() << "\' redeclared as different kind of symbol" << std::endl;

								++errorCount;
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
						errorStream << "Line# " << $2->startLine << ": Syntax error at parameter list of function declaration" << std::endl;

						++errorCount;

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
							
						}
						else
						{
							if(present->GetIDType() == "FUNCTION")
							{
								errorStream << "Line# " << function->GetSymbolStart() << ": Redefinition of function \'" << function->GetName() << "\'" << std::endl;

								++errorCount;	
							}
							else
							{
								errorStream << "Line# " << function->GetSymbolStart() << ": \'" << function->GetName() << "\' redeclared as different kind of symbol" << std::endl;

								++errorCount;
							}
						}

						SymbolInfo *errorInfo = new SymbolInfo("error", "parameter_list");
						errorInfo->SetSymbolStart($3->startLine);

						// DeleteTree($4);
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
						logStream << "func_declaration : type_specifier ID LPAREN RPAREN SEMICOLON" << std::endl;

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
								errorStream << "Line# " << function->GetSymbolStart() << ": Redefinition of function \'" << function->GetName() << "\'" << std::endl;

								++errorCount;
							}
							else
							{
								errorStream << "Line# " << function->GetSymbolStart() << ": \'" << function->GetName() << "\' redeclared as different kind of symbol" << std::endl;

								++errorCount;
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
								errorStream << "Line# " << function->GetSymbolStart() << ": Redefinition of function \'" << function->GetName() << "\'" << std::endl;

								++errorCount;
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
										for(size_t i = 0; paramList.size(); ++i)
										{
											if(paramList[i] != presentParamList[i])
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
											errorStream << "Line# " << function->GetSymbolStart() << ": Conflicting types for \'" << function->GetName() << "\'" << std::endl;

											++errorCount;
										}
									}
									else
									{
										errorStream << "Line# " << function->GetSymbolStart() << ": Conflicting types for \'" << function->GetName() << "\'" << std::endl;

										++errorCount;
										ok = false;
									}

									if(ok)
									{
										function->SetParamList(paramList);
									}
								}
								else
								{
									errorStream << "Line# " << function->GetSymbolStart() << ": Conflicting types for \'" << function->GetName() << "\'" << std::endl;

									++errorCount;
								}
							}
						}
						else
						{
							errorStream << "Line# " << function->GetSymbolStart() << ": \'" << function->GetName() << "\' redeclared as different kind of symbol" << std::endl;

							++errorCount;
						}
					}
				}
				compound_statement
				{
					$$ = new ParseTreeNode();
					*$$ = {"func_definition", false, {$1, $2, $3, $4, $5, $7}, NULL};
				
					SetLine($$);
					st->PrintAllScope();
					st->ExitScope();

					logStream << "func_definition : type_specifier ID LPAREN parameter_list RPAREN compound_statement" << std::endl;

					if(!inVoidFunction && !functionReturns)
					{
						errorStream << "Line# " << function->GetSymbolStart() << ": Function \'" << function->GetName() << "\' should return something" << std::endl;

						++errorCount;
					}

					functionReturns = false;
					inVoidFunction = false;
					function = NULL;
					present = NULL;
				}
				|	type_specifier ID LPAREN error RPAREN
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
								errorStream << "Line# " << function->GetSymbolStart() << ": Redefinition of function \'" << function->GetName() << "\'" << std::endl;

								++errorCount;
							}
							else
							{
								if(present->GetDataType() == function->GetDataType())
								{
									
								}
								else
								{
									errorStream << "Line# " << function->GetSymbolStart() << ": Conflicting types for \'" << function->GetName() << "\'" << std::endl;

									++errorCount;
								}
							}
						}
						else
						{
							errorStream << "Line# " << function->GetSymbolStart() << ": \'" << function->GetName() << "\' redeclared as different kind of symbol" << std::endl;

							++errorCount;
						}
					}
				}
				compound_statement
				{
					errorStream << "Line# " << $2->startLine << ": Syntax error at parameter list of function definition" << std::endl;

					++errorCount;

					SymbolInfo *errorInfo = new SymbolInfo("error", "parameter_list");
					errorInfo->SetSymbolStart($3->startLine);

					// DeleteTree($4);

					$4 = new ParseTreeNode();
					*$4 = {"parameter_list", true, {}, errorInfo};
					$$ = new ParseTreeNode();
					*$$ = {"func_declaration", false, {$1, $2, $3, $4, $5}, NULL};

					DeleteTree($7);				
					SetLine($$);
					st->PrintAllScope();
					st->ExitScope();

					if(!inVoidFunction && !functionReturns)
					{
						errorStream << "Line# " << function->GetSymbolStart() << ": Function \'" << function->GetName() << "\' should return something" << std::endl;

						++errorCount;
					}

					functionReturns = false;
					inVoidFunction = false;
					function = NULL;
					present = NULL;
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
								errorStream << "Line# " << function->GetSymbolStart() << ": Redefinition of function \'" << function->GetName() << "\'" << std::endl;

								++errorCount;
							}
							else
							{
								if(present->GetDataType() == function->GetDataType())
								{
									std::vector<std::pair<std::string, std::string>> presentParamList = present->GetParamList();

									if(presentParamList.size() > 0)
									{
										errorStream << "Line# " << function->GetSymbolStart() << ": Conflicting types for \'" << function->GetName() << "\'" << std::endl;

										++errorCount;
									}
									else
									{
										present->SetDefined(true);
									}
								}
								else
								{
									errorStream << "Line# " << function->GetSymbolStart() << ": Conflicting types for \'" << function->GetName() << "\'" << std::endl;

									++errorCount;
								}
							}
						}
						else
						{
							errorStream << "Line# " << function->GetSymbolStart() << ": \'" << function->GetName() << "\' redeclared as different kind of symbol" << std::endl;

							++errorCount;
						}
					}
				}
				compound_statement
				{
					function->SetDefined(true);

					$$ = new ParseTreeNode();
					*$$ = {"func_definition", false, {$1, $2, $3, $4, $6}, NULL};
				
					SetLine($$);
					st->PrintAllScope();
					st->ExitScope();

					logStream << "func_definition : type_specifier ID LPAREN RPAREN compound_statement" << std::endl;

					if(!inVoidFunction && !functionReturns)
					{
						errorStream << "Line# " << function->GetSymbolStart() << ": Function \'" << function->GetName() << "\' should return something" << std::endl;

						++errorCount;
					}

					functionReturns = false;
					inVoidFunction = false;
					function = NULL;
					present = NULL;
				}
 				;

parameter_list	:	parameter_list COMMA type_specifier ID
				{
					logStream << "parameter_list  : parameter_list COMMA type_specifier ID" << std::endl;

					$4->symbolInfo->SetIDType("VARIABLE");
					$4->symbolInfo->SetDataType($3->children[0]->name);
					$4->symbolInfo->SetArray(false);

					$$ = new ParseTreeNode();
					*$$ = {"parameter_list", false, {$1, $2, $3, $4}, NULL};

					SetLine($$);
				}
				|	parameter_list COMMA type_specifier
				{
					logStream << "parameter_list  : parameter_list COMMA type_specifier" << std::endl;

					$$ = new ParseTreeNode();
					*$$ = {"parameter_list", false, {$1, $2, $3}, NULL};

					SetLine($$);
				}
 				|	type_specifier ID
				{
					logStream << "parameter_list  : type_specifier ID" << std::endl;

					$2->symbolInfo->SetIDType("VARIABLE");
					$2->symbolInfo->SetDataType($1->children[0]->name);
					$2->symbolInfo->SetArray(false);
					
					$$ = new ParseTreeNode();
					*$$ = {"parameter_list", false, {$1, $2}, NULL};

					SetLine($$);
				}
				|	type_specifier
				{
					logStream << "parameter_list  : type_specifier" << std::endl;
					
					$$ = new ParseTreeNode();
					*$$ = {"parameter_list", false, {$1}, NULL};

					SetLine($$);
				}
 				;

compound_statement	:	LCURL statements RCURL
					{
						logStream << "compound_statement : LCURL statements RCURL" << std::endl;

						$$ = new ParseTreeNode();
						*$$ = {"compound_statement", false, {$1, $2, $3}};

						SetLine($$);
					}
					|	LCURL error RCURL
					{
						SymbolInfo *errorInfo = new SymbolInfo("error", "statements");
						errorInfo->SetSymbolStart($1->startLine);

						// DeleteTree($2);

						$2 = new ParseTreeNode();
						*$2 = {"parameter_list", true, {}, errorInfo};
						$$ = new ParseTreeNode();
						*$$ = {"compound_statement", false, {$1, $2, $3}};

						errorStream << "Line# " << $1->startLine << ": Syntax error at statement of compound statement" << std::endl;

						++errorCount;

						SetLine($$);
					}
 		            |	LCURL RCURL
					{
						logStream << "compound_statement : LCURL RCURL" << std::endl;

						$$ = new ParseTreeNode();
						*$$ = {"compound_statement", false, {$1, $2}, NULL};

						SetLine($$);
					}
 		            ;
 		    
var_declaration :   type_specifier declaration_list SEMICOLON
				{
					logStream << "var_declaration : type_specifier declaration_list SEMICOLON" << std::endl;
					
					$$ = new ParseTreeNode();
					*$$ = {"var_declaration", false, {$1, $2, $3}, NULL};

					SetLine($$);

					InsertID($2, $1->children[0]->name, st);
				}
				|	type_specifier error SEMICOLON
				{					
					SymbolInfo *errorInfo = new SymbolInfo("error", "declaration_list");
					errorInfo->SetSymbolStart($1->startLine);

					// DeleteTree($2);

					$2 = new ParseTreeNode();
					*$2 = {"declaration_list", true, {}, errorInfo};
					$$ = new ParseTreeNode();
					*$$ = {"var_declaration", false, {$1, $2, $3}, NULL};

					errorStream << "Line# " << $1->children[0]->startLine << ": Syntax error at declaration list of variable declaration" << std::endl;

					++errorCount;

					SetLine($$);
				}
 		        ;
 		 
type_specifier  :   INT
				{
					logStream << "type_specifier\t: INT" << std::endl;

					$$ = new ParseTreeNode();
					*$$ = {"type_specifier", false, {$1}, NULL};
					
					SetLine($$);
				}
 		        |   FLOAT
				{
					logStream << "type_specifier\t: FLOAT" << std::endl;

					$$ = new ParseTreeNode();
					*$$ = {"type_specifier", false, {$1}, NULL};
					
					SetLine($$);
				}
 		        |   VOID
				{
					logStream << "type_specifier\t: VOID" << std::endl;

					$$ = new ParseTreeNode();
					*$$ = {"type_specifier", false, {$1}, NULL};
					
					SetLine($$);
				}
 		        ;
 		
declaration_list    :   declaration_list COMMA ID
					{
						$3->symbolInfo->SetIDType("VARIABLE");
						$3->symbolInfo->SetArray(false);

						logStream << "declaration_list : declaration_list COMMA ID" << std::endl;

						$$ = new ParseTreeNode();
						*$$ = {"declaration_list", false, {$1, $2, $3}, NULL};

						SetLine($$);
					}
 		            |   declaration_list COMMA ID LSQUARE CONST_INT RSQUARE
					{
						$3->symbolInfo->SetIDType("VARIABLE");
						$3->symbolInfo->SetArray(true);

						logStream << "declaration_list : declaration_list COMMA ID LSQUARE CONST_INT RSQUARE" << std::endl;

						$$ = new ParseTreeNode();
						*$$ = {"declaration_list", false, {$1, $2, $3, $4, $5, $6}, NULL};

						SetLine($$);
					}
 		            |   ID
					{
						$1->symbolInfo->SetIDType("VARIABLE");
						$1->symbolInfo->SetArray(false);

						logStream << "declaration_list : ID" << std::endl;

						$$ = new ParseTreeNode();
						*$$ = {"declaration_list", false, {$1}, NULL};
						
						SetLine($$);
					}
 		            |   ID LSQUARE CONST_INT RSQUARE
					{
						$1->symbolInfo->SetIDType("VARIABLE");
						$1->symbolInfo->SetArray(true);

						logStream << "declaration_list : ID LSQUARE CONST_INT RSQUARE" << std::endl;

						$$ = new ParseTreeNode();
						*$$ = {"declaration_list", false, {$1, $2, $3, $4}, NULL};

						SetLine($$);
					}
 		            ;
 		  
statements  :   statement
			{
				logStream << "statements : statement" << std::endl;

				$$ = new ParseTreeNode();
				*$$ = {"statements", false, {$1}, NULL};

				SetLine($$);
			}
	        |   statements statement
			{
				logStream << "statements : statements statement" << std::endl;

				$$ = new ParseTreeNode();
				*$$ = {"statements", false, {$1, $2}, NULL};

				SetLine($$);
			}
	        ;

statement	:   var_declaration
			{
				logStream << "statement : var_declaration" << std::endl;

				$$ = new ParseTreeNode();
				*$$ = {"statement", false, {$1}, NULL};

				SetLine($$);
			}
			|   expression_statement
			{
				logStream << "statement : expression_statement" << std::endl;

				$$ = new ParseTreeNode();
				*$$ = {"statement", false, {$1}, NULL};

				SetLine($$);
			}
			|   compound_statement
			{
				st->PrintAllScope();
				st->ExitScope();

				logStream << "statement : compound_statement" << std::endl;

				$$ = new ParseTreeNode();
				*$$ = {"statement", false, {$1}, NULL};

				SetLine($$);
			}
			|   FOR 
			{
				st->EnterScope();
			}
			LPAREN expression_statement expression_statement expression RPAREN statement
			{
				logStream << "statement : FOR LPAREN expression_statement expression_statement expression RPAREN statement" << std::endl;

				$$ = new ParseTreeNode();
				*$$ = {"statement", false, {$1, $3, $4, $5, $6, $7, $8}, NULL};

				SetLine($$);
				st->PrintAllScope();
				st->ExitScope();
			}
			|   WHILE
			{
				st->EnterScope();
			}
			LPAREN expression RPAREN statement
			{
				logStream << "statement : WHILE LPAREN expression RPAREN statement" << std::endl;

				$$ = new ParseTreeNode();
				*$$ = {"statement", false, {$1, $3, $4, $5, $6}, NULL};

				SetLine($$);
				st->PrintAllScope();
				st->ExitScope();
			}
			|   RETURN expression SEMICOLON
			{
				if(inVoidFunction)
				{
					errorStream << "Line# " << $1->symbolInfo->GetSymbolStart() << ": Function \'" << function->GetName() << "\' does not return anything" << std::endl;

					++errorCount;
				}

				functionReturns = true;

				logStream << "statement : RETURN expression SEMICOLON" << std::endl;

				$$ = new ParseTreeNode();
				*$$ = {"statement", false, {$1, $2, $3}, NULL};

				SetLine($$);
			}
			| IF LPAREN expression RPAREN statement
			{
				logStream << "statement : IF LPAREN expression RPAREN statement" << std::endl;

				$$ = new ParseTreeNode();
				*$$ = {"statement", false, {$1, $2, $3, $4, $5}, NULL};

				SetLine($$);
				st->PrintAllScope();
				st->ExitScope();
			}
	  		| IF LPAREN expression RPAREN statement ELSE
			{
				st->PrintAllScope();
				st->ExitScope();
				st->EnterScope();
			}
			statement
			{
				logStream << "statement : IF LPAREN expression RPAREN statement ELSE statement" << std::endl;

				$$ = new ParseTreeNode();
				*$$ = {"statement", false, {$1, $2, $3, $4, $5, $6, $8}, NULL};

				SetLine($$);
				st->PrintAllScope();
				st->ExitScope();
			}
			;
	  
expression_statement    :   SEMICOLON
						{
							logStream << "expression_statement : SEMICOLON" << std::endl;

							$$ = new ParseTreeNode();
							*$$ = {"expression_statement", false, {$1}, NULL};

							SetLine($$);
						}
			            |   expression SEMICOLON
						{
							logStream << "expression_statement : expression SEMICOLON" << std::endl;

							GetExpressionDataType($1);

							$$ = new ParseTreeNode();
							*$$ = {"expression_statement", false, {$1, $2}, NULL};

							SetLine($$);
						}
						|	error SEMICOLON
						{
							SymbolInfo *errorInfo = new SymbolInfo("error", "expression");
							errorInfo->SetSymbolStart($2->startLine);

							// DeleteTree($1);

							$1 = new ParseTreeNode();
							*$1 = {"expression", true, {}, errorInfo};
							$$ = new ParseTreeNode();
							*$$ = {"expression_statement", false, {$1, $2}, NULL};

							errorStream << "Line# " << $1->startLine << ": Syntax error at expression of expression statement" << std::endl;

							++errorCount;

							SetLine($$);
						}
			            ;
	  
variable    :   ID
			{
				logStream << "variable : ID" << std::endl;

				SymbolInfo *variablePtr = st->LookUp($1->symbolInfo->GetName());

				$$ = new ParseTreeNode();
				*$$ = {"variable", false, {$1}, NULL};

				SetLine($$);
			}
	        |   ID LSQUARE expression RSQUARE
			{
				logStream << "variable : ID LSQUARE expression RSQUARE" << std::endl;

				SymbolInfo *variablePtr = st->LookUp($1->symbolInfo->GetName());

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
							if(GetExpressionDataType($3) == "INT")
							{

							}
							else
							{
								errorStream << "Line# " << $1->symbolInfo->GetSymbolStart() << ": Array subscript is not an integer" << std::endl;

								++errorCount;
							}
						}
						else
						{
							errorStream << "Line# " << $1->symbolInfo->GetSymbolStart() << ": \'" << $1->symbolInfo->GetName() << "\' is not an array" << std::endl;

							++errorCount;
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
				logStream << "expression \t: logic_expression" << std::endl;

				$$ = new ParseTreeNode();
				*$$ = {"expression", false, {$1}, NULL};

				SetLine($$);
			}
	        |   variable ASSIGNOP logic_expression
			{
				logStream << "expression \t: variable ASSIGNOP logic_expression" << std::endl;

				$$ = new ParseTreeNode();
				*$$ = {"expression", false, {$1, $2, $3}, NULL};

				SetLine($$);
			}
	        ;
			
logic_expression    :   rel_expression
					{
						logStream << "logic_expression : rel_expression" << std::endl;

						$$ = new ParseTreeNode();
						*$$ = {"logic_expression", false, {$1}, NULL};

						SetLine($$);
					}
		            |   rel_expression LOGICOP rel_expression
					{
						logStream << "logic_expression : rel_expression LOGICOP rel_expression" << std::endl;

						$$ = new ParseTreeNode();
						*$$ = {"logic_expression", false, {$1, $2, $3}, NULL};

						SetLine($$);
					}
		            ;
			
rel_expression  :   simple_expression
				{
					logStream << "rel_expression\t: simple_expression" << std::endl;

					$$ = new ParseTreeNode();
					*$$ = {"rel_expression", false, {$1}, NULL};

					SetLine($$);
				}
		        |   simple_expression RELOP simple_expression
				{
					logStream << "rel_expression\t: simple_expression RELOP simple_expression" << std::endl;

					$$ = new ParseTreeNode();
					*$$ = {"rel_expression", false, {$1, $2, $3}, NULL};

					SetLine($$);
				}
		        ;
				
simple_expression   :   term
					{
						logStream << "simple_expression : term" << std::endl;

						$$ = new ParseTreeNode();
						*$$ = {"simple_expression", false, {$1}, NULL};

						SetLine($$);
					}
		            |   simple_expression ADDOP term
					{
						logStream << "simple_expression : simple_expression ADDOP term" << std::endl;

						$$ = new ParseTreeNode();
						*$$ = {"simple_expression", false, {$1, $2, $3}, NULL};

						SetLine($$);
					}
		            ;
					
term    :	unary_expression
		{
			logStream << "term :\tunary_expression" << std::endl;

			$$ = new ParseTreeNode();
			*$$ = {"term", false, {$1}, NULL};

			SetLine($$);
		}
        |   term MULOP unary_expression
		{
			logStream << "term :\tterm MULOP unary_expression" << std::endl;

			$$ = new ParseTreeNode();
			*$$ = {"term", false, {$1, $2, $3}, NULL};

			SetLine($$);
		}
        ;

unary_expression    :   ADDOP unary_expression
					{
						logStream << "unary_expression : ADDOP unary_expression" << std::endl;

						$$ = new ParseTreeNode();
						*$$ = {"unary_expression", false, {$1, $2}, NULL};

						SetLine($$);
					}
		            |   NOT unary_expression
					{
						logStream << "unary_expression : NOT unary_expression" << std::endl;

						$$ = new ParseTreeNode();
						*$$ = {"unary_expression", false, {$1, $2}, NULL};

						SetLine($$);
					}
		            |   factor
					{
						logStream << "unary_expression : factor" << std::endl;

						$$ = new ParseTreeNode();
						*$$ = {"unary_expression", false, {$1}, NULL};

						SetLine($$);
					}
		            ;
	
factor  :   variable
		{
			logStream << "factor\t: variable" << std::endl;

			$$ = new ParseTreeNode();
			*$$ = {"factor", false, {$1}, NULL};

			SetLine($$);
		}
	    |   ID LPAREN argument_list RPAREN
		{
			SymbolInfo *function = st->LookUpFunction($1->symbolInfo->GetName());

			logStream << "factor\t: ID LPAREN argument_list RPAREN" << std::endl;

			if(function == NULL)
			{
				errorStream << "Line# " << $1->symbolInfo->GetSymbolStart() << ": Undeclared function \'" << $1->symbolInfo->GetName() << "\'" << std::endl;

				++errorCount;

				std::vector<std::string> argumentTypeList;

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
					errorStream << "Line# " << $1->symbolInfo->GetSymbolStart() << ": Too many arguments to function \'" << function->GetName() << "\'" << std::endl;

					++errorCount;
				}
				else if(argumentTypeList.size() < paramList.size())
				{
					errorStream << "Line# " << $1->symbolInfo->GetSymbolStart() << ": Too few arguments to function \'" << function->GetName() << "\'" << std::endl;

					++errorCount;
				}
				else
				{
					for(size_t i = 0; i < paramList.size(); ++i)
					{
						if(argumentTypeList[i] != "" && paramList[i].first != argumentTypeList[i])
						{
							errorStream << "Line# " << $1->symbolInfo->GetSymbolStart() << ": Type mismatch for argument " << i + 1 << " of \'" << function->GetName() << "\'" << std::endl;

							++errorCount;
						}
					}
				}
			}

			$$ = new ParseTreeNode();
			*$$ = {"factor", false, {$1, $2, $3, $4}, NULL};

			SetLine($$);
		}
	    |   LPAREN expression RPAREN
		{
			logStream << "factor\t: LPAREN expression RPAREN" << std::endl;

			$$ = new ParseTreeNode();
			*$$ = {"factor", false, {$1, $2, $3}, NULL};

			SetLine($$);
		}
	    |   CONST_INT
		{
			logStream << "factor\t: CONST_INT" << std::endl;

			$$ = new ParseTreeNode();
			*$$ = {"factor", false, {$1}, NULL};

			SetLine($$);
		}
	    |   CONST_FLOAT
		{
			logStream << "factor\t: CONST_FLOAT" << std::endl;

			$$ = new ParseTreeNode();
			*$$ = {"factor", false, {$1}, NULL};

			SetLine($$);
		}
	    |   variable INCOP
		{
			logStream << "factor\t: variable INCOP" << std::endl;

			$$ = new ParseTreeNode();
			*$$ = {"factor", false, {$1, $2}, NULL};

			SetLine($$);
		}
	    ;
	
argument_list   :   arguments
				{
					logStream << "argument_list : arguments" << std::endl;

					$$ = new ParseTreeNode();
					*$$ = {"argument_list", false, {$1}, NULL};

					SetLine($$);
				}
			    |	arguments error
				{
					logStream << "argument_list : arguments" << std::endl;

					SymbolInfo *errorInfo = new SymbolInfo("error", "arguments");
					errorInfo->SetSymbolStart($1->startLine);

					// DeleteTree($2);

					$2 = new ParseTreeNode();
					*$2 = {"parameter_list", true, {}, errorInfo};
					$$ = new ParseTreeNode();
					*$$ = {"argument_list", false, {$1, $2}, NULL};

					errorStream << "Line# " << $1->startLine << ": Syntax error at arguments of arguments list" << std::endl;

					++errorCount;

					SetLine($$);
				}
				|
                ;
	
arguments   :   arguments COMMA logic_expression
			{
				logStream << "arguments : arguments COMMA logic_expression" << std::endl;

				$$ = new ParseTreeNode();
				*$$ = {"arguments", false, {$1, $2, $3}, NULL};

				SetLine($$);
			}
	        |   logic_expression
			{
				logStream << "arguments : logic_expression" << std::endl;

				$$ = new ParseTreeNode();
				*$$ = {"arguments", false, {$1}, NULL};

				SetLine($$);
			}
	        ;
 
%%

int main(int argc,char *argv[])
{
	functionReturns = false;
	inVoidFunction = false;

	parseTreeStream.open("1905039_parsetree.txt");
	logStream.open("1905039_log.txt");
	errorStream.open("1905039_error.txt");

	st = new SymbolTable(11, &logStream);
	FILE *fp = fopen(argv[1], "r");

	if(fp == NULL)
	{
		printf("Cannot Open Input File.\n");
		exit(1);
	}

	yyin = fp;

	yyparse();

	logStream << "Total Lines: " << lineCount << std::endl;
	logStream << "Total Errors: " << errorCount << std::endl;

	fclose(fp);
	parseTreeStream.close();
	logStream.close();
	errorStream.close();

	// DeleteTree(root);
	delete st;
	
	return 0;
}