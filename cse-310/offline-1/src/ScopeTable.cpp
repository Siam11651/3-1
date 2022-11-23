#include <ScopeTable.h>
#include <iostream>

ScopeTable::ScopeTable(size_t id, size_t numberOfBuckets, ScopeTable* parent)
{
    this->id = id;
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

    SymbolInfo *newSymbol = new SymbolInfo(symbol.GetName(), symbol.GetType());
    newSymbol->SetNext(buckets[index]);
    buckets[index] = newSymbol;

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

bool ScopeTable::Delete(const std::string &symbolName)
{
    size_t hash = Hash(symbolName);
    size_t index = hash % numberOfBuckets;

    if(buckets[index]->GetName() == symbolName)
    {
        SymbolInfo *toDelete = buckets[index];
        buckets[index] = buckets[index]->GetNext();

        delete toDelete;

        return true;
    }
    else
    {
        SymbolInfo *current = buckets[index];

        while(current->GetNext() != NULL)
        {
            if(current->GetNext()->GetName() == symbolName)
            {
                SymbolInfo *toDelete = current->GetNext();

                current->SetNext(current->GetNext()->GetNext());

                delete toDelete;

                return true;
            }

            current = current->GetNext();
        }
        
        return false;
    }
}

void ScopeTable::Print()
{
    std::cout << "ScopeTable# " << id << std::endl;

    for(size_t i = 0; i < numberOfBuckets; ++i)
    {
        std::cout << (i + 1) << "--> ";

        SymbolInfo *next = buckets[i];

        while(next != NULL)
        {
            std::cout << '<' << next->GetName() << ',' << next->GetType() << '>';

            next = next->GetNext();
        }

        std::cout << std::endl;
    }
}

ScopeTable::~ScopeTable()
{
    delete[] buckets;
}