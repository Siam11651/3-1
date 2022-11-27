#pragma once

#include <string>

/**
 * @brief Car interface
 * 
 */
class Car
{
public:
    /**
     * @brief Get car name
     * 
     * @return std::string 
     */
    virtual std::string GetValue() = 0;
};