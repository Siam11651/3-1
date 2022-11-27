#pragma once

#include <string>

/**
 * @brief Color interface
 * 
 */
class Color
{
public:
    /**
     * @brief Get the name of the color
     * 
     * @return std::string 
     */
    virtual std::string GetValue() = 0;
};
