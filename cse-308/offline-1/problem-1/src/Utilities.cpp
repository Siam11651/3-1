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

std::string Utilities::FormatNewLine()
{
    std::string line;

    std::getline(std::cin, line);

    if(line.back() == '\r')
    {
        line.pop_back();
    }

    return ToLower(line);
}

bool Utilities::IsInteger(const std::string &string)
{
    for(size_t i = 0; i < string.size(); ++i)
    {
        if(!('0' <= string[i] && string[i] <= '9'))
        {
            return false;
        }
    }

    return true;
}

uint64_t Utilities::ParseItem(const std::string &string)
{
    uint64_t toReturn;
    std::stringstream stringStream;

    stringStream.str(string);

    stringStream >> toReturn;

    return toReturn;
}