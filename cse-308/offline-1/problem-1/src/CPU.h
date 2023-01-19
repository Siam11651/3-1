#pragma once

#include "Part.h"

enum class CPUEnum
{
    NONE, CPU
};

class CPU : public Part
{
public:
    CPU();
    std::string Print();
};