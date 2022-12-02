#pragma once

#include <string>
#include "Utilities.h"
#include "Car.h"
#include "AsianCarFactory.h"
#include "EuropeanCarFactory.h"
#include "USACarFactory.h"

class CarFactory
{
public:
    virtual Car *GetNewCarPointer() = 0;
    static CarFactory *GetFactoryPointerOnContinent(const std::string &continent);
};