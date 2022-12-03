#include "RAM.h"

RAM::RAM()
{
    partType = "RAM";
}

std::string RAM::Print()
{
    std::stringstream stringStream("");

    stringStream << volume << volumeFactor << "B DDR" << ddr << ' ' << speed << speedFactor << "Hz";

    return stringStream.str();
}