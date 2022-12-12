#include "EuropeanCarFactory.h"

Car *EuropeanCarFactory::GetNewCarPointer()
{
    return new BMW();
}