#pragma once

#include "Car.h"
#include "Color.h"

/**
 * @brief Continent factory interface
 * 
 */
class Continent
{
public:
    /**
     * @brief Get pointer to new car
     * 
     * @return Car* 
     */
    Car *GetNewCar();
    /**
     * @brief Get pointer to new color
     * 
     * @return Color* 
     */
    Color *GetNewColor();
};
