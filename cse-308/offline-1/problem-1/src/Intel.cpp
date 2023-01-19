#include "Intel.h"

std::string Intel::Print()
{
    std::stringstream sStream("");

    sStream << brand << ' ' << generation << "th Gen " << subBrand << ' ' << model;

    return sStream.str();
}