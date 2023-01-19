#include "Cooler.h"

Cooler::Cooler()
{
    partType = "COOLER";
}

std::string Cooler::Print()
{
    return coolerType + " Cooler";
}