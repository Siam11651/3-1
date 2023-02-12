#include "1905039_Utils.h"

extern SymbolTable *st;
extern size_t errorCount;
extern std::ofstream icgStream;
std::string functionName;

void PrintParseTree(ParseTreeNode *root, size_t depth)
{
	// if(root->terminal)
	// {
	// 	for(size_t i = 0; i < depth; ++i)
	// 	{
	// 		parseTreeStream << ' ';
	// 	}

	// 	parseTreeStream << root->name << " : " << root->symbolInfo->GetName() << "\t<Line: " << root->symbolInfo->GetSymbolStart() << '>' << std::endl;
	// }
	// else
	// {
	// 	for(size_t i = 0; i < depth; ++i)
	// 	{
	// 		parseTreeStream << ' ';
	// 	}

	// 	parseTreeStream << root->name << " : ";

	// 	for(size_t i = 0; i < root->children.size(); ++i)
	// 	{
	// 		parseTreeStream << root->children[i]->name << ' ';
	// 	}

	// 	parseTreeStream << "\t<Line: " << root->startLine << '-' << root->endLine << '>' << std::endl;

	// 	for(size_t i = 0; i < root->children.size(); ++i)
	// 	{
	// 		PrintParseTree(root->children[i], depth + 1);
	// 	}
	// }
}

void DeleteTree(ParseTreeNode *root)
{
	if(root != NULL)
	{
		if(root->symbolInfo != NULL)
		{
			delete root->symbolInfo;
		}

		for(size_t i = 0; i < root->children.size(); ++i)
		{
			DeleteTree(root->children[i]);
		}

		delete root;
	}
}

void SetLine(ParseTreeNode *root)
{
	size_t start = SIZE_MAX;
	size_t end = 0;

	for(size_t i = 0; i < root->children.size(); ++i)
	{
		ParseTreeNode *child = root->children[i];

		if(child->terminal)
		{
			start = std::min(start, child->symbolInfo->GetSymbolStart());
			end = std::max(end, child->symbolInfo->GetSymbolEnd());
		}
		else
		{
			start = std::min(start, child->startLine);
			end = std::max(end, child->endLine);
		}
	}

	root->startLine = start;
	root->endLine = end;
}

void InsertID(ParseTreeNode *root, const std::string dataType, SymbolTable *symbolTable)
{
	if(root->children.size() == 6)
	{
		InsertID(root->children[0], dataType, st);

		if(dataType == "VOID")
		{			
			++errorCount;
		}
		else
		{
			SymbolInfo* thisScopeSymbol = st->LookUpThisScope(root->children[2]->symbolInfo->GetName());

			if(thisScopeSymbol == NULL)
			{
				root->children[2]->symbolInfo->SetDataType(dataType);
				root->children[2]->symbolInfo->SetArray(true);
				symbolTable->Insert(root->children[2]->symbolInfo);
			}
			else
			{
				if(thisScopeSymbol->GetIDType() == "VARIABLE")
				{
					if(thisScopeSymbol->GetDataType() == dataType)
					{
						++errorCount;
					}
					else
					{
						++errorCount;
					}
				}
				else
				{
					++errorCount;
				}
			}
		}
	}
	else if(root->children.size() == 4)
	{
		if(dataType == "VOID")
		{			
			++errorCount;
		}
		else
		{
			SymbolInfo* thisScopeSymbol = st->LookUpThisScope(root->children[0]->symbolInfo->GetName());

			if(thisScopeSymbol == NULL)
			{
				root->children[0]->symbolInfo->SetDataType(dataType);
				root->children[0]->symbolInfo->SetArray(true);
				symbolTable->Insert(root->children[0]->symbolInfo);
			}
			else
			{
				if(thisScopeSymbol->GetIDType() == "VARIABLE")
				{
					if(thisScopeSymbol->GetDataType() == dataType)
					{
						++errorCount;
					}
					else
					{
						++errorCount;
					}
				}
				else
				{
					++errorCount;
				}
			}
		}
	}
	else if(root->children.size() == 3)
	{
		InsertID(root->children[0], dataType, st);

		if(dataType == "VOID")
		{			
			++errorCount;
		}
		else
		{
			SymbolInfo* thisScopeSymbol = st->LookUpThisScope(root->children[2]->symbolInfo->GetName());

			if(thisScopeSymbol == NULL)
			{
				root->children[2]->symbolInfo->SetDataType(dataType);
				symbolTable->Insert(root->children[2]->symbolInfo);
			}
			else
			{
				if(thisScopeSymbol->GetIDType() == "VARIABLE")
				{
					if(thisScopeSymbol->GetDataType() == dataType)
					{
						++errorCount;
					}
					else
					{
						++errorCount;
					}
				}
				else
				{
					++errorCount;
				}
			}
		}
	}
	else
	{
		if(dataType == "VOID")
		{			
			++errorCount;
		}
		else
		{
			SymbolInfo* thisScopeSymbol = st->LookUpThisScope(root->children[0]->symbolInfo->GetName());

			if(thisScopeSymbol == NULL)
			{
				root->children[0]->symbolInfo->SetDataType(dataType);
				symbolTable->Insert(root->children[0]->symbolInfo);
			}
			else
			{
				if(thisScopeSymbol->GetIDType() == "VARIABLE")
				{
					if(thisScopeSymbol->GetDataType() == dataType)
					{
						++errorCount;
					}
					else
					{
						++errorCount;
					}
				}
				else
				{
					++errorCount;
				}
			}
		}
	}
}

