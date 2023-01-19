#pragma once

#include <sstream>
#include "Part.h"

enum class HDDEnum
{
    NONE, HDD1TB
};

class HDD : public Part
{
protected:
    uint64_t volume;
    char volumeFactor;
public:
    HDD();
    std::string Print();
};