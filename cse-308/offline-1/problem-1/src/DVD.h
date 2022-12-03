#pragma once

#include "Part.h"

enum class DVDEnum
{
    DVD
};

class DVD : public Part
{
public:
    DVD();
    std::string Print();
};