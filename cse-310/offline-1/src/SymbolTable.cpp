#include <SymbolTable.h>

SymbolTable::SymbolTable(size_t numberOfBuckets)
{
    scopeCount = 1;
    this->numberOfBuckets = numberOfBuckets;
    currentScope = new ScopeTable(scopeCount, numberOfBuckets, NULL);
}

void SymbolTable::EnterScope()
{
    ++scopeCount;
    ScopeTable *newScope = new ScopeTable(scopeCount, numberOfBuckets, currentScope);
    currentScope = newScope;
}

void SymbolTable::ExitScope()
{
    ScopeTable *toDelete = currentScope;
    currentScope = currentScope->GetParent();
    --scopeCount;
}

bool SymbolTable::Insert(SymbolInfo &symbol)
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