void SetParams(ParseTreeNode *root, std::vector<std::pair<std::string, std::string>> &paramList, bool &error, bool definition)
{
	if(root->children.size() == 3 || root->children.size() == 4)
	{
		SetParams(root->children[0], paramList, error, definition);

		if(error)
		{
			return;
		}

		std::string paramName = "";

		if(root->children.size() == 4)
		{
			paramName = root->children[3]->symbolInfo->GetName();
		}

		std::pair<std::string, std::string> param = {root->children[2]->children[0]->name, paramName};
		bool redefinition = false;

		for(size_t i = 0; i < paramList.size(); ++i)
		{
			if(param.second != "" && paramList[i].second == param.second)
			{
				redefinition = true;

				break;
			}
		}

		if(redefinition)
		{
			++errorCount;
			error = true;
		}
		else
		{
			paramList.push_back(param);

			if(definition)
			{
				st->Insert(root->children[3]->symbolInfo);
			}
		}
	}
	else if(root->children.size() == 2 || root->children.size() == 1)
	{
		std::string paramName = "";

		if(root->children.size() == 2)
		{
			paramName = root->children[1]->symbolInfo->GetName();
		}

		std::pair<std::string, std::string> param = {root->children[0]->children[0]->name, paramName};
		bool redefinition = false;

		for(size_t i = 0; i < paramList.size(); ++i)
		{
			if(param.second != "" && paramList[i].second == param.second)
			{
				redefinition = true;

				break;
			}
		}

		if(redefinition)
		{
			++errorCount;
			error = true;
		}
		else
		{
			paramList.push_back(param);

			if(definition)
			{
				st->Insert(root->children[1]->symbolInfo);
			}
		}
	}
}

void SetFactorValue(ParseTreeNode *root)
{
	if(root->children.size() == 1)
	{
		root->valueSet = true;
		std::stringstream ss;
		std::string value = root->children[0]->symbolInfo->GetName();

		ss.str(value);

		if(root->children[0]->name == "CONST_INT")
		{
			root->valueType = "INT";
			
			ss >> root->intValue;
		}
		else if(root->children[0]->name == "CONST_FLOAT")
		{
			root->valueType = "FLOAT";
			
			ss >> root->floatValue;
		}
	}
	else if(root->children.size() == 3)
	{
		SetExpressionValue(root->children[1]);

		if(root->children[1]->valueSet)
		{
			root->valueSet = true;
			root->valueType = root->children[1]->valueType;

			if(root->children[1]->valueType == "INT")
			{
				root->intValue = root->children[1]->intValue;
			}
			else
			{
				root->floatValue = root->children[1]->floatValue;
			}
		}
	}
}

void SetUnaryExpressionValue(ParseTreeNode *root)
{
	if(root->children.size() == 1)
	{
		SetFactorValue(root->children[0]);

		if(root->children[0]->valueSet)
		{
			root->valueSet = true;
			root->valueType = root->children[0]->valueType;

			if(root->children[0]->valueType == "INT")
			{
				root->intValue = root->children[0]->intValue;
			}
			else
			{
				root->floatValue = root->children[0]->floatValue;
			}
		}
	}
	else
	{
		SetUnaryExpressionValue(root->children[1]);

		if(root->children[1]->valueSet)
		{
			root->valueSet = true;
			root->valueType = "FLOAT";

			if(root->children[1]->valueType == "INT")
			{
				root->valueType = "INT";

				if(root->children[0]->symbolInfo->GetName() == "+")
				{
					root->intValue = root->children[1]->intValue;
				}
				else if(root->children[0]->symbolInfo->GetName() == "-")
				{
					root->intValue = -root->children[1]->intValue;
				}
				else
				{
					root->intValue = !root->children[1]->intValue;
				}
			}
			else
			{
				if(root->children[0]->symbolInfo->GetName() == "+")
				{
					root->floatValue = root->children[1]->floatValue;
				}
				else if(root->children[0]->symbolInfo->GetName() == "-")
				{
					root->floatValue = -root->children[1]->floatValue;
				}
				else
				{
					root->floatValue = !root->children[1]->floatValue;
				}
			}
		}
	}
}

void SetTermValue(ParseTreeNode *root)
{
	if(root->children.size() == 1)
	{
		SetUnaryExpressionValue(root->children[0]);

		if(root->children[0]->valueSet)
		{
			root->valueSet = true;
			root->valueType = root->children[0]->valueType;

			if(root->children[0]->valueType == "INT")
			{
				root->intValue = root->children[0]->intValue;
			}
			else
			{
				root->floatValue = root->children[0]->floatValue;
			}
		}
	}
	else
	{
		SetTermValue(root->children[0]);
		SetUnaryExpressionValue(root->children[2]);

		if(root->children[0]->valueSet && root->children[2]->valueSet)
		{
			root->valueSet = true;
			root->valueType = "FLOAT";

			if(root->children[0]->valueType == "INT" && root->children[2]->valueType == "INT")
			{
				root->valueType = "INT";

				if(root->children[1]->symbolInfo->GetName() == "*")
				{
					root->intValue = root->children[0]->intValue * root->children[2]->intValue;
				}
				else if(root->children[1]->symbolInfo->GetName() == "/")
				{
					if(root->children[2]->intValue != 0)
					{
						root->intValue = root->children[0]->intValue / root->children[2]->intValue;
					}
					else
					{
						root->valueSet = false;
					}
				}
				else
				{
					if(root->children[2]->intValue != 0)
					{
						root->intValue = root->children[0]->intValue % root->children[2]->intValue;
					}
					else
					{
						root->valueSet = false;
					}
				}
			}
			else if(root->children[0]->valueType == "INT" && root->children[2]->valueType == "FLOAT")
			{
				if(root->children[1]->symbolInfo->GetName() == "*")
				{
					root->floatValue = root->children[0]->intValue * root->children[2]->floatValue;
				}
				else if(root->children[1]->symbolInfo->GetName() == "/")
				{
					if(root->children[2]->floatValue != 0.0)
					{
						root->floatValue = root->children[0]->intValue / root->children[2]->floatValue;
					}
					else
					{
						root->valueSet = false;
					}
				}
				else
				{
					root->valueSet = false;
				}
			}
			else if(root->children[0]->valueType == "FLOAT" && root->children[2]->valueType == "INT")
			{
				if(root->children[1]->symbolInfo->GetName() == "*")
				{
					root->floatValue = root->children[0]->floatValue * root->children[2]->intValue;
				}
				else if(root->children[1]->symbolInfo->GetName() == "/")
				{
					if(root->children[2]->intValue != 0)
					{
						root->floatValue = root->children[0]->floatValue / root->children[2]->intValue;
					}
					else
					{
						root->valueSet = false;
					}
				}
				else
				{
					if(root->children[2]->intValue != 0)
					{
						root->intValue = root->children[0]->intValue % root->children[2]->intValue;
					}
					else
					{
						root->valueSet = false;
					}
				}
			}
			else
			{
				if(root->children[1]->symbolInfo->GetName() == "*")
				{
					root->floatValue = root->children[0]->floatValue * root->children[2]->floatValue;
				}
				else if(root->children[1]->symbolInfo->GetName() == "/")
				{
					if(root->children[2]->floatValue != 0)
					{
						root->floatValue = root->children[0]->floatValue / root->children[2]->floatValue;
					}
					else
					{
						root->valueSet = false;
					}
				}
				else
				{
					root->valueSet = false;
				}
			}
		}
	}
}

