#pragma once

#include <fstream>
#include <cstddef>
#include <sstream>
#include <vector>
#include <stack>
#include "1905039_ParseTreeNode.h"
#include "1905039_SymbolTable.h"

void PrintParseTree(ParseTreeNode &parseTreeNode, size_t depth);
void SetLine(ParseTreeNode &parseTreeNode);
void InsertID(ParseTreeNode &root, const std::string dataType, SymbolTable *symbolTable);
void SetParams(ParseTreeNode &root, std::vector<std::pair<std::string, std::string>> &paramList, bool &error, bool definition);
void SetFactorValue(ParseTreeNode &root);
void SetUnaryExpressionValue(ParseTreeNode &root);
void SetTermValue(ParseTreeNode &root);
void SetSimpleExpressionValue(ParseTreeNode &root);
void SetRelExpressionValue(ParseTreeNode &root);
void SetLogicExpressionValue(ParseTreeNode &root);
void SetExpressionValue(ParseTreeNode &root);
std::string GetVariableDataType(ParseTreeNode &root);
std::string GetFactorDataType(ParseTreeNode &root);
std::string GetUnaryExpressionDataType(ParseTreeNode &root);
std::string GetTermDataType(ParseTreeNode &root);
std::string GetSimpleExpressionDataType(ParseTreeNode &root);
std::string GetRelExpressionDataType(ParseTreeNode &root);
std::string GetLogicExpressionDataType(ParseTreeNode &root);
std::string GetExpressionDataType(ParseTreeNode &root);
void SetArgumentTypeList(ParseTreeNode &root, std::vector<std::string> &argumentTypeList);