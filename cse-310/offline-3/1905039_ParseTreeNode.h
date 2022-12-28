#pragma once

#include <string>
#include <vector>

class ParseTreeNode
{
public:
    std::string name;
    bool terminal;
    std::vector<ParseTreeNode> children;
};