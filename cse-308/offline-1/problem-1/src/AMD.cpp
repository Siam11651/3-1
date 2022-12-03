#include "AMD.h"

std::string AMD::Print()
{
    std::stringstream sStream("");

    sStream << brand << ' ' << subBrand << ' ' << series << ' ' << model;

    return sStream.str();
}