#pragma once

#include "Continent.h"
#include "BMW.h"
#include "Black.h"

/**
 * @brief BMW implementing continent factory
 * 
 */
class Europe
{
public:
    /**
     * @brief Get pointer to new car from Europe
     * 
     * @return Car* 
     */
    Car *GetNewCar();
    /**
     * @brief Get pointer to new color from Europe
     * 
     * @return Color* 
     */
    Color *GetNewColor();
};
