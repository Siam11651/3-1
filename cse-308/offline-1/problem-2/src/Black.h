#pragma once

#include <string>
#include "Color.h"

/**
 * @brief Black class implementing color
 * 
 */
class Black : public Color
{
public:
    /**
     * @brief Get the name of the color 
     * 
     * @return std::string 
     */
    std::string GetValue();
};