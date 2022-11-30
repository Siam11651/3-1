#pragma once

#include <sstream>
#include "Part.h"

class HDD : public Part
{
protected:
    uint64_t volume;
public:
    HDD();
    std::string Print();
};