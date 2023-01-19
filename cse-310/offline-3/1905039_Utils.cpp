#include "1905039_Utils.h"

extern std::ofstream parseTreeStream;
extern std::ofstream errorStream;
extern SymbolTable *st;
extern size_t errorCount;

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
	if(root.children.size() == 6)
	{
		InsertID(root.children[0], dataType, st);

		if(dataType == "VOID")
		{
			errorStream << "Line# " << root.children[2].symbolInfo->GetSymbolStart() << ": Variable or field '" << root.children[2].symbolInfo->GetName() << "' declared void" << std::endl;
			
			++errorCount;
		}
		else
		{
			SymbolInfo* thisScopeSymbol = st->LookUpThisScope(root.children[2].symbolInfo->GetName());

			if(thisScopeSymbol == NULL)
			{
				root.children[2].symbolInfo->SetDataType(dataType);
				root.children[2].symbolInfo->SetArray(true);
				symbolTable->Insert(root.children[2].symbolInfo);
			}
			else
			{
				if(thisScopeSymbol->GetIDType() == "VARIABLE")
				{
					if(thisScopeSymbol->GetDataType() == dataType)
					{
						errorStream << "Line# " << root.children[2].symbolInfo->GetSymbolStart() << ": Redefinition of variable \'" << root.children[2].symbolInfo->GetName() << "\'" << std::endl;

						++errorCount;
					}
					else
					{
						errorStream << "Line# " << root.children[2].symbolInfo->GetSymbolStart() << ": Conflicting types for\'" << root.children[2].symbolInfo->GetName() << "\'" << std::endl;

						++errorCount;
					}
				}
				else
				{
					errorStream << "Line# " << root.children[2].symbolInfo->GetSymbolStart() << ": \'" << root.children[2].symbolInfo->GetName() << "\' redeclared as different kind of symbol" << std::endl;

					++errorCount;
				}
			}
		}
	}
	else if(root.children.size() == 4)
	{
		if(dataType == "VOID")
		{
			errorStream << "Line# " << root.children[0].symbolInfo->GetSymbolStart() << ": Variable or field '" << root.children[0].symbolInfo->GetName() << "' declared void" << std::endl;
			
			++errorCount;
		}
		else
		{
			SymbolInfo* thisScopeSymbol = st->LookUpThisScope(root.children[0].symbolInfo->GetName());

			if(thisScopeSymbol == NULL)
			{
				root.children[0].symbolInfo->SetDataType(dataType);
				root.children[0].symbolInfo->SetArray(true);
				symbolTable->Insert(root.children[0].symbolInfo);
			}
			else
			{
				if(thisScopeSymbol->GetIDType() == "VARIABLE")
				{
					if(thisScopeSymbol->GetDataType() == dataType)
					{
						errorStream << "Line# " << root.children[0].symbolInfo->GetSymbolStart() << ": Redefinition of variable \'" << root.children[0].symbolInfo->GetName() << "\'" << std::endl;

						++errorCount;
					}
					else
					{
						errorStream << "Line# " << root.children[0].symbolInfo->GetSymbolStart() << ": Conflicting types for\'" << root.children[0].symbolInfo->GetName() << "\'" << std::endl;

						++errorCount;
					}
				}
				else
				{
					errorStream << "Line# " << root.children[0].symbolInfo->GetSymbolStart() << ": \'" << root.children[0].symbolInfo->GetName() << "\' redeclared as different kind of symbol" << std::endl;

					++errorCount;
				}
			}
		}
	}
	else if(root.children.size() == 3)
	{
		InsertID(root.children[0], dataType, st);

		if(dataType == "VOID")
		{
			errorStream << "Line# " << root.children[2].symbolInfo->GetSymbolStart() << ": Variable or field '" << root.children[2].symbolInfo->GetName() << "' declared void" << std::endl;
			
			++errorCount;
		}
		else
		{
			SymbolInfo* thisScopeSymbol = st->LookUpThisScope(root.children[2].symbolInfo->GetName());

			if(thisScopeSymbol == NULL)
			{
				root.children[2].symbolInfo->SetDataType(dataType);
				symbolTable->Insert(root.children[2].symbolInfo);
			}
			else
			{
				if(thisScopeSymbol->GetIDType() == "VARIABLE")
				{
					if(thisScopeSymbol->GetDataType() == dataType)
					{
						errorStream << "Line# " << root.children[2].symbolInfo->GetSymbolStart() << ": Redefinition of variable \'" << root.children[2].symbolInfo->GetName() << "\'" << std::endl;

						++errorCount;
					}
					else
					{
						errorStream << "Line# " << root.children[2].symbolInfo->GetSymbolStart() << ": Conflicting types for\'" << root.children[2].symbolInfo->GetName() << "\'" << std::endl;

						++errorCount;
					}
				}
				else
				{
					errorStream << "Line# " << root.children[2].symbolInfo->GetSymbolStart() << ": \'" << root.children[2].symbolInfo->GetName() << "\' redeclared as different kind of symbol" << std::endl;

					++errorCount;
				}
			}
		}
	}
	else
	{
		if(dataType == "VOID")
		{
			errorStream << "Line# " << root.children[0].symbolInfo->GetSymbolStart() << ": Variable or field '" << root.children[0].symbolInfo->GetName() << "' declared void" << std::endl;
			
			++errorCount;
		}
		else
		{
			SymbolInfo* thisScopeSymbol = st->LookUpThisScope(root.children[0].symbolInfo->GetName());

			if(thisScopeSymbol == NULL)
			{
				root.children[0].symbolInfo->SetDataType(dataType);
				symbolTable->Insert(root.children[0].symbolInfo);
			}
			else
			{
				if(thisScopeSymbol->GetIDType() == "VARIABLE")
				{
					if(thisScopeSymbol->GetDataType() == dataType)
					{
						errorStream << "Line# " << root.children[0].symbolInfo->GetSymbolStart() << ": Redefinition of variable \'" << root.children[0].symbolInfo->GetName() << "\'" << std::endl;

						++errorCount;
					}
					else
					{
						errorStream << "Line# " << root.children[0].symbolInfo->GetSymbolStart() << ": Conflicting types for\'" << root.children[0].symbolInfo->GetName() << "\'" << std::endl;

						++errorCount;
					}
				}
				else
				{
					errorStream << "Line# " << root.children[0].symbolInfo->GetSymbolStart() << ": \'" << root.children[0].symbolInfo->GetName() << "\' redeclared as different kind of symbol" << std::endl;

					++errorCount;
				}
			}
		}
	}
}

