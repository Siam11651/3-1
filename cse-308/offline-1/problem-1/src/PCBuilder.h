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
    Processor *processor;
    RAM *ram;
    HDD *hdd;
    DVD *dvd;
    Cooler *cooler;
    GraphicsCard *graphicsCard;
public:
    PCBuilder();
    PC *GetBuiltPCPointer() const;
    void SetProcessor(ProcessorEnum processorEnum);
    void SetRAM(RAMEnum ramEnum);
    void SetHDD(HDDEnum hddEnum);
    void SetDVD(DVDEnum dvdEnum);
    void SetCooler(CoolerEnum coolerEnum);
    void SetGraphicsCard(GraphicsCardEnum graphicsCardEnum);
};