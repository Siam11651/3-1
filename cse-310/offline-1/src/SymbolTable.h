#pragma once

#include <iostream>
#include "ScopeTable.h"

class SymbolTable
{
private:
    size_t scopeCount;
    size_t numberOfBuckets;
    ScopeTable *currentScope;
    std::ostream *output;

    void PrintScope(ScopeTable *scope);
public:
    SymbolTable(size_t numberOfBuckets, std::ostream *output = NULL);
    ScopeTable *GetCurrentScope();
    void EnterScope();
    void ExitScope();
    bool Insert(SymbolInfo &symbol);
    bool Delete(const std::string &symbolName);
    SymbolInfo *LookUp(const std::string &symbolName);
    void PrintCurrentScope();
    void PrintAllScope();
    size_t GetScopeCount();
    ~SymbolTable();
};