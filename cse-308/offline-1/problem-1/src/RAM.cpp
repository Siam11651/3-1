#include "RAM.h"

RAM::RAM()
{
    partType = "RAM";
}

std::string RAM::Print()
{
    std::stringstream stringStream("");

    stringStream << "8 GB DDR4 " << speed << " MHz";

    return stringStream.str();
}