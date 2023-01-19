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
#include "Motherboard.h"
#include "CPU.h"

class PC
{
protected:
    std::vector<Part *> parts;
    uint64_t basePrice;

    PC();
public:
    PC(const PCBuilder &pcBuilder);
    std::vector<Part *> GetParts() const;
    Processor *GetProcessor() const;
    RAM *GetRAM() const;
    HDD *GetHDD() const;
    DVD *GetDVD() const;
    Cooler *GetCooler() const;
    GraphicsCard *GetGraphicsCard() const;
    Motherboard *GetMotherBoard() const;
    CPU *GetCPU() const;
    uint64_t GetBasePrice() const;
    uint64_t GetTotalPrice() const;
    ~PC();
};