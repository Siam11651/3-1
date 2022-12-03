#pragma once

#include <sstream>
#include "Part.h"

enum class GraphicsCardEnum
{
    NONE, GRAPHICS_CARD_2GB, GRAPHICS_CARD_4GB
};

class GraphicsCard : public Part
{
protected:
    uint64_t vram;
    std::string vramFactor;
public:
    GraphicsCard();
    std::string Print();
};