void SetSimpleExpressionValue(ParseTreeNode *root)
{
	if(root->children.size() == 1)
	{
		SetTermValue(root->children[0]);

		if(root->children[0]->valueSet)
		{
			root->valueSet = true;
			root->valueType = root->children[0]->valueType;

			if(root->children[0]->valueType == "INT")
			{
				root->intValue = root->children[0]->intValue;
			}
			else
			{
				root->floatValue = root->children[0]->floatValue;
			}
		}
	}
	else
	{
		SetSimpleExpressionValue(root->children[0]);
		SetTermValue(root->children[2]);

		if(root->children[0]->valueSet && root->children[2]->valueSet)
		{
			root->valueSet = true;
			root->valueType = "FLOAT";

			if(root->children[0]->valueType == "INT" && root->children[2]->valueType == "INT")
			{
				root->valueType = "INT";
				
				if(root->children[1]->symbolInfo->GetName() == "+")
				{
					root->intValue = root->children[0]->intValue + root->children[2]->intValue;
				}
				else
				{
					root->intValue = root->children[0]->intValue - root->children[2]->intValue;
				}
			}
			else if(root->children[0]->valueType == "INT" && root->children[2]->valueType == "FLOAT")
			{
				if(root->children[1]->symbolInfo->GetName() == "+")
				{
					root->floatValue = root->children[0]->intValue + root->children[2]->floatValue;
				}
				else
				{
					root->floatValue = root->children[0]->intValue - root->children[2]->floatValue;
				}
			}
			else if(root->children[0]->valueType == "FLOAT" && root->children[2]->valueType == "INT")
			{
				if(root->children[1]->symbolInfo->GetName() == "+")
				{
					root->floatValue = root->children[0]->floatValue + root->children[2]->intValue;
				}
				else
				{
					root->floatValue = root->children[0]->floatValue - root->children[2]->intValue;
				}
			}
			else
			{
				if(root->children[1]->symbolInfo->GetName() == "+")
				{
					root->floatValue = root->children[0]->floatValue + root->children[2]->floatValue;
				}
				else
				{
					root->floatValue = root->children[0]->floatValue - root->children[2]->floatValue;
				}
			}
		}
	}
}

void SetRelExpressionValue(ParseTreeNode *root)
{
	if(root->children.size() == 1)
	{
		SetSimpleExpressionValue(root->children[0]);

		if(root->children[0]->valueSet)
		{
			root->valueSet = true;
			root->valueType = root->children[0]->valueType;

			if(root->children[0]->valueType == "INT")
			{
				root->intValue = root->children[0]->intValue;
			}
			else
			{
				root->floatValue = root->children[0]->floatValue;
			}
		}
	}
	else
	{	
		if(root->children[0]->valueSet && root->children[2]->valueSet)
		{	
			if(root->children[0]->valueType == "INT" && root->children[2]->valueType == "INT")
			{
				if(root->children[1]->symbolInfo->GetName() == "<")
				{
					root->intValue = root->children[0]->intValue < root->children[2]->intValue;
				}
				else if(root->children[1]->symbolInfo->GetName() == "<=")
				{
					root->intValue = root->children[0]->intValue <= root->children[2]->intValue;
				}
				else if(root->children[1]->symbolInfo->GetName() == ">")
				{
					root->intValue = root->children[0]->intValue > root->children[2]->intValue;
				}
				else if(root->children[1]->symbolInfo->GetName() == ">=")
				{
					root->intValue = root->children[0]->intValue >= root->children[2]->intValue;
				}
				else if(root->children[1]->symbolInfo->GetName() == "==")
				{
					root->intValue = root->children[0]->intValue == root->children[2]->intValue;
				}
				else
				{
					root->intValue = root->children[0]->intValue != root->children[2]->intValue;
				}
			}
			else if(root->children[0]->valueType == "INT" && root->children[2]->valueType == "FLOAT")
			{
				if(root->children[1]->symbolInfo->GetName() == "<")
				{
					root->intValue = root->children[0]->intValue < root->children[2]->floatValue;
				}
				else if(root->children[1]->symbolInfo->GetName() == "<=")
				{
					root->intValue = root->children[0]->intValue <= root->children[2]->floatValue;
				}
				else if(root->children[1]->symbolInfo->GetName() == ">")
				{
					root->intValue = root->children[0]->intValue > root->children[2]->floatValue;
				}
				else if(root->children[1]->symbolInfo->GetName() == ">=")
				{
					root->intValue = root->children[0]->intValue >= root->children[2]->floatValue;
				}
				else if(root->children[1]->symbolInfo->GetName() == "==")
				{
					root->intValue = root->children[0]->intValue == root->children[2]->floatValue;
				}
				else
				{
					root->intValue = root->children[0]->intValue != root->children[2]->floatValue;
				}
			}
			else if(root->children[0]->valueType == "FLOAT" && root->children[2]->valueType == "INT")
			{
				if(root->children[1]->symbolInfo->GetName() == "<")
				{
					root->intValue = root->children[0]->floatValue < root->children[2]->intValue;
				}
				else if(root->children[1]->symbolInfo->GetName() == "<=")
				{
					root->intValue = root->children[0]->floatValue <= root->children[2]->intValue;
				}
				else if(root->children[1]->symbolInfo->GetName() == ">")
				{
					root->intValue = root->children[0]->floatValue > root->children[2]->intValue;
				}
				else if(root->children[1]->symbolInfo->GetName() == ">=")
				{
					root->intValue = root->children[0]->floatValue >= root->children[2]->intValue;
				}
				else if(root->children[1]->symbolInfo->GetName() == "==")
				{
					root->intValue = root->children[0]->floatValue == root->children[2]->intValue;
				}
				else
				{
					root->intValue = root->children[0]->floatValue != root->children[2]->intValue;
				}
			}
			else
			{
				if(root->children[1]->symbolInfo->GetName() == "<")
				{
					root->floatValue = root->children[0]->floatValue < root->children[2]->floatValue;
				}
				else if(root->children[1]->symbolInfo->GetName() == "<=")
				{
					root->floatValue = root->children[0]->floatValue <= root->children[2]->floatValue;
				}
				else if(root->children[1]->symbolInfo->GetName() == ">")
				{
					root->floatValue = root->children[0]->floatValue > root->children[2]->floatValue;
				}
				else if(root->children[1]->symbolInfo->GetName() == ">=")
				{
					root->floatValue = root->children[0]->floatValue >= root->children[2]->floatValue;
				}
				else if(root->children[1]->symbolInfo->GetName() == "==")
				{
					root->floatValue = root->children[0]->floatValue == root->children[2]->floatValue;
				}
				else
				{
					root->floatValue = root->children[0]->floatValue != root->children[2]->floatValue;
				}
			}
		}
	}
}

