#pragma once

#include <iostream>
#include <string>
#include "1905039_ClassDeclarations.h"
#include "1905039_SymbolInfo.h"
#include "1905039_SymbolTable.h"

class ScopeTable
{
private:
    SymbolTable *symbolTable;
    size_t id;
    size_t numberOfBuckets;
    SymbolInfo **buckets;
    ScopeTable *parent;
    size_t *bucketSizes;
    std::ostream *output;
    size_t currentStackOffset;
    size_t currentParamStackOffset;

    size_t Hash(const std::string &symbolName);
public:
    ScopeTable(SymbolTable *symbolTable, size_t id, size_t numberOfBuckets, ScopeTable* parent, std::ostream *ouput = NULL);
    bool Insert(SymbolInfo *symbol);
    SymbolInfo *LookUp(const std::string &symbolName);
    bool Delete(const std::string &symbolName);
    void Print(size_t &start, size_t scopeCount);
    ScopeTable *GetParent();
    size_t GetID();
    std::vector<SymbolInfo *> GetVariables() const;
    size_t GetStackOffset() const;
    ~ScopeTable();
};