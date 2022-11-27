#pragma once

#include <string>
#include "Color.h"

/**
 * @brief Red class implementing color
 * 
 */
class Red : public Color
{
public:
    /**
     * @brief Get the name of the color 
     * 
     * @return std::string 
     */
    std::string GetValue();
};