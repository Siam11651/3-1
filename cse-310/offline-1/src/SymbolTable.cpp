#include "SymbolTable.h"

SymbolTable::SymbolTable(size_t numberOfBuckets, std::ostream *output = NULL)
{
    scopeCount = 1;
    this->numberOfBuckets = numberOfBuckets;
    currentScope = new ScopeTable(scopeCount, numberOfBuckets, NULL);
    this->output = output;
}

void SymbolTable::EnterScope()
{
    ++scopeCount;
    ScopeTable *newScope = new ScopeTable(scopeCount, numberOfBuckets, currentScope, output);
    currentScope = newScope;
}

void SymbolTable::ExitScope()
{
    if(scopeCount == 0)
    {
        if(output != NULL)
        {
            *output << "ScopeTable# 1 cannot be removed" << std::endl;
        }
        else
        {
            std::cout << "ScopeTable# 1 cannot be removed" << std::endl;
        }
    }
    else
    {
        ScopeTable *toDelete = currentScope;
        currentScope = currentScope->GetParent();
        --scopeCount;
    }
}

bool SymbolTable::Insert(const SymbolInfo &symbol)
{
    return currentScope->Insert(symbol);
}

bool SymbolTable::Delete(const std::string &symbolName)
{
    return currentScope->Delete(symbolName);
}

SymbolInfo *SymbolTable::LookUp(const std::string &symbolName)
{
    ScopeTable *thisScope = currentScope;
    SymbolInfo *toReturn = NULL;

    while(thisScope != NULL)
    {
        SymbolInfo *symbolInfo = thisScope->LookUp(symbolName);

        if(symbolInfo == NULL)
        {
            thisScope = thisScope->GetParent();
        }
        else
        {
            toReturn = symbolInfo;

            break;
        }
    }

    if(toReturn == NULL && output != NULL)
    {
        *output << "\'" << symbolName << "\' not found in any of the ScopeTables" << std::endl;
    }

    return toReturn;
}

void SymbolTable::PrintScope(ScopeTable *scope)
{
    scope->Print();
}

void SymbolTable::PrintCurrentScope()
{
    PrintScope(currentScope);
}

void SymbolTable::PrintAllScope()
{
    ScopeTable *next = currentScope;

    while(next != NULL)
    {
        PrintScope(next);

        next = next->GetParent();
    }
}

size_t SymbolTable::GetScopeCount()
{
    return scopeCount;
}

SymbolTable::~SymbolTable()
{
    ScopeTable *next = currentScope;

    while(next != NULL)
    {
        ScopeTable *toDelete = next;
        next = next->GetParent();

        delete toDelete;
    }
}