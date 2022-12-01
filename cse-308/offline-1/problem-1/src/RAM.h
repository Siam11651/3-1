#pragma once

#include <sstream>
#include "Part.h"

class RAM : public Part
{
protected:
    uint64_t speed;
    uint64_t volume;
    uint64_t ddr;
public:
    RAM();
    std::string Print();
};