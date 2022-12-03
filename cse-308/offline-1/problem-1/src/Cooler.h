#pragma once

#include "Part.h"

enum class CoolerEnum
{
    CPU_COOLER, LIQUID_COOLER
};

class Cooler : public Part
{
protected:
    std::string coolerType;
public:
    Cooler();
    std::string Print();
};