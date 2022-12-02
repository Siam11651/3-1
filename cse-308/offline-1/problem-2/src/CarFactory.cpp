#include "CarFactory.h"

CarFactory *CarFactory::GetFactoryPointerOnContinent(const std::string &continent)
{
    std::string lowered = Utilities::ToLower(continent);

    if(lowered == "asia")
    {
        return new AsianCarFactory();
    }
    else if(lowered == "europe")
    {
        return new EuropeanCarFactory();
    }
    else if(lowered == "usa")
    {
        return new USACarFactory();
    }
    else
    {
        return NULL;
    }
}