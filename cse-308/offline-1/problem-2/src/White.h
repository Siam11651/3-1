#pragma once

#include <string>
#include "Color.h"

/**
 * @brief White class implementing color
 * 
 */
class White : public Color
{
public:
    /**
     * @brief Get the name of the color 
     * 
     * @return std::string 
     */
    std::string GetValue();
};