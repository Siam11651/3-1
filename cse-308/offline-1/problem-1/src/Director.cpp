#include "Director.h"

Director::Director(PCBuilder *pcBuilder)
{
    this->pcBuilder = pcBuilder;
    processorEnum = ProcessorEnum::NONE;
    ramEnum = RAMEnum::NONE;
    hddEnum = HDDEnum::NONE;
    dvdEnum = DVDEnum::NONE;
    coolerEnum = CoolerEnum::NONE;
    graphicsCardEnum = GraphicsCardEnum::NONE;
    motherboardEnum = MotherboardEnum::NONE;
    cpuEnum = CPUEnum::NONE;
}

void Director::SetProcessor(ProcessorEnum processorEnum)
{
    this->processorEnum = processorEnum;
}

void Director::SetRAM(RAMEnum ramEnum)
{
    this->ramEnum = ramEnum;
}

void Director::SetHDD(HDDEnum hddEnum)
{
    this->hddEnum = hddEnum;
}

void Director::SetDVD(DVDEnum dvdEnum)
{
    this->dvdEnum = dvdEnum;
}

void Director::SetCooler(CoolerEnum coolerEnum)
{
    this->coolerEnum = coolerEnum;
}

void Director::SetGraphicsCard(GraphicsCardEnum graphicsCradEnum)
{
    this->graphicsCardEnum = graphicsCardEnum;
}

void Director::SetMotherMoard(MotherboardEnum motherboardEnum)
{
    this->motherboardEnum = motherboardEnum;
}

void Director::SetCPU(CPUEnum cpuEnum)
{
    this->cpuEnum = cpuEnum;
}

void Director::Build()
{
    pcBuilder->SetCPU(cpuEnum);
    pcBuilder->SetMotherboard(motherboardEnum);
    pcBuilder->SetProcessor(processorEnum);
    pcBuilder->SetRAM(ramEnum);
    pcBuilder->SetHDD(hddEnum);
    pcBuilder->SetDVD(dvdEnum);
    pcBuilder->SetCooler(coolerEnum);
    pcBuilder->SetGraphicsCard(graphicsCardEnum);
}

Director::~Director()
{
    delete pcBuilder;
}