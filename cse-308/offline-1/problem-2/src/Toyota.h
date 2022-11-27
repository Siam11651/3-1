#pragma once

#include <string>
#include "Car.h"

/**
 * @brief Toyota implementing car
 * 
 */
class Toyota : public Car
{
public:
    /**
     * @brief Get car name
     * 
     * @return std::string 
     */
    virtual std::string GetValue();
};