void SetParams(ParseTreeNode &root, std::vector<std::pair<std::string, std::string>> &paramList, bool &error, bool definition)
{
	if(root.children.size() == 3 || root.children.size() == 4)
	{
		SetParams(root.children[0], paramList, error, definition);

		if(error)
		{
			return;
		}

		std::string paramName = "";

		if(root.children.size() == 4)
		{
			paramName = root.children[3].symbolInfo->GetName();
		}

		std::pair<std::string, std::string> param = {root.children[2].children[0].name, paramName};
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
			errorStream << "Line# " << root.children[3].symbolInfo->GetSymbolStart() << ": Redefinition of parameter \'" << root.children[3].symbolInfo->GetName() << "\'" << std::endl;

			++errorCount;
			error = true;
		}
		else
		{
			paramList.push_back(param);

			if(definition)
			{
				st->Insert(root.children[3].symbolInfo);
			}
		}
	}
	else if(root.children.size() == 2 || root.children.size() == 1)
	{
		std::string paramName = "";

		if(root.children.size() == 2)
		{
			paramName = root.children[1].symbolInfo->GetName();
		}

		std::pair<std::string, std::string> param = {root.children[0].children[0].name, paramName};
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
			errorStream << "Line# " << root.children[1].symbolInfo->GetSymbolStart() << ": Redefinition of parameter \'" << root.children[1].symbolInfo->GetName() << "\'" << std::endl;

			++errorCount;
			error = true;
		}
		else
		{
			paramList.push_back(param);

			if(definition)
			{
				st->Insert(root.children[1].symbolInfo);
			}
		}
	}
}

