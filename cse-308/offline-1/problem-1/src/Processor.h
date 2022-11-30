#pragma once

#include "Part.h"

class Processor : public Part
{
protected:
    std::string brand;
    std::string model;
public:
    Processor();
    std::string GetBrand();
    std::string GetModel();
    std::string Print();
};