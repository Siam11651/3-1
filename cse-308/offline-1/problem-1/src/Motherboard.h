#pragma once

#include "Part.h"

enum class MotherboardEnum
{
    NONE, MOTHERBOARD
};

class Motherboard : public Part
{
public:
    Motherboard();
    std::string Print();
};