void SetFactorValue(ParseTreeNode &root)
{
	if(root.children.size() == 1)
	{
		root.valueSet = true;
		std::stringstream ss;
		std::string value = root.children[0].symbolInfo->GetName();

		ss.str(value);

		if(root.children[0].name == "CONST_INT")
		{
			root.valueType = "INT";
			
			ss >> root.intValue;
		}
		else if(root.children[0].name == "CONST_FLOAT")
		{
			root.valueType = "FLOAT";
			
			ss >> root.floatValue;
		}
	}
	else if(root.children.size() == 3)
	{
		SetExpressionValue(root.children[1]);

		if(root.children[1].valueSet)
		{
			root.valueSet = true;
			root.valueType = root.children[1].valueType;

			if(root.children[1].valueType == "INT")
			{
				root.intValue = root.children[1].intValue;
			}
			else
			{
				root.floatValue = root.children[1].floatValue;
			}
		}
	}
}

void SetUnaryExpressionValue(ParseTreeNode &root)
{
	if(root.children.size() == 1)
	{
		SetFactorValue(root.children[0]);

		if(root.children[0].valueSet)
		{
			root.valueSet = true;
			root.valueType = root.children[0].valueType;

			if(root.children[0].valueType == "INT")
			{
				root.intValue = root.children[0].intValue;
			}
			else
			{
				root.floatValue = root.children[0].floatValue;
			}
		}
	}
	else
	{
		SetUnaryExpressionValue(root.children[1]);

		if(root.children[1].valueSet)
		{
			root.valueSet = true;
			root.valueType = "FLOAT";

			if(root.children[1].valueType == "INT")
			{
				root.valueType = "INT";

				if(root.children[0].symbolInfo->GetName() == "+")
				{
					root.intValue = root.children[1].intValue;
				}
				else
				{
					root.intValue = !root.children[1].intValue;
				}
			}
			else
			{
				if(root.children[0].symbolInfo->GetName() == "+")
				{
					root.floatValue = root.children[1].floatValue;
				}
				else
				{
					root.floatValue = !root.children[1].floatValue;
				}
			}
		}
	}
}

void SetTermValue(ParseTreeNode &root)
{
	if(root.children.size() == 1)
	{
		SetUnaryExpressionValue(root.children[0]);

		if(root.children[0].valueSet)
		{
			root.valueSet = true;
			root.valueType = root.children[0].valueType;

			if(root.children[0].valueType == "INT")
			{
				root.intValue = root.children[0].intValue;
			}
			else
			{
				root.floatValue = root.children[0].floatValue;
			}
		}
	}
	else
	{
		SetTermValue(root.children[0]);
		SetUnaryExpressionValue(root.children[2]);

		if(root.children[0].valueSet && root.children[2].valueSet)
		{
			root.valueSet = true;
			root.valueType = "FLOAT";

			if(root.children[0].valueType == "INT" && root.children[2].valueType == "INT")
			{
				root.valueType = "INT";

				if(root.children[1].symbolInfo->GetName() == "*")
				{
					root.intValue = root.children[0].intValue * root.children[2].intValue;
				}
				else if(root.children[1].symbolInfo->GetName() == "/")
				{
					if(root.children[2].intValue != 0)
					{
						root.intValue = root.children[0].intValue / root.children[2].intValue;
					}
					else
					{
						root.valueSet = false;
					}
				}
				else
				{
					if(root.children[2].intValue != 0)
					{
						root.intValue = root.children[0].intValue % root.children[2].intValue;
					}
					else
					{
						root.valueSet = false;
					}
				}
			}
			else if(root.children[0].valueType == "INT" && root.children[2].valueType == "FLOAT")
			{
				if(root.children[1].symbolInfo->GetName() == "*")
				{
					root.floatValue = root.children[0].intValue * root.children[2].floatValue;
				}
				else if(root.children[1].symbolInfo->GetName() == "/")
				{
					if(root.children[2].floatValue != 0.0)
					{
						root.floatValue = root.children[0].intValue / root.children[2].floatValue;
					}
					else
					{
						root.valueSet = false;
					}
				}
				else
				{
					root.valueSet = false;
				}
			}
			else if(root.children[0].valueType == "FLOAT" && root.children[2].valueType == "INT")
			{
				if(root.children[1].symbolInfo->GetName() == "*")
				{
					root.floatValue = root.children[0].floatValue * root.children[2].intValue;
				}
				else if(root.children[1].symbolInfo->GetName() == "/")
				{
					if(root.children[2].intValue != 0)
					{
						root.floatValue = root.children[0].floatValue / root.children[2].intValue;
					}
					else
					{
						root.valueSet = false;
					}
				}
				else
				{
					if(root.children[2].intValue != 0)
					{
						root.intValue = root.children[0].intValue % root.children[2].intValue;
					}
					else
					{
						root.valueSet = false;
					}
				}
			}
			else
			{
				if(root.children[1].symbolInfo->GetName() == "*")
				{
					root.floatValue = root.children[0].floatValue * root.children[2].floatValue;
				}
				else if(root.children[1].symbolInfo->GetName() == "/")
				{
					if(root.children[2].floatValue != 0)
					{
						root.floatValue = root.children[0].floatValue / root.children[2].floatValue;
					}
					else
					{
						root.valueSet = false;
					}
				}
				else
				{
					root.valueSet = false;
				}
			}
		}
	}
}

