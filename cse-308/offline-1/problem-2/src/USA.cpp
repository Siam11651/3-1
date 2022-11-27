#include "USA.h"

Car *USA::GetNewCar()
{
    return new Tesla();
}

Color *USA::GetNewColor()
{
    return new White();
}