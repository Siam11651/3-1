#pragma once

#include <string>

class SymbolInfo
{
private:
    std::string name, type;
    SymbolInfo* next;
public:
    SymbolInfo(const std::string &name, const std::string &type);
    void SetName(const std::string &name);
    void SetType(const std::string &type);
    void SetNext(SymbolInfo *next);
    std::string GetName() const;
    std::string GetType() const;
    SymbolInfo *GetNext() const;
};