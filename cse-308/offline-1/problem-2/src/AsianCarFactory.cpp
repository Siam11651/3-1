#include "AsianCarFactory.h"

Car *AsianCarFactory::GetNewCarPointer()
{
    return new Toyota();
}