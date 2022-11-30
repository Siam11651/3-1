#include "HDD.h"

HDD::HDD()
{
    partType = "HDD";
}

std::string HDD::Print()
{
    std::stringstream stringStream("");

    stringStream << volume << " TB";

    return stringStream.str();
}