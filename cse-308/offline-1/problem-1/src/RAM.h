#pragma once

#include <sstream>
#include "Part.h"

class RAM : public Part
{
protected:
    uint64_t speed;
public:
    RAM();
    std::string Print();
};