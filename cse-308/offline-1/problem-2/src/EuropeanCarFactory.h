#pragma once

#include "CarFactory.h"
#include "BMW.h"

class EuropeanCarFactory : public CarFactory
{
public:
    Car *GetNewCarPointer();
};