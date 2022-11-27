#include "ContinentProducer.h"

std::unique_ptr<Continent> ContinentProducer::GetFactory(const std::string &continent)
{
    std::unique_ptr<Continent> toReturn;

    if(continent == "Asia")
    {
        
    }
    else if(continent == "USA")
    {

    }
    else if(continent == "Europe")
    {

    }
    else
    {
        toReturn.release();

        return toReturn;
    }
} 