#pragma once

#include <vector>
#include <map>
#include "PCBuilder.h"
#include "Processor.h"
#include "RAM.h"
#include "HDD.h"
#include "DVD.h"
#include "Cooler.h"
#include "GraphicsCard.h"

class PC
{
protected:
    size_t maxProcessors;
    size_t maxRAMs;
    size_t maxHDDs;
    size_t maxDVDs;
    size_t maxCoolers;
    size_t maxGraphicsCards;
    uint64_t basePrice;
    std::vector<Part> parts;

    PC();
public:
    PC(PCBuilder *pcBuilder);
};