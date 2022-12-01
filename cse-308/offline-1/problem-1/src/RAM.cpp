#include "RAM.h"

RAM::RAM()
{
    partType = "RAM";
}

std::string RAM::Print()
{
    std::stringstream stringStream("");

    stringStream << volume << " GB DDR" << ddr << ' ' << speed << " MHz";

    return stringStream.str();
}