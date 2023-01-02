#pragma once

#include <string>

class SymbolInfo
{
private:
    std::string name, type;
    size_t symbolStart, symbolEnd;
    SymbolInfo* next;
public:
    SymbolInfo(const std::string &name, const std::string &type);
    void SetName(const std::string &name);
    void SetType(const std::string &type);
    void SetNext(SymbolInfo *next);
    std::string GetName() const;
    std::string GetType() const;
    void SetSymbolStart(size_t start);
    void SetSymbolEnd(size_t end);
    size_t GetSymbolStart();
    size_t GetSymbolEnd();
    SymbolInfo *GetNext() const;
};