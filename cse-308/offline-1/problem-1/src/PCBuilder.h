#pragma once

#include <vector>
#include <map>
#include "PCBuilderDef.h"
#include "PC.h"
#include "Processor.h"
#include "RAM.h"
#include "HDD.h"
#include "DVD.h"
#include "Cooler.h"
#include "GraphicsCard.h"
#include "Motherboard.h"
#include "CPU.h"
#include "AMD_Ryzen7_5700X.h"
#include "Intel11GenCore_i5.h"
#include "Intel11GenCore_i7.h"
#include "Intel11GenCore_i9.h"
#include "RAM8GB2666MHzDDR4.h"
#include "RAM8GB3200MHzDDR4.h"
#include "HDD1TB.h"
#include "CPUCooler.h"
#include "LiquidCooler.h"
#include "GraphicsCard2GB.h"
#include "GraphicsCard4GB.h"

class PCBuilder
{
protected:
    std::vector<Part *> parts;
public:
    std::vector<Part *> GetParts() const;
    PC *GetBuiltPCPointer() const;
    virtual void SetProcessor() = 0;
    void SetRAM(RAMEnum ramEnum);
    void SetHDD();
    virtual void SetDVD() = 0;
    virtual void SetCooler() = 0;
    void SetGraphicsCard(GraphicsCardEnum graphicsCardEnum);
    void SetMotherboard();
    void SetCPU();
};