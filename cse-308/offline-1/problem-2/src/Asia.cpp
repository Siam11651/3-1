#include "Asia.h"

Car *Asia::GetNewCar()
{
    return new Toyota();
}

Color *Asia::GetNewColor()
{
    return new Red();
}