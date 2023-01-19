#pragma once

#include <string>
#include <vector>
#include "1905039_SymbolInfo.h"

class ParseTreeNode
{
public:
    std::string name;
    bool terminal;
    std::vector<ParseTreeNode> children;
    SymbolInfo *symbolInfo;
    size_t startLine, endLine;
    bool valueSet;
    std::string valueType;
    int intValue;
    float floatValue;
};