void SetLogicExpressionValue(ParseTreeNode *root)
{
	if(root->children.size() == 1)
	{
		SetRelExpressionValue(root->children[0]);

		if(root->children[0]->valueSet)
		{
			root->valueSet = true;
			root->valueType = root->children[0]->valueType;

			if(root->children[0]->valueType == "INT")
			{
				root->intValue = root->children[0]->intValue;
			}
			else
			{
				root->floatValue = root->children[0]->floatValue;
			}
		}
	}
	else
	{
		SetRelExpressionValue(root->children[0]);
		SetRelExpressionValue(root->children[2]);

		if(root->children[0]->valueSet && root->children[2]->valueSet)
		{
			root->valueSet = true;
			root->valueType = "INT";

			if(root->children[0]->valueType == "INT" && root->children[2]->valueType == "INT")
			{
				if(root->children[1]->symbolInfo->GetName() == "&&")
				{
					root->intValue = root->children[0]->intValue && root->children[2]->intValue;
				}
				else
				{
					root->intValue = root->children[0]->intValue || root->children[2]->intValue;
				}
			}
			else if(root->children[0]->valueType == "INT" && root->children[2]->valueType == "FLOAT")
			{
				if(root->children[1]->symbolInfo->GetName() == "&&")
				{
					root->intValue = root->children[0]->intValue && (int)root->children[2]->floatValue;
				}
				else
				{
					root->intValue = root->children[0]->intValue || (int)root->children[2]->floatValue;
				}
			}
			else if(root->children[0]->valueType == "FLOAT" && root->children[2]->valueType == "INT")
			{
				if(root->children[1]->symbolInfo->GetName() == "&&")
				{
					root->intValue = (int)root->children[0]->floatValue && root->children[2]->intValue;
				}
				else
				{
					root->intValue = (int)root->children[0]->floatValue || root->children[2]->intValue;
				}
			}
			else
			{
				if(root->children[1]->symbolInfo->GetName() == "&&")
				{
					root->intValue = (int)root->children[0]->floatValue && (int)root->children[2]->floatValue;
				}
				else
				{
					root->intValue = (int)root->children[0]->floatValue || (int)root->children[2]->floatValue;
				}
			}
		}
	}
}

void SetExpressionValue(ParseTreeNode *root)
{
	if(root->children.size() == 1)
	{
		SetLogicExpressionValue(root->children[0]);

		if(root->children[0]->valueSet)
		{
			root->valueSet = true;
			root->valueType = root->children[0]->valueType;

			if(root->children[0]->valueType == "INT")
			{
				root->intValue = root->children[0]->intValue;
			}
			else
			{
				root->floatValue = root->children[0]->floatValue;
			}
		}
	}
	else
	{
		SetLogicExpressionValue(root->children[2]);

		if(root->children[2]->valueSet)
		{
			root->children[0]->valueSet = true;
			root->children[0]->valueType = root->children[0]->children[0]->valueType;
			root->valueSet = true;
			root->valueType = root->children[0]->valueType;

			if(root->children[0]->children[0]->valueType == "INT")
			{
				root->children[0]->intValue = root->children[0]->children[0]->intValue;
				root->intValue = root->children[0]->intValue;
			}
			else
			{
				root->children[0]->floatValue = root->children[0]->children[0]->floatValue;
				root->floatValue = root->children[0]->floatValue;
			}
		}
	}
}

std::string GetVariableDataType(ParseTreeNode *root)
{
	SymbolInfo *variable = st->LookUp(root->children[0]->symbolInfo->GetName());

	if(variable == NULL)
	{
		++errorCount;

		return "";
	}
	else
	{
		return variable->GetDataType();
	}
}

