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

size_t SymbolInfo::GetSymbolStart() const
{
    return symbolStart;
}

size_t SymbolInfo::GetSymbolEnd() const
{
    return symbolEnd;
}

void SymbolInfo::SetIDType(const std::string idType)
{
    this->idType = idType;
}

void SymbolInfo::SetDataType(const std::string dataType)
{
    this->dataType = dataType;
}

void SymbolInfo::SetArray(bool array)
{
    this->array = array;
}

std::string SymbolInfo::GetIDType() const
{
    return idType;
}

std::string SymbolInfo::GetDataType() const
{
    return dataType;
}

bool SymbolInfo::IsArray() const
{
    return array;
}

void SymbolInfo::SetParamList(std::vector<std::pair<std::string, std::string>> &paramList)
{
    this->paramList = paramList;
}

std::vector<std::pair<std::string, std::string>> SymbolInfo::GetParamList() const
{
    return paramList;
}

void SymbolInfo::SetDefined(bool defined)
{
    this->defined = defined;
}

bool SymbolInfo::GetDefined() const
{
    return defined;
}