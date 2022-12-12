#pragma once

#include "Part.h"

enum class ProcessorEnum
{
    NONE, AMD_RYZEN7_5700X, INTEL11GEN_CORE_I5, INTEL11GEN_CORE_I7, INTEL11GEN_CORE_I9
};

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