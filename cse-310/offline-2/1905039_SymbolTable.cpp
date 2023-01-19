#include "1905039_SymbolTable.h"

SymbolTable::SymbolTable(size_t numberOfBuckets, std::ostream *output)
{
    scopeCount = 1;
    maxScopeCount = 1;
    this->numberOfBuckets = numberOfBuckets;
    currentScope = new ScopeTable(scopeCount, numberOfBuckets, NULL, output);
    this->output = output;
}

void SymbolTable::EnterScope()
{
    ++scopeCount;
    ++maxScopeCount;
    ScopeTable *newScope = new ScopeTable(maxScopeCount, numberOfBuckets, currentScope, output);
    currentScope = newScope;
}

void SymbolTable::ExitScope()
{
    if(scopeCount != 1)
    {
        ScopeTable *toDelete = currentScope;
        currentScope = currentScope->GetParent();
        --scopeCount;

        delete toDelete;
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

    return toReturn;
}

void SymbolTable::PrintScope(ScopeTable *scope, size_t &start)
{
    scope->Print(start, scopeCount);
}

void SymbolTable::PrintCurrentScope()
{
    size_t start = 0;

    PrintScope(currentScope, start);
}

void SymbolTable::PrintAllScope()
{
    ScopeTable *next = currentScope;
    size_t start = 0;

    while(next != NULL)
    {
        PrintScope(next, start);

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