void SetSimpleExpressionValue(ParseTreeNode &root)
{
	if(root.children.size() == 1)
	{
		SetTermValue(root.children[0]);

		if(root.children[0].valueSet)
		{
			root.valueSet = true;
			root.valueType = root.children[0].valueType;

			if(root.children[0].valueType == "INT")
			{
				root.intValue = root.children[0].intValue;
			}
			else
			{
				root.floatValue = root.children[0].floatValue;
			}
		}
	}
	else
	{
		SetSimpleExpressionValue(root.children[0]);
		SetTermValue(root.children[2]);

		if(root.children[0].valueSet && root.children[2].valueSet)
		{
			root.valueSet = true;
			root.valueType = "FLOAT";

			if(root.children[0].valueType == "INT" && root.children[2].valueType == "INT")
			{
				root.valueType = "INT";
				
				if(root.children[1].symbolInfo->GetName() == "+")
				{
					root.intValue = root.children[0].intValue + root.children[2].intValue;
				}
				else
				{
					root.intValue = root.children[0].intValue - root.children[2].intValue;
				}
			}
			else if(root.children[0].valueType == "INT" && root.children[2].valueType == "FLOAT")
			{
				if(root.children[1].symbolInfo->GetName() == "+")
				{
					root.floatValue = root.children[0].intValue + root.children[2].floatValue;
				}
				else
				{
					root.floatValue = root.children[0].intValue - root.children[2].floatValue;
				}
			}
			else if(root.children[0].valueType == "FLOAT" && root.children[2].valueType == "INT")
			{
				if(root.children[1].symbolInfo->GetName() == "+")
				{
					root.floatValue = root.children[0].floatValue + root.children[2].intValue;
				}
				else
				{
					root.floatValue = root.children[0].floatValue - root.children[2].intValue;
				}
			}
			else
			{
				if(root.children[1].symbolInfo->GetName() == "+")
				{
					root.floatValue = root.children[0].floatValue + root.children[2].floatValue;
				}
				else
				{
					root.floatValue = root.children[0].floatValue - root.children[2].floatValue;
				}
			}
		}
	}
}

