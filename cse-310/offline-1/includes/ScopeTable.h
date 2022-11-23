#pragma once

#include <string>
#include <SymbolInfo.h>

class ScopeTable
{
private:
    size_t id;
    size_t numberOfBuckets;
    SymbolInfo **buckets;
    ScopeTable *parent;

    size_t Hash(const std::string &symbolName)
    {
        size_t hash = 0;
        size_t size = symbolName.length();

        for(size_t i = 0; i < size; ++i)
        {
            hash = (symbolName[i]) + (hash << 6) + (hash << 16) - hash;
        }

        return hash;
    }
public:
    ScopeTable(size_t id, size_t numberOfBuckets, ScopeTable* parent);
    bool Insert(SymbolInfo &symbol);
    SymbolInfo *LookUp(const std::string &symbolName);
    bool Delete(const std::string &symbolName);
    void Print();
    ScopeTable *GetParent();
    ~ScopeTable();
};