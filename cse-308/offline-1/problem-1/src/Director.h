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
    MotherboardEnum motherboardEnum;
    CPUEnum cpuEnum;
public:
    Director(const PCBuilder &pcBuilder);
    void Build();
    void SetProcessor(ProcessorEnum processorEnum);
    void SetRAM(RAMEnum ramEnum);
    void SetHDD(HDDEnum hddEnum);
    void SetDVD(DVDEnum dvdEnum);
    void SetCooler(CoolerEnum coolerEnum);
    void SetGraphicsCard(GraphicsCardEnum graphicsCardEnum);
    void SetMotherMoard(MotherboardEnum motherboardEnum);
    void SetCPU(CPUEnum cpuEnum);
    ~Director();
};