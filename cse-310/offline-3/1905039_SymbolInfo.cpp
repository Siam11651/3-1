#include "1905039_SymbolInfo.h"

SymbolInfo::SymbolInfo(const std::string &name, const std::string &type)
{
    this->name = name;
    this->type = type;
    next = NULL;
}

void SymbolInfo::SetName(const std::string &name)
{
    this->name = name;
}

void SymbolInfo::SetType(const std::string &type)
{
    this->type = type;
}

void SymbolInfo::SetNext(SymbolInfo *next)
{
    this->next = next;
}

std::string SymbolInfo::GetName() const
{
    return this->name;
}

std::string SymbolInfo::GetType() const
{
    return this->type;
}

SymbolInfo *SymbolInfo::GetNext() const
{
    return next;
}

void SymbolInfo::SetSymbolStart(size_t start)
{
    symbolStart = start;
}

void SymbolInfo::SetSymbolEnd(size_t end)
{
    symbolEnd = end;
}

size_t SymbolInfo::GetSymbolStart()
{
    return symbolStart;
}

size_t SymbolInfo::GetSymbolEnd()
{
    return symbolEnd;
}