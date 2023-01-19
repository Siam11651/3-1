#pragma once

#include "Part.h"

enum class DVDEnum
{
    NONE, DVD
};

class DVD : public Part
{
public:
    DVD();
    std::string Print();
};