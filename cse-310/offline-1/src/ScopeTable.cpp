#include <ScopeTable.h>

ScopeTable::ScopeTable(size_t numberOfBuckets, ScopeTable* parent)
{
    this->numberOfBuckets = numberOfBuckets;
    buckets = new SymbolInfo *[numberOfBuckets];
    this->parent = parent;
}

bool ScopeTable::Insert(SymbolInfo &symbol)
{
    size_t hash = Hash(symbol.GetName());
    size_t index = hash % numberOfBuckets;
    SymbolInfo *lookUp = LookUp(symbol.GetName());

    if(lookUp != NULL)
    {
        return false;
    }

    symbol.SetNext(buckets[index]);
    buckets[index] = &symbol;

    return true;
}

SymbolInfo *ScopeTable::LookUp(const std::string &symbolName)
{
    size_t hash = Hash(symbolName);
    size_t index = hash % numberOfBuckets;
    SymbolInfo *next = buckets[index];

    while(next != NULL)
    {
        if(next->GetName() == symbolName)
        {
            return next;
        }
    }

    return NULL;
}

ScopeTable::~ScopeTable()
{
    delete[] buckets;
}