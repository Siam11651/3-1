#pragma once

#include "Part.h"

class Cooler : public Part
{
protected:
    std::string coolerType;
public:
    Cooler();
    std::string Print();
};