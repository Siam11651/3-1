#include "HDD.h"

HDD::HDD()
{
    partType = "HDD";
}

std::string HDD::Print()
{
    std::stringstream stringStream("");

    stringStream << volume << ' ' << volumeFactor <<  'B';

    return stringStream.str();
}