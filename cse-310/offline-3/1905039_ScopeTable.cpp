#include <iostream>
#include <string>
#include <sstream>
#include "1905039_ScopeTable.h"

ScopeTable::ScopeTable(size_t id, size_t numberOfBuckets, ScopeTable* parent, std::ostream *output)
{
    this->id = id;
    this->numberOfBuckets = numberOfBuckets;
    buckets = new SymbolInfo *[numberOfBuckets];
    this->parent = parent;
    this->bucketSizes = new size_t[numberOfBuckets];

    for(size_t i = 0; i < numberOfBuckets; ++i)
    {
        bucketSizes[i] = 0;
        buckets[i] = NULL;
    }

    this->output = output;
}

bool ScopeTable::Insert(SymbolInfo *symbol)
{
    size_t hash = Hash(symbol->GetName());
    size_t index = hash % numberOfBuckets;
    bool alreadyExists = false;
    SymbolInfo *next = buckets[index];

    while(next != NULL)
    {
        if(next->GetName() == symbol->GetName())
        {
            alreadyExists = true;

            break;
        }

        next = next->GetNext();
    }

    if(alreadyExists)
    {
        return false;
    }

    symbol->SetNext(buckets[index]);

    buckets[index] = symbol;
    ++bucketSizes[index];

    return true;
}

SymbolInfo *ScopeTable::LookUp(const std::string &symbolName)
{
    size_t hash = Hash(symbolName);
    size_t index = hash % numberOfBuckets;
    SymbolInfo *next = buckets[index];
    size_t position = bucketSizes[index];

    while(next != NULL)
    {
        if(next->GetName() == symbolName)
        {
            return next;
        }

        next = next->GetNext();
        --position;
    }

    return NULL;
}

bool ScopeTable::Delete(const std::string &symbolName)
{
    size_t hash = Hash(symbolName);
    size_t index = hash % numberOfBuckets;

    if(buckets[index] == NULL)
    {
        return false;
    }

    if(buckets[index]->GetName() == symbolName)
    {
        SymbolInfo *toDelete = buckets[index];
        buckets[index] = buckets[index]->GetNext();
        --bucketSizes[index];

        return true;
    }
    else
    {
        SymbolInfo *current = buckets[index];
        size_t position = bucketSizes[index];

        while(current->GetNext() != NULL)
        {
            if(current->GetNext()->GetName() == symbolName)
            {
                SymbolInfo *toDelete = current->GetNext();

                current->SetNext(current->GetNext()->GetNext());
                
                --bucketSizes[index];

                return true;
            }

            current = current->GetNext();
            --position;
        }
        
        return false;
    }
}

void ScopeTable::Print(size_t &start, size_t scopeCount)
{
    if(output != NULL)
    {
        *output << "\tScopeTable# " << id << std::endl;

        size_t &printed = start;

        for(size_t i = 0; i < numberOfBuckets; ++i)
        {
            SymbolInfo *next = buckets[i];
            std::string *symbols = new std::string[bucketSizes[i]];
            size_t j = 0;

            while(next != NULL)
            {
                std::stringstream ss("");

                if(next->IsArray())
                {
                    ss << '<' << next->GetName() << ", " << "ARRAY" << ", " << next->GetDataType() << "> ";
                }
                else
                {
                    if(next->GetIDType() == "VARIABLE")
                    {
                        ss << '<' << next->GetName() << ", " << next->GetDataType() << "> ";
                    }
                    else
                    {
                        ss << '<' << next->GetName() << ", " << "FUNCTION" << ", " << next->GetDataType() << "> ";
                    }
                }

                symbols[j] = ss.str();

                next = next->GetNext();
                ++j;
            }

            if(bucketSizes[i] > 0)
            {
                *output << '\t' << (i + 1) << "--> ";

                for(size_t j = bucketSizes[i] - 1; ; --j)
                {
                    *output << symbols[j];

                    if(j == 0)
                    {
                        break;
                    }
                }

                ++printed;

                *output << std::endl;
            }

            delete[] symbols;
        }
    }
}

ScopeTable *ScopeTable::GetParent()
{
    return parent;
}

size_t ScopeTable::GetID()
{
    return id;
}

ScopeTable::~ScopeTable()
{
    delete[] buckets;
    delete[] bucketSizes;
}