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
    Processor *processor;
    RAM *ram;
    HDD *hdd;
    DVD *dvd;
    Cooler *cooler;
    GraphicsCard *graphicsCard;

    PC();
public:
    PC(PCBuilder *pcBuilder);
    ~PC();
};