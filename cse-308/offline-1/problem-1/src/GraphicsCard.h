#pragma once

#include <sstream>
#include "Part.h"

class GraphicsCard : public Part
{
protected:
    uint64_t vram;
public:
    GraphicsCard();
    std::string Print();
};