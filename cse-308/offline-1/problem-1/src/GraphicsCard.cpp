#include "GraphicsCard.h"

GraphicsCard::GraphicsCard()
{
    partType = "GRAPHICS_CARD";
}

std::string GraphicsCard::Print()
{
    std::stringstream stringStream("");

    stringStream << vram << " GB";

    return stringStream.str();
}