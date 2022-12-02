#pragma once

#include <sstream>
#include "Part.h"

class RAM : public Part
{
protected:
    uint64_t speed;
    std::string speedFactor;
    uint64_t volume;
    std::string volumeFactor;
    uint64_t ddr;
public:
    RAM();
    std::string Print();
};