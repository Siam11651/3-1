#include "CarFactory.h"

CarFactory *CarFactory::GetFactoryPointerOnContinent(const std::string &continent)
{
    if(continent == "asia")
    {
        return new AsianCarFactory();
    }
    else if(continent == "europe")
    {
        return new EuropeanCarFactory();
    }
    else if(continent == "usa")
    {
        return new USACarFactory();
    }
    else
    {
        return NULL;
    }
}