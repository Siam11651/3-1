#pragma once

#include <sstream>
#include "Part.h"

enum class RAMEnum
{
    NONE, RAM8GB2666MHZ_DDR4, RAM8GB3200MHZ_DDR4
};

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