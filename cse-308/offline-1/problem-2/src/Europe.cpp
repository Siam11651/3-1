#include "Europe.h"

Car *Europe::GetNewCar()
{
    return new BMW();
}

Color *Europe::GetNewColor()
{
    return new Black();
}