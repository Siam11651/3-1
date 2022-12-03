#pragma once

#include "PCBuilder.h"

class Director
{
protected:
    PCBuilder *pcBuilder;
    ProcessorEnum processorEnum;
    RAMEnum ramEnum;
    HDDEnum hddEnum;
    DVDEnum dvdEnum;
    CoolerEnum coolerEnum;
    GraphicsCardEnum graphicsCardEnum;
public:
    Director(const PCBuilder &pcBuilder);
    Processor *GetProcessor() const;
    RAM *GetRAM() const;
    HDD *GetHDD() const;
    DVD *GetDVD() const;
    Cooler *GetCooler() const;
    GraphicsCard *GetGraphicsCard() const;
    void Build();
    void SetProcessor(ProcessorEnum processorEnum);
    void SetRAM(RAMEnum ramEnum);
    void SetHDD(HDDEnum hddEnum);
    void SetDVD(DVDEnum dvdEnum);
    void SetCooler(CoolerEnum coolerEnum);
    void SetGraphicsCard(GraphicsCardEnum graphicsCardEnum);
    ~Director();
};