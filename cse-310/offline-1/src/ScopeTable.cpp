#include <iostream>
#include "ScopeTable.h"

ScopeTable::ScopeTable(size_t id, size_t numberOfBuckets, ScopeTable* parent, std::ostream *output = NULL)
{
    this->id = id;
    this->numberOfBuckets = numberOfBuckets;
    buckets = new SymbolInfo *[numberOfBuckets];
    this->parent = parent;
    this->bucketSizes = new size_t[numberOfBuckets];

    for(size_t i = 0; i < numberOfBuckets; ++i)
    {
        bucketSizes[i] = 0;
    }

    this->output = output;

    if(output != NULL)
    {
        *output << "ScopeTable# "<< id << " created" << std::endl;
    }
}

bool ScopeTable::Insert(const SymbolInfo &symbol)
{
    size_t hash = Hash(symbol.GetName());
    size_t index = hash % numberOfBuckets;
    bool alreadyExists = false;
    SymbolInfo *next = buckets[index];

    while(next != NULL)
    {
        if(next->GetName() == symbol.GetName())
        {
            alreadyExists = true;

            break;
        }

        next = next->GetNext();
    }

    if(alreadyExists)
    {
        if(output != NULL)
        {
            *output << "\'" << symbol.GetName() << "\' already exists in the current ScopeTable" << std::endl;
        }

        return false;
    }

    SymbolInfo *newSymbol = new SymbolInfo(symbol.GetName(), symbol.GetType());
    newSymbol->SetNext(buckets[index]);
    buckets[index] = newSymbol;
    ++bucketSizes[index];

    if(output != NULL)
    {
        *output << "Inserted in ScopeTable# " << id << " at position " << index + 1 << ", " << bucketSizes[index] << std::endl;
    }

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
            if(output != NULL)
            {
                *output << "\'" << symbolName << "\' found in ScopeTable# " << id << " at position " << index + 1 << ", " << position << std::endl;
            }

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

    if(buckets[index]->GetName() == symbolName)
    {
        SymbolInfo *toDelete = buckets[index];
        buckets[index] = buckets[index]->GetNext();

        delete toDelete;

        if(output != NULL)
        {
            *output << "Deleted \'" << symbolName << "\' from ScopeTable# " << id << " at position " << index + 1 << ", " << bucketSizes[index] << std::endl; 
        }

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

                delete toDelete;

                if(output != NULL)
                {
                    *output << "Deleted \'" << symbolName << "\' from ScopeTable# " << id << " at position " << index + 1 << ", " << position - 1 << std::endl; 
                }

                --bucketSizes[index];

                return true;
            }

            current = current->GetNext();
            --position;
        }

        if(output != NULL)
        {
            *output << "Not found in the current ScopeTable" << std::endl;
        }
        
        return false;
    }
}

void ScopeTable::Print()
{
    if(output == NULL)
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
    else
    {
        *output << "ScopeTable# " << id << std::endl;

        for(size_t i = 0; i < numberOfBuckets; ++i)
        {
            *output << (i + 1) << "--> ";

            SymbolInfo *next = buckets[i];

            while(next != NULL)
            {
                *output << '<' << next->GetName() << ',' << next->GetType() << '>';

                next = next->GetNext();
            }

            *output << std::endl;
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

    if(output != NULL)
    {
        *output << "ScopeTable# " << id << " removed" << std::endl;
    }
}