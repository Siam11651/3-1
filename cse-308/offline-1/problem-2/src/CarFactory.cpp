#include "CarFactory.h"

CarFactory *CarFactory::GetFactoryPointerOnContinent(ContinentEnum continentEnum)
{
    if(continentEnum == ContinentEnum::ASIA)
    {
        return new AsianCarFactory();
    }
    else if(continentEnum == ContinentEnum::EUROPE)
    {
        return new EuropeanCarFactory();
    }
    else if(continentEnum == ContinentEnum::USA)
    {
        return new USACarFactory();
    }
}