#pragma once

#include <vector>
#include <map>
#include "PCBuilderDef.h"
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
    PC(const PCBuilder &pcBuilder);
    ~PC();
};