#pragma once

#include "CarFactory.h"
#include "Tesla.h"

class USACarFactory : public CarFactory
{
public:
    Car *GetNewCarPointer();
};