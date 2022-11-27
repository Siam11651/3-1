#pragma once

#include <string>
#include "Car.h"

/**
 * @brief BMW implementing car
 * 
 */
class BMW : public Car
{
public:
    /**
     * @brief Get car name
     * 
     * @return std::string 
     */
    virtual std::string GetValue();
};