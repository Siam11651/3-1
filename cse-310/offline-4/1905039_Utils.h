#pragma once

#include <fstream>
#include <cstddef>
#include <sstream>
#include <vector>
#include <stack>
#include "1905039_ParseTreeNode.h"
#include "1905039_SymbolTable.h"

void PrintParseTree(ParseTreeNode *parseTreeNode, size_t depth);
void DeleteTree(ParseTreeNode *root);
void SetLine(ParseTreeNode *parseTreeNode);
void InsertID(ParseTreeNode *root, const std::string dataType, SymbolTable *symbolTable);
void SetParams(ParseTreeNode *root, std::vector<std::pair<std::string, std::string>> &paramList, bool &error, bool definition);
void SetFactorValue(ParseTreeNode *root);
void SetUnaryExpressionValue(ParseTreeNode *root);
void SetTermValue(ParseTreeNode *root);
void SetSimpleExpressionValue(ParseTreeNode *root);
void SetRelExpressionValue(ParseTreeNode *root);
void SetLogicExpressionValue(ParseTreeNode *root);
void SetExpressionValue(ParseTreeNode *root);
std::string GetVariableDataType(ParseTreeNode *root);
std::string GetFactorDataType(ParseTreeNode *root);
std::string GetUnaryExpressionDataType(ParseTreeNode *root);
std::string GetTermDataType(ParseTreeNode *root);
std::string GetSimpleExpressionDataType(ParseTreeNode *root);
std::string GetRelExpressionDataType(ParseTreeNode *root);
std::string GetLogicExpressionDataType(ParseTreeNode *root);
std::string GetExpressionDataType(ParseTreeNode *root);
void SetArgumentTypeList(ParseTreeNode *root, std::vector<std::string> &argumentTypeList);
void GenerateICG(ParseTreeNode *root);
std::vector<ParseTreeNode *> GetFunctionDefinitions(ParseTreeNode *root);
std::vector<ParseTreeNode *> GetParamVars(ParseTreeNode *root);
std::vector<ParseTreeNode *> GetStatements(ParseTreeNode *root);
std::vector<ParseTreeNode *> GetDeclaredVariables(ParseTreeNode *root);
void ExecuteStatement(ParseTreeNode *root, size_t &statementId, size_t &variableCount);
void ExecuteExpressionStatement(ParseTreeNode *root, size_t &statementId);
void ExecuteExpression(ParseTreeNode *root, size_t &statementId);
void ExecuteExpressionBranch(ParseTreeNode *root, size_t &statementId);
void ExecuteLogicExpression(ParseTreeNode *root, size_t &statementId);
void ExecuteLogicExpressionBranch(ParseTreeNode *root, size_t &statementId);
void ExecuteRelExpression(ParseTreeNode *root, size_t &statementId);
void ExecuteRelExpressionBranch(ParseTreeNode *root, size_t &statementId);
void ExecuteSimpleExpression(ParseTreeNode *root, size_t &statementId);
void ExecuteTerm(ParseTreeNode *root, size_t &statementId);
void ExecuteUnaryExpression(ParseTreeNode *root, size_t &statementId);
void ExecuteFactor(ParseTreeNode *root, size_t &statementId);
void ExecuteVariable(ParseTreeNode *root, size_t &statementId);
void ExecuteCompoundStatement(ParseTreeNode *root, size_t &statementId);
size_t CountStatementInStatement(ParseTreeNode *root);
size_t CountStatementInCompundStatement(ParseTreeNode *root);