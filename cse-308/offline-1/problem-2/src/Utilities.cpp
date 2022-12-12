#include "Utilities.h"

std::string Utilities::ToLower(const std::string &string)
{
    std::string toReturn = string;

    for(size_t i = 0; i < toReturn.size(); ++i)
    {
        if('A' <= toReturn[i] && toReturn[i] <= 'Z')
        {
            toReturn[i] -= 'A';
            toReturn[i] += 'a';
        }
    }

    return toReturn;
}