std::string GetFactorDataType(ParseTreeNode *root)
{
	if(root->children.size() == 1)
	{
		if(root->children[0]->name == "variable")
		{
			return GetVariableDataType(root->children[0]);
		}
		else
		{
			if(root->children[0]->name == "CONST_FLOAT")
			{
				return "FLOAT";
			}
			else
			{
				return "INT";
			}
		}
	}
	else if(root->children.size() == 2)
	{
		return GetVariableDataType(root->children[0]);
	}
	else if(root->children.size() == 3)
	{
		if(root->children[0]->name == "LPAREN")
		{
			return GetExpressionDataType(root->children[1]);
		}
		else
		{
			SymbolInfo* calledFunction = st->LookUpFunction(root->children[0]->symbolInfo->GetName());

			if(calledFunction == NULL)
			{
				return "";
			}
			else
			{
				return calledFunction->GetDataType();
			}
		}
	}
	else
	{
		SymbolInfo* calledFunction = st->LookUpFunction(root->children[0]->symbolInfo->GetName());

		if(calledFunction == NULL)
		{
			return "";
		}
		else
		{
			return calledFunction->GetDataType();
		}
	}
}

std::string GetUnaryExpressionDataType(ParseTreeNode *root)
{
	if(root->children.size() == 1)
	{
		return GetFactorDataType(root->children[0]);
	}
	else
	{
		std::string type = GetUnaryExpressionDataType(root->children[1]);

		if(type == "VOID")
		{
			++errorCount;

			return "";
		}
		else
		{
			return type;
		}
	}
}

std::string GetTermDataType(ParseTreeNode *root)
{
	if(root->children.size() == 1)
	{
		return GetUnaryExpressionDataType(root->children[0]);
	}
	else
	{
		std::string term = GetTermDataType(root->children[0]);
		std::string unaryExpession = GetUnaryExpressionDataType(root->children[2]);

		if(unaryExpession == "" || term == "")
		{
			return "";
		}
		else if(unaryExpession == "VOID" || term == "VOID")
		{
			++errorCount;

			return "";
		}
		else
		{
			if(term == "FLOAT" || unaryExpession == "FLOAT")
			{
				if(root->children[1]->symbolInfo->GetName() == "%")
				{
					++errorCount;

					SetTermValue(root->children[2]);

					if(root->children[2]->valueSet)
					{
						if(root->children[2]->valueType == "INT")
						{
							if(root->children[2]->intValue == 0)
							{
								++errorCount;
							}
						}
						else
						{
							if(root->children[2]->floatValue == 0.0)
							{
								++errorCount;
							}
						}
					}

					return "INT";
				}
				else
				{
					if(root->children[1]->symbolInfo->GetName() == "/")
					{
						SetTermValue(root->children[2]);

						if(root->children[2]->valueSet)
						{
							if(root->children[2]->valueType == "INT")
							{
								if(root->children[2]->intValue == 0)
								{
									++errorCount;
								}
							}
							else
							{
								if(root->children[2]->floatValue == 0.0)
								{
									++errorCount;
								}
							}
						}
					}

					return "FLOAT";
				}
			}
			else
			{
				if(root->children[1]->symbolInfo->GetName() == "/" || root->children[1]->symbolInfo->GetName() == "%")
				{
					SetUnaryExpressionValue(root->children[2]);

					if(root->children[2]->valueSet)
					{
						if(root->children[2]->valueType == "INT")
						{
							if(root->children[2]->intValue == 0)
							{
								++errorCount;
							}
						}
						else
						{
							if(root->children[2]->floatValue == 0.0)
							{
								++errorCount;
							}
						}
					}
				}

				return "INT";
			}
		}
	}
}

std::string GetSimpleExpressionDataType(ParseTreeNode *root)
{
	if(root->children.size() == 1)
	{
		return GetTermDataType(root->children[0]);
	}
	else
	{
		std::string simpleExpression = GetSimpleExpressionDataType(root->children[0]);
		std::string term = GetTermDataType(root->children[2]);

		if(term == "" || simpleExpression == "")
		{
			return "";
		}
		else if(simpleExpression == "VOID" || term == "VOID")
		{
			++errorCount;

			return "";
		}
		else if(simpleExpression == "FLOAT" || term == "FLOAT")
		{
			return "FLOAT";
		}
		else
		{
			return "INT";
		}
	}
}

std::string GetRelExpressionDataType(ParseTreeNode *root)
{
	if(root->children.size() == 1)
	{
		return GetSimpleExpressionDataType(root->children[0]);
	}
	else
	{
		std::string simpleExpression1 = GetSimpleExpressionDataType(root->children[0]);
		std::string simpleExpression2 = GetSimpleExpressionDataType(root->children[2]);

		if(simpleExpression1 == "" || simpleExpression2 == "")
		{
			return "";
		}
		else if(simpleExpression1 == "VOID" || simpleExpression2 == "VOID")
		{
			++errorCount;

			return "";
		}
		else
		{
			return "INT"; // relop always give int	
		}
	}
}

std::string GetLogicExpressionDataType(ParseTreeNode *root)
{
	if(root->children.size() == 1)
	{
		return GetRelExpressionDataType(root->children[0]);
	}
	else // else 3
	{
		std::string relExpression1 = GetRelExpressionDataType(root->children[0]);
		std::string relExpression2 = GetRelExpressionDataType(root->children[2]);

		if(relExpression1 == "" || relExpression2 == "")
		{
			return "";
		}
		else if(relExpression1 == "VOID" || relExpression2 == "VOID")
		{
			++errorCount;

			return "";
		}
		else
		{
			return "INT"; // logic op always give int
		}
	}
}

std::string GetExpressionDataType(ParseTreeNode *root)
{
	if(root->children.size() == 1)
	{
		return GetLogicExpressionDataType(root->children[0]);
	}
	else
	{
		std::string rhsType = GetLogicExpressionDataType(root->children[2]);
		std::string lhsType = GetVariableDataType(root->children[0]);

		if(rhsType == "VOID")
		{
			++errorCount;
		}
		else
		{
			if(lhsType == "INT" && rhsType == "FLOAT")
			{
				++errorCount;
			}
		}

		return lhsType;
	}
}

