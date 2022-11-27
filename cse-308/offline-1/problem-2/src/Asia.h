#pragma once

#include "Continent.h"
#include "Toyota.h"
#include "Red.h"

/**
 * @brief Asia implementing continent factory
 * 
 */
class Asia
{
public:
    /**
     * @brief Get pointer to new car from Asia
     * 
     * @return Car* 
     */
    Car *GetNewCar();
    /**
     * @brief Get pointer to new color from Asia
     * 
     * @return Color* 
     */
    Color *GetNewColor();
};
