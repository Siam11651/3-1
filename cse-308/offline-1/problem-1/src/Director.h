#pragma once

#include "PCBuilder.h"

class Director
{
protected:
    PCBuilder *pcBuilder;
    RAMEnum ramEnum;
    GraphicsCardEnum graphicsCardEnum;
public:
    Director(PCBuilder *pcBuilder);
    void Build();
    void SetRAM(RAMEnum ramEnum);
    void SetGraphicsCard(GraphicsCardEnum graphicsCardEnum);
};