void SetRelExpressionValue(ParseTreeNode &root)
{
	if(root.children.size() == 1)
	{
		SetSimpleExpressionValue(root.children[0]);

		if(root.children[0].valueSet)
		{
			root.valueSet = true;
			root.valueType = root.children[0].valueType;

			if(root.children[0].valueType == "INT")
			{
				root.intValue = root.children[0].intValue;
			}
			else
			{
				root.floatValue = root.children[0].floatValue;
			}
		}
	}
	else
	{	
		if(root.children[0].valueSet && root.children[2].valueSet)
		{	
			if(root.children[0].valueType == "INT" && root.children[2].valueType == "INT")
			{
				if(root.children[1].symbolInfo->GetName() == "<")
				{
					root.intValue = root.children[0].intValue < root.children[2].intValue;
				}
				else if(root.children[1].symbolInfo->GetName() == "<=")
				{
					root.intValue = root.children[0].intValue <= root.children[2].intValue;
				}
				else if(root.children[1].symbolInfo->GetName() == ">")
				{
					root.intValue = root.children[0].intValue > root.children[2].intValue;
				}
				else if(root.children[1].symbolInfo->GetName() == ">=")
				{
					root.intValue = root.children[0].intValue >= root.children[2].intValue;
				}
				else if(root.children[1].symbolInfo->GetName() == "==")
				{
					root.intValue = root.children[0].intValue == root.children[2].intValue;
				}
				else
				{
					root.intValue = root.children[0].intValue != root.children[2].intValue;
				}
			}
			else if(root.children[0].valueType == "INT" && root.children[2].valueType == "FLOAT")
			{
				if(root.children[1].symbolInfo->GetName() == "<")
				{
					root.intValue = root.children[0].intValue < root.children[2].floatValue;
				}
				else if(root.children[1].symbolInfo->GetName() == "<=")
				{
					root.intValue = root.children[0].intValue <= root.children[2].floatValue;
				}
				else if(root.children[1].symbolInfo->GetName() == ">")
				{
					root.intValue = root.children[0].intValue > root.children[2].floatValue;
				}
				else if(root.children[1].symbolInfo->GetName() == ">=")
				{
					root.intValue = root.children[0].intValue >= root.children[2].floatValue;
				}
				else if(root.children[1].symbolInfo->GetName() == "==")
				{
					root.intValue = root.children[0].intValue == root.children[2].floatValue;
				}
				else
				{
					root.intValue = root.children[0].intValue != root.children[2].floatValue;
				}
			}
			else if(root.children[0].valueType == "FLOAT" && root.children[2].valueType == "INT")
			{
				if(root.children[1].symbolInfo->GetName() == "<")
				{
					root.intValue = root.children[0].floatValue < root.children[2].intValue;
				}
				else if(root.children[1].symbolInfo->GetName() == "<=")
				{
					root.intValue = root.children[0].floatValue <= root.children[2].intValue;
				}
				else if(root.children[1].symbolInfo->GetName() == ">")
				{
					root.intValue = root.children[0].floatValue > root.children[2].intValue;
				}
				else if(root.children[1].symbolInfo->GetName() == ">=")
				{
					root.intValue = root.children[0].floatValue >= root.children[2].intValue;
				}
				else if(root.children[1].symbolInfo->GetName() == "==")
				{
					root.intValue = root.children[0].floatValue == root.children[2].intValue;
				}
				else
				{
					root.intValue = root.children[0].floatValue != root.children[2].intValue;
				}
			}
			else
			{
				if(root.children[1].symbolInfo->GetName() == "<")
				{
					root.floatValue = root.children[0].floatValue < root.children[2].floatValue;
				}
				else if(root.children[1].symbolInfo->GetName() == "<=")
				{
					root.floatValue = root.children[0].floatValue <= root.children[2].floatValue;
				}
				else if(root.children[1].symbolInfo->GetName() == ">")
				{
					root.floatValue = root.children[0].floatValue > root.children[2].floatValue;
				}
				else if(root.children[1].symbolInfo->GetName() == ">=")
				{
					root.floatValue = root.children[0].floatValue >= root.children[2].floatValue;
				}
				else if(root.children[1].symbolInfo->GetName() == "==")
				{
					root.floatValue = root.children[0].floatValue == root.children[2].floatValue;
				}
				else
				{
					root.floatValue = root.children[0].floatValue != root.children[2].floatValue;
				}
			}
		}
	}
}

void SetLogicExpressionValue(ParseTreeNode &root)
{
	if(root.children.size() == 1)
	{
		SetRelExpressionValue(root.children[0]);

		if(root.children[0].valueSet)
		{
			root.valueSet = true;
			root.valueType = root.children[0].valueType;

			if(root.children[0].valueType == "INT")
			{
				root.intValue = root.children[0].intValue;
			}
			else
			{
				root.floatValue = root.children[0].floatValue;
			}
		}
	}
	else
	{
		SetRelExpressionValue(root.children[0]);
		SetRelExpressionValue(root.children[2]);

		if(root.children[0].valueSet && root.children[2].valueSet)
		{
			root.valueSet = true;
			root.valueType = "INT";

			if(root.children[0].valueType == "INT" && root.children[2].valueType == "INT")
			{
				if(root.children[1].symbolInfo->GetName() == "&&")
				{
					root.intValue = root.children[0].intValue && root.children[2].intValue;
				}
				else
				{
					root.intValue = root.children[0].intValue || root.children[2].intValue;
				}
			}
			else if(root.children[0].valueType == "INT" && root.children[2].valueType == "FLOAT")
			{
				if(root.children[1].symbolInfo->GetName() == "&&")
				{
					root.intValue = root.children[0].intValue && (int)root.children[2].floatValue;
				}
				else
				{
					root.intValue = root.children[0].intValue || (int)root.children[2].floatValue;
				}
			}
			else if(root.children[0].valueType == "FLOAT" && root.children[2].valueType == "INT")
			{
				if(root.children[1].symbolInfo->GetName() == "&&")
				{
					root.intValue = (int)root.children[0].floatValue && root.children[2].intValue;
				}
				else
				{
					root.intValue = (int)root.children[0].floatValue || root.children[2].intValue;
				}
			}
			else
			{
				if(root.children[1].symbolInfo->GetName() == "&&")
				{
					root.intValue = (int)root.children[0].floatValue && (int)root.children[2].floatValue;
				}
				else
				{
					root.intValue = (int)root.children[0].floatValue || (int)root.children[2].floatValue;
				}
			}
		}
	}
}

