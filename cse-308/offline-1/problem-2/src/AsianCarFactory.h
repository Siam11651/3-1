#pragma once

#include "CarFactory.h"
#include "Toyota.h"

class AsianCarFactory : public CarFactory
{
public:
    Car *GetNewCarPointer();
};