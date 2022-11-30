#pragma once

#include "Processor.h"
#include "RAM.h"
#include "HDD.h"
#include "DVD.h"
#include "GraphicsCard.h"

class PC
{
protected:
    Processor *processor;
    RAM *ram;
    HDD *hdd;
    DVD *dvd;
    GraphicsCard *graphicsCard;
public:
    Processor *GetProcessor();
    RAM *GetRAM();
    HDD *GetHDD();
    DVD *GetDVD();
    GraphicsCard *GetGraphicsCard();
    ~PC();
};