void SetArgumentTypeList(ParseTreeNode *root, std::vector<std::string> &argumentTypeList)
{
	if(root->children.size() == 3)
	{
		SetArgumentTypeList(root->children[0], argumentTypeList);
		argumentTypeList.push_back(GetLogicExpressionDataType(root->children[2]));
	}
	else
	{
		argumentTypeList.push_back(GetLogicExpressionDataType(root->children[0]));
	}
}

void GenerateICG(ParseTreeNode *root)
{
	icgStream << ".MODEL SMALL" << std::endl;
	icgStream << ".STACK 1000H" << std::endl;
	icgStream << ".DATA" << std::endl;
	icgStream << "\tCR EQU 0DH" << std::endl;
	icgStream << "\tLF EQU 0AH" << std::endl;

	std::vector<SymbolInfo *> globalVariables = st->GetCurrentScope()->GetVariables();

	for(int i = 0; i < globalVariables.size(); ++i)
	{
		icgStream << "\t" << globalVariables[i]->GetName() << " " << "DW 1 DUP (0000H)" << std::endl;
	}

	icgStream << ".CODE" << std::endl;

	std::vector<ParseTreeNode *> functionDefinitions = GetFunctionDefinitions(root->children[0]);

	for(int i = 0; i < functionDefinitions.size(); ++i)
	{
		ParseTreeNode *functionDefinition = functionDefinitions[i];
		functionName = functionDefinition->children[1]->symbolInfo->GetName();

		icgStream << functionName << " PROC" << std::endl;

		if(functionName == "main")
		{
			icgStream << "\tMOV AX, @DATA" << std::endl;
			icgStream << "\tMOV DS, AX" << std::endl;
		}

		icgStream << "\tPUSH BP" << std::endl;
		icgStream << "\tMOV BP, SP" << std::endl;

		st->EnterScope();

		std::vector<ParseTreeNode *> paramVars;
		ParseTreeNode *compoundStatementNode;

		if(functionDefinition->children.size() == 6)
		{
			paramVars = GetParamVars(root->children[3]);
			compoundStatementNode = functionDefinition->children[5];
		}
		else
		{
			compoundStatementNode = functionDefinition->children[4];
		}

		std::vector<ParseTreeNode *> statements;

		if(compoundStatementNode->children.size() == 3)
		{
			ParseTreeNode *statementsNode = compoundStatementNode->children[1];

			if(statementsNode->name == "statements")
			{
				statements = GetStatements(statementsNode);
			}
		}

		size_t variableCount = 0;
		size_t statementId = 1;

		for(size_t i = 0; i < statements.size(); ++i)
		{
			ExecuteStatement(statements[i], statementId, variableCount);
		}

		icgStream << functionName << " ENDP" << std::endl;

		st->ExitScope();
	}

	icgStream << "END main" << std::endl;
}

void ExecuteStatement(ParseTreeNode *root, size_t &statementId, size_t &variableCount)
{
	ParseTreeNode *statement = root->children[0];

	if(statement->name == "var_declaration")
	{
		std::vector<ParseTreeNode *> variables = GetDeclaredVariables(statement->children[1]);

		for(size_t j = 0; j < variables.size(); ++j)
		{
			st->Insert(variables[j]->symbolInfo);

			icgStream << "\tSUB SP, 2" << std::endl;
		}

		variableCount += variables.size();
	}
	else if(statement->name == "expression_statement")
	{
		ExecuteExpressionStatement(statement, statementId);
	}
	else if(statement->name == "PRINTLN")
	{
		std::stringstream statementIdStringStream("");

		statementIdStringStream << statementId;
		icgStream << "L" << statementIdStringStream.str() << ":" << std::endl;

		ParseTreeNode *idNode = root->children[2];
		SymbolInfo *idSymbol = st->LookUp(idNode->symbolInfo->GetName());

		if(idSymbol->GetScopeID() == 1)
		{
			icgStream << "\tMOV AX, " << idSymbol->GetName() << std::endl;
			icgStream << "\tCALL print_output" << std::endl;
			icgStream << "\tCALL new_line" << std::endl;
		}
		else
		{
			icgStream << "\tMOV AX, [BP-" << idSymbol->GetStackOffset() << "]" << std::endl;
			icgStream << "\tCALL print_output" << std::endl;
			icgStream << "\tCALL new_line" << std::endl;
		}

		++statementId;
	}
	else if(statement->name == "RETURN")
	{
		icgStream << "L" << statementId << ":" << std::endl;

		ExecuteExpression(root->children[1], statementId);

		icgStream << "\tJMP " << statementId + 1 << std::endl;
		icgStream << "L" << statementId + 1 << ":" << std::endl;
		icgStream << "\tADD SP, " << variableCount * 2 << std::endl;
		icgStream << "\tPOP BP" << std::endl;

		if(functionName == "main")
		{
			icgStream << "\tMOV AX, 4CH" << std::endl;
			icgStream << "\tINT 21H" << std::endl;
		}

		statementId += 2;
	}
}

void ExecuteExpressionStatement(ParseTreeNode *root, size_t &statementId)
{
	if(root->children.size() == 2)
	{
		ParseTreeNode *expression = root->children[0];

		if(expression->name == "expression")
		{
			std::stringstream statementIdStringStream("");

			statementIdStringStream << statementId;
			icgStream << "L" << statementIdStringStream.str() << ":" << std::endl;

			ExecuteExpression(expression, statementId);

			++statementId;
		}
	}
}

