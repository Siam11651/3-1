#include "CarFactory.h"

std::string CarFactory::ToLowerCase(const std::string &string)
{
    std::string toReturn = string;

    for(size_t i = 0; i < toReturn.size(); ++i)
    {
        if('A' <= toReturn[i] && toReturn[i] <= 'Z')
        {
            toReturn[i] += 'a' - 'A';
        }
    }

    return toReturn;
}

Car *CarFactory::GetNewCarPointerOnContinent(const std::string &continent)
{
    if(ToLowerCase(continent) == "asia")
    {
        return new Toyota();
    }
    else if(ToLowerCase(continent) == "europe")
    {
        return new BMW();
    }
    else if(ToLowerCase(continent) == "usa")
    {
        return new Tesla();
    }
    else
    {
        return NULL;
    }
}