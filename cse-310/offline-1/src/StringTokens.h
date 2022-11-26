#pragma once

#include <string>

class StringTokens
{
private:
    std::string *tokens;
    size_t count;
public:
    StringTokens(const std::string &string);
    std::string GetToken(size_t index);
    size_t GetCount();
    ~StringTokens();
};
