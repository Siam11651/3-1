#pragma once

#include <string>
#include "Car.h"

enum class ContinentEnum
{
    ASIA, EUROPE, USA
};

class CarFactory
{
public:
    virtual Car *GetNewCarPointer() = 0;
    static CarFactory *GetFactoryPointerOnContinent(ContinentEnum continentEnum);
};

#include "AsianCarFactory.h"
#include "EuropeanCarFactory.h"
#include "USACarFactory.h"