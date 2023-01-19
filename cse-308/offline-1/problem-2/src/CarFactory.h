#pragma once

#include <string>
#include "Car.h"

class CarFactory
{
public:
    virtual Car *GetNewCarPointer() = 0;
    static CarFactory *GetFactoryPointerOnContinent(const std::string &continent);
};

#include "AsianCarFactory.h"
#include "EuropeanCarFactory.h"
#include "USACarFactory.h"