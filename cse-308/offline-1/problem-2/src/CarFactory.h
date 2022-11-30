#pragma once

#include <string>
#include "Car.h"
#include "Toyota.h"
#include "BMW.h"
#include "Tesla.h"

class CarFactory
{
public:
    static std::string ToLowerCase(const std::string &string);
    static Car *GetNewCarPointerOnContinent(const std::string &continent);
};