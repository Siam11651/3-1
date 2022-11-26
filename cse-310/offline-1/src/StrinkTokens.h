#pragma once

#include <string>

class StringTokens
{
    private:
    std::string *tokens;
    size_t count;

    public:
    StringTokens(const std::string &string);
    std::string *GetTokensPointer();
    size_t GetCount();
    ~StringTokens();
};