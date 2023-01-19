#include "USACarFactory.h"

Car *USACarFactory::GetNewCarPointer()
{
    return new Tesla();
}