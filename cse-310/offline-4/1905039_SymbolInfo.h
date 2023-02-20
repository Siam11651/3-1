#pragma once

#include <string>
#include <vector>
#include "1905039_ClassDeclarations.h"

class SymbolInfo
{
private:
    std::string name, type, idType, dataType;
    size_t symbolStart, symbolEnd;
    SymbolInfo* next;
    bool array;
    std::vector<std::pair<std::string, std::string>> paramList;
    bool defined;
    size_t stackOffset;
    size_t scopeId;
    bool isParam;
public:
    SymbolInfo(const std::string &name, const std::string &type);
    void SetName(const std::string &name);
    void SetType(const std::string &type);
    void SetNext(SymbolInfo *next);
    std::string GetName() const;
    std::string GetType() const;
    void SetSymbolStart(size_t start);
    void SetSymbolEnd(size_t end);
    size_t GetSymbolStart() const;
    size_t GetSymbolEnd() const;
    void SetIDType(const std::string id_type);
    void SetDataType(const std::string data_type);
    void SetArray(bool array);
    std::string GetIDType() const;
    std::string GetDataType() const;
    bool IsArray() const;
    SymbolInfo *GetNext() const;
    void SetParamList(std::vector<std::pair<std::string, std::string>> &paramList);
    std::vector<std::pair<std::string, std::string>> GetParamList() const;
    void SetDefined(bool defined);
    bool GetDefined() const;
    size_t GetStackOffset() const;
    void SetStackOffset(size_t offset);
    void SetScopeID(size_t scopeId);
    size_t GetScopeID() const;
    void SetParam(bool isParam);
    bool IsParam() const;
};