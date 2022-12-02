#pragma once

#include "Part.h"

class Processor : public Part
{
protected:
    std::string brand;
    std::string subBrand;
    std::string model;
public:
    Processor();
    std::string GetBrand() const;
};