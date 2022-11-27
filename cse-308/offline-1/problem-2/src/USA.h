#pragma once

#include "Continent.h"
#include "Tesla.h"
#include "White.h"

/**
 * @brief USA implementing continent factory
 * 
 */
class USA
{
public:
    /**
     * @brief Get pointer to new car from USA
     * 
     * @return Car* 
     */
    Car *GetNewCar();
    /**
     * @brief Get pointer to new color from USA
     * 
     * @return Color* 
     */
    Color *GetNewColor();
};
