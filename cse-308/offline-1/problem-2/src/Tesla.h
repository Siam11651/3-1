#pragma once

#include <string>
#include "Car.h"

/**
 * @brief Tesla implementing car
 * 
 */
class Tesla : public Car
{
public:
    /**
     * @brief Get car name
     * 
     * @return std::string 
     */
    virtual std::string GetValue();
};