void SetExpressionValue(ParseTreeNode &root)
{
	if(root.children.size() == 1)
	{
		SetLogicExpressionValue(root.children[0]);

		if(root.children[0].valueSet)
		{
			root.valueSet = true;
			root.valueType = root.children[0].valueType;

			if(root.children[0].valueType == "INT")
			{
				root.intValue = root.children[0].intValue;
			}
			else
			{
				root.floatValue = root.children[0].floatValue;
			}
		}
	}
	else
	{
		SetLogicExpressionValue(root.children[2]);

		if(root.children[2].valueSet)
		{
			root.children[0].valueSet = true;
			root.children[0].valueType = root.children[0].children[0].valueType;
			root.valueSet = true;
			root.valueType = root.children[0].valueType;

			if(root.children[0].children[0].valueType == "INT")
			{
				root.children[0].intValue = root.children[0].children[0].intValue;
				root.intValue = root.children[0].intValue;
			}
			else
			{
				root.children[0].floatValue = root.children[0].children[0].floatValue;
				root.floatValue = root.children[0].floatValue;
			}
		}
	}
}

std::string GetVariableDataType(ParseTreeNode &root)
{
	SymbolInfo *variable = st->LookUp(root.children[0].symbolInfo->GetName());

	if(variable == NULL)
	{
		errorStream << "Line# " << root.children[0].symbolInfo->GetSymbolStart() << ": Undeclared variable \'" << root.children[0].symbolInfo->GetName() << "\'" << std::endl;

		++errorCount;

		return "";
	}
	else
	{
		return variable->GetDataType();
	}
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
				return "FLOAT";
			}
			else
			{
				return "INT";
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
		SymbolInfo* calledFunction = st->LookUpFunction(root.children[0].symbolInfo->GetName());

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

std::string GetUnaryExpressionDataType(ParseTreeNode &root)
{
	if(root.children.size() == 1)
	{
		return GetFactorDataType(root.children[0]);
	}
	else
	{
		std::string type = GetUnaryExpressionDataType(root.children[1]);

		if(type == "VOID")
		{
			errorStream << "Line# " << root.children[0].symbolInfo->GetSymbolStart() << ": Void cannot be used in expression" << std::endl;

			++errorCount;

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

		if(unaryExpession == "" || term == "")
		{
			return "";
		}
		else if(unaryExpession == "VOID" || term == "VOID")
		{
			errorStream << "Line# " << root.children[1].symbolInfo->GetSymbolStart() << ": Void cannot be used in expression" << std::endl;

			++errorCount;

			return "";
		}
		else
		{
			if(term == "FLOAT" || unaryExpession == "FLOAT")
			{
				if(root.children[1].symbolInfo->GetName() == "%")
				{
					errorStream << "Line# " << root.children[1].symbolInfo->GetSymbolStart() << ": Operands of modulus must be integers " << std::endl;

					++errorCount;

					SetTermValue(root.children[2]);

					if(root.children[2].valueSet)
					{
						if(root.children[2].valueType == "INT")
						{
							if(root.children[2].intValue == 0)
							{
								errorStream << "Line# " << root.children[1].symbolInfo->GetSymbolStart() << ": Warning: division by zero" << std::endl;

								++errorCount;
							}
						}
						else
						{
							if(root.children[2].floatValue == 0.0)
							{
								errorStream << "Line# " << root.children[1].symbolInfo->GetSymbolStart() << ": Warning: division by zero" << std::endl;

								++errorCount;
							}
						}
					}

					return "INT";
				}
				else
				{
					if(root.children[1].symbolInfo->GetName() == "/")
					{
						SetTermValue(root.children[2]);

						if(root.children[2].valueSet)
						{
							if(root.children[2].valueType == "INT")
							{
								if(root.children[2].intValue == 0)
								{
									errorStream << "Line# " << root.children[1].symbolInfo->GetSymbolStart() << ": Warning: division by zero" << std::endl;

									++errorCount;
								}
							}
							else
							{
								if(root.children[2].floatValue == 0.0)
								{
									errorStream << "Line# " << root.children[1].symbolInfo->GetSymbolStart() << ": Warning: division by zero" << std::endl;

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
				if(root.children[1].symbolInfo->GetName() == "/" || root.children[1].symbolInfo->GetName() == "%")
				{
					SetUnaryExpressionValue(root.children[2]);

					if(root.children[2].valueSet)
					{
						if(root.children[2].valueType == "INT")
						{
							if(root.children[2].intValue == 0)
							{
								errorStream << "Line# " << root.children[1].symbolInfo->GetSymbolStart() << ": Warning: division by zero" << std::endl;

								++errorCount;
							}
						}
						else
						{
							if(root.children[2].floatValue == 0.0)
							{
								errorStream << "Line# " << root.children[1].symbolInfo->GetSymbolStart() << ": Warning: division by zero" << std::endl;

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

		if(term == "" || simpleExpression == "")
		{
			return "";
		}
		else if(simpleExpression == "VOID" || term == "VOID")
		{
			errorStream << "Line# " << root.children[1].symbolInfo->GetSymbolStart() << ": Void cannot be used in expression" << std::endl;

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

std::string GetRelExpressionDataType(ParseTreeNode &root)
{
	if(root.children.size() == 1)
	{
		return GetSimpleExpressionDataType(root.children[0]);
	}
	else
	{
		std::string simpleExpression1 = GetSimpleExpressionDataType(root.children[0]);
		std::string simpleExpression2 = GetSimpleExpressionDataType(root.children[2]);

		if(simpleExpression1 == "" || simpleExpression2 == "")
		{
			return "";
		}
		else if(simpleExpression1 == "VOID" || simpleExpression2 == "VOID")
		{
			errorStream << "Line# " << root.children[1].symbolInfo->GetSymbolStart() << ": Void cannot be used in expression" << std::endl;

			++errorCount;

			return "";
		}
		else
		{
			return "INT"; // relop always give int	
		}
	}
}

std::string GetLogicExpressionDataType(ParseTreeNode &root)
{
	if(root.children.size() == 1)
	{
		return GetRelExpressionDataType(root.children[0]);
	}
	else // else 3
	{
		std::string relExpression1 = GetRelExpressionDataType(root.children[0]);
		std::string relExpression2 = GetRelExpressionDataType(root.children[2]);

		if(relExpression1 == "" || relExpression2 == "")
		{
			return "";
		}
		else if(relExpression1 == "VOID" || relExpression2 == "VOID")
		{
			errorStream << "Line# " << root.children[1].symbolInfo->GetSymbolStart() << ": Void cannot be used in expression" << std::endl;

			++errorCount;

			return "";
		}
		else
		{
			return "INT"; // logic op always give int
		}
	}
}

std::string GetExpressionDataType(ParseTreeNode &root)
{
	if(root.children.size() == 1)
	{
		return GetLogicExpressionDataType(root.children[0]);
	}
	else
	{
		std::string rhsType = GetLogicExpressionDataType(root.children[2]);
		std::string lhsType = GetVariableDataType(root.children[0]);

		if(rhsType == "VOID")
		{
			errorStream << "Line# " << root.children[1].symbolInfo->GetSymbolStart() << ": Void cannot be used in expression" << std::endl;

			++errorCount;
		}
		else
		{
			if(lhsType == "INT" && rhsType == "FLOAT")
			{
				errorStream << "Line# " << root.children[1].symbolInfo->GetSymbolStart() << ": Warning: possible loss of data in assignment of FLOAT to INT" << std::endl;

				++errorCount;
			}
		}

		return lhsType;
	}
}

void SetArgumentTypeList(ParseTreeNode &root, std::vector<std::string> &argumentTypeList)
{
	if(root.children.size() == 3)
	{
		SetArgumentTypeList(root.children[0], argumentTypeList);
		argumentTypeList.push_back(GetLogicExpressionDataType(root.children[2]));
	}
	else
	{
		argumentTypeList.push_back(GetLogicExpressionDataType(root.children[0]));
	}
}