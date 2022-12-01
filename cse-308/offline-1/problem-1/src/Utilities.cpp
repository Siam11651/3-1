#include "Utilities.h"

std::string Utilities::ToLower(const std::string &string)
{
    std::string newString = string;

    for(size_t i = 0; i < newString.size(); ++i)
    {
        if('A' <= newString[i] && newString[i] <= 'Z')
        {
            newString[i] -= 'A';
            newString[i] += 'a';
        }
    }

    return newString;
}