void ExecuteExpression(ParseTreeNode *root, size_t &statementId)
{
	if(root->children.size() == 1)
	{
		ExecuteLogicExpression(root->children[0], statementId);
	}
	else // size 3
	{
		ExecuteLogicExpression(root->children[2], statementId);

		ParseTreeNode *idNode = root->children[0]->children[0];
		SymbolInfo *idInfo = st->LookUp(idNode->symbolInfo->GetName());
		size_t lhsScopeId = idInfo->GetScopeID();

		if(lhsScopeId == 1)
		{
			icgStream << "\tMOV " << idNode->symbolInfo->GetName() << ", AX" << std::endl;
		}
		else
		{
			icgStream << "\tMOV [BP-" << idInfo->GetStackOffset() << "], AX" << std::endl;
		}

		icgStream << "\tPUSH AX" << std::endl;
		icgStream << "\tPOP AX" << std::endl;
	}
}

void ExecuteLogicExpression(ParseTreeNode *root, size_t &statementId)
{
	if(root->children.size() == 1)
	{
		ExecuteRelExpression(root->children[0], statementId);
	}
	else // size 3
	{
		ExecuteRelExpression(root->children[0], statementId);

		icgStream << "\tCMP AX, 0" << std::endl;

		std::string opName = root->children[1]->symbolInfo->GetName();

		if(opName == "||")
		{
			icgStream << "\tJNE L" << statementId + 2 << std::endl;
			icgStream << "\tJMP L" << statementId + 1 << std::endl;
			icgStream << "L" << statementId + 1 << ":" << std::endl;

			ExecuteRelExpression(root->children[2], statementId);

			icgStream << "\tCMP AX, 0" << std::endl;
			icgStream << "\tJNE L" << statementId + 2 << std::endl;
			icgStream << "\tJMP L" << statementId + 4 << std::endl;
			icgStream << "L" << statementId + 2 << ":" << std::endl;
			icgStream << "\tMOV AX, 1" << std::endl;
			icgStream << "\tJMP L" << statementId + 3 << std::endl;
			icgStream << "L" << statementId + 4 << ":" << std::endl;
			icgStream << "\tMOV AX, 0" << std::endl;
			icgStream << "L" << statementId + 3 << ":" << std::endl;

			statementId += 4;
		}
		else if(opName == "&&")
		{
			icgStream << "\tJNE L" << statementId + 1 << std::endl;
			icgStream << "\tJMP L" << statementId + 4 << std::endl;
			icgStream << "L" << statementId + 1 << ":" << std::endl;

			ExecuteRelExpression(root->children[2], statementId);

			icgStream << "\tCMP AX, 0" << std::endl;
			icgStream << "\tJNE L" << statementId + 2 << std::endl;
			icgStream << "\tJMP L" << statementId +  4 << std::endl;
			icgStream << "L" << statementId + 2 << ":" << std::endl;
			icgStream << "\tMOV AX, 1" << std::endl;
			icgStream << "\tJMP L" << statementId + 3 << std::endl;
			icgStream << "L" << statementId + 4 << ":" << std::endl;
			icgStream << "\tMOV AX, 0" << std::endl;
			icgStream << "L" << statementId + 3 << ":" << std::endl;

			statementId += 4;
		}	
	}
}

void ExecuteRelExpression(ParseTreeNode *root, size_t &statementId)
{
	if(root->children.size() == 1)
	{
		ExecuteSimpleExpression(root->children[0], statementId);
	}
	else // size 3
	{
		ExecuteSimpleExpression(root->children[2], statementId);

		icgStream << "\tMOV DX, AX" << std::endl;
	
		ExecuteSimpleExpression(root->children[0], statementId);

		icgStream << "\tCMP AX, DX" << std::endl;

		std::string opName = root->children[1]->name;

		if(opName == "<")
		{
			icgStream << "\tJL L" << statementId + 1 << std::endl;
		}
		else if(opName == "<=")
		{
			icgStream << "\tJLE L" << statementId + 1 << std::endl;
		}
		else if(opName == ">")
		{
			icgStream << "\tJG L" << statementId + 1 << std::endl;
		}
		else if(opName == ">=")
		{
			icgStream << "\tJGE L" << statementId + 1 << std::endl;
		}
		else if(opName == "==")
		{
			icgStream << "\tJE L" << statementId + 1 << std::endl;
		}
		else
		{
			icgStream << "\tJNE L" << statementId + 1 << std::endl;
		}

		icgStream << "\tJMP L" << statementId + 3 << std::endl;
		icgStream << "L" << statementId + 1 << ":" << std::endl;
		icgStream << "\tMOV AX, 1" << std::endl;
		icgStream << "\tJMP L" << statementId + 2 << std::endl;
		icgStream << "L" << statementId + 3 << ":" << std::endl;
		icgStream << "\tMOV AX, 0" << std::endl;
		icgStream << "L" << statementId + 2 << ":" << std::endl;

		statementId += 3;
	}
}

void ExecuteSimpleExpression(ParseTreeNode *root, size_t &statementId)
{
	if(root->children.size() == 1)
	{
		ExecuteTerm(root->children[0], statementId);
	}
	else // size 3
	{
		ExecuteTerm(root->children[2], statementId);		

		icgStream << "\tMOV DX, AX" << std::endl;

		ExecuteSimpleExpression(root->children[0], statementId);

		std::string opName = root->children[1]->symbolInfo->GetName();

		if(opName == "+")
		{
			icgStream << "\tADD AX, DX" << std::endl;
		}
		else
		{
			icgStream << "\tSUB AX, DX" << std::endl;
		}

		icgStream << "\tPUSH AX" << std::endl;
		icgStream << "\tPOP AX" << std::endl;
	}
}

void ExecuteTerm(ParseTreeNode *root, size_t &statementId)
{
	if(root->children.size() == 1)
	{
		ExecuteUnaryExpression(root->children[0], statementId);
	}
	else // size 3
	{
		ExecuteUnaryExpression(root->children[2], statementId);

		icgStream << "\tMOV CX, AX" << std::endl;

		ExecuteTerm(root->children[0], statementId);

		std::string opName = root->children[1]->symbolInfo->GetName();

		icgStream << "\tCWD" << std::endl;

		if(opName == "*")
		{
			icgStream << "\tMUL CX" << std::endl;
			icgStream << "\tPUSH AX" << std::endl;
			icgStream << "\tPOP AX" << std::endl;
		}
		else if(opName == "/")
		{
			icgStream << "\tDIV CX" << std::endl;
			icgStream << "\tPUSH AX" << std::endl;
			icgStream << "\tPOP AX" << std::endl;
		}
		else
		{
			icgStream << "\tDIV CX" << std::endl;
			icgStream << "\tPUSH DX" << std::endl;
			icgStream << "\tPOP AX" << std::endl;
		}
	}
}

void ExecuteUnaryExpression(ParseTreeNode *root, size_t &statementId)
{
	if(root->children.size() == 1)
	{
		ExecuteFactor(root->children[0], statementId);
	}
	else // size 2
	{
		std::string opName = root->children[0]->symbolInfo->GetName();

		if(opName == "-")
		{
			ExecuteUnaryExpression(root->children[1], statementId);

			icgStream << "\tNEG AX" << std::endl;
		}
		else if(opName == "!")
		{
			ExecuteUnaryExpression(root->children[1], statementId);

			icgStream << "\tNOT AX" << std::endl;
		}

		icgStream << "\tPUSH AX" << std::endl;
		icgStream << "\tPOP AX" << std::endl;
	}
}

void ExecuteFactor(ParseTreeNode *root, size_t &statementId)
{
	if(root->children.size() == 1)
	{
		if(root->children[0]->name == "CONST_INT")
		{
			icgStream << "\tMOV AX, " << root->children[0]->symbolInfo->GetName() << std::endl;
		}
		else if(root->children[0]->name == "variable")
		{
			ExecuteVariable(root->children[0], statementId);
		}
	}
	else if(root->children.size() == 2)
	{
		ParseTreeNode *idNode = root->children[0]->children[0];
		SymbolInfo *idSymbol = st->LookUp(idNode->symbolInfo->GetName());

		if(idSymbol->GetScopeID() == 1)
		{
			icgStream << "\tMOV AX, " << idNode->symbolInfo->GetName() << std::endl;
		}
		else
		{
			icgStream << "\tMOV AX, [BP-" << idSymbol->GetStackOffset() << "]" << std::endl;
		}

		std::string opName = root->children[1]->symbolInfo->GetName();

		if(opName == "++")
		{
			icgStream << "\tINC AX" << std::endl;
		}
		else
		{
			icgStream << "\tDEC AX" << std::endl;
		}

		if(idSymbol->GetScopeID() == 1)
		{
			icgStream << "\tMOV " << idNode->symbolInfo->GetName() << ", AX" << std::endl;
		}
		else
		{
			icgStream << "\tMOV [BP-" << idSymbol->GetStackOffset() << "], AX" << std::endl;
		}
	}
}

void ExecuteVariable(ParseTreeNode *root, size_t &statementId)
{
	ParseTreeNode *idNode = root->children[0];
	SymbolInfo *idSymbol = st->LookUp(idNode->symbolInfo->GetName());

	if(idSymbol->GetScopeID() == 1)
	{
		icgStream << "\tMOV AX, " << idNode->symbolInfo->GetName() << std::endl;
	}
	else
	{
		icgStream << "\tMOV AX, [BP-" << idSymbol->GetStackOffset() << "]" << std::endl;
	}
}

std::vector<ParseTreeNode *> GetDeclaredVariables(ParseTreeNode *root)
{
	if(root->children.size() == 3)
	{
		std::vector<ParseTreeNode *> toReturn = GetDeclaredVariables(root->children[0]);
		ParseTreeNode *variable = root->children[2];

		toReturn.push_back(variable);

		return toReturn;
	}
	else // size 1
	{
		ParseTreeNode *variable = root->children[0];
		std::vector<ParseTreeNode *> toReturn = {variable};

		return toReturn;
	}
}

std::vector<ParseTreeNode *> GetStatements(ParseTreeNode *root)
{
	if(root->children.size() == 1)
	{
		ParseTreeNode *statement = root->children[0];
		std::vector<ParseTreeNode *> toReturn = {statement};

		return toReturn;
	}
	else
	{
		std::vector<ParseTreeNode *> toReturn = GetStatements(root->children[0]);
		ParseTreeNode *statement = root->children[1];

		toReturn.push_back(statement);

		return toReturn;
	}
}

std::vector<ParseTreeNode *> GetParamVars(ParseTreeNode *root)
{
	if(root->children.size() == 4)
	{
		std::vector<ParseTreeNode *> toReturn = GetParamVars(root->children[0]);
		ParseTreeNode *idNode = root->children[3];

		toReturn.push_back(idNode);

		st->Insert(idNode->symbolInfo);

		return toReturn;
	}
	else // size 2
	{
		ParseTreeNode *idNode = root->children[1];
		std::vector<ParseTreeNode *> toReturn = {idNode};

		st->Insert(idNode->symbolInfo);

		return toReturn;
	}
}

std::vector<ParseTreeNode *> GetFunctionDefinitions(ParseTreeNode *root)
{
	if(root->children.size() == 1)
	{
		ParseTreeNode *unit = root->children[0]->children[0];

		if(unit->name == "func_definition")
		{
			std::vector<ParseTreeNode *> toReturn = {unit};

			return toReturn;
		}
		else
		{
			return std::vector<ParseTreeNode *>();
		}
	}
	else // size 2
	{
		std::vector<ParseTreeNode *> toReturn = GetFunctionDefinitions(root->children[0]);
		ParseTreeNode *unit = root->children[1]->children[0];

		if(unit->name == "func_definition")
		{
			toReturn.push_back(unit);
		}

		return toReturn;
	}
}