#include "PCBuilder.h"

PCBuilder::PCBuilder()
{
    processor = NULL;
    ram = NULL;
    hdd = NULL;
    dvd = NULL;
    cooler = NULL;
    graphicsCard = NULL;
}

Processor *PCBuilder::GetProcessor() const
{
    return processor;
}

RAM *PCBuilder::GetRAM() const
{
    return ram;
}

HDD *PCBuilder::GetHDD() const
{
    return hdd;
}

DVD *PCBuilder::GetDVD() const
{
    return dvd;
}

Cooler *PCBuilder::GetCooler() const
{
    return cooler;
}

GraphicsCard *PCBuilder::GetGraphicsCard() const
{
    return graphicsCard;
}

void PCBuilder::SetProcessor(ProcessorEnum processorEnum)
{
    delete processor;

    if(processorEnum == ProcessorEnum::AMD_RYZEN7_5700X)
    {
        processor = new AMD_Ryzen7_5700X();
    }
    else if(processorEnum == ProcessorEnum::INTEL11GEN_CORE_I5)
    {
        processor = new Intel11GenCore_i5();
    }
    else if(processorEnum == ProcessorEnum::INTEL11GEN_CORE_I7)
    {
        processor = new Intel11GenCore_i7();
    }
    else if(processorEnum == ProcessorEnum::INTEL11GEN_CORE_I9)
    {
        processor = new Intel11GenCore_i9();
    }
}

void PCBuilder::SetRAM(RAMEnum ramEnum)
{
    delete ram;

    if(ramEnum == RAMEnum::RAM8GB2666MHZ_DDR4)
    {
        ram = new RAM8GB2666MHzDDR4();
    }
    else if(ramEnum == RAMEnum::RAM8GB3200MHZ_DDR4)
    {
        ram = new RAM8GB3200MHzDDR4();
    }
}

void PCBuilder::SetHDD(HDDEnum hddEnum)
{
    delete hdd;

    if(hddEnum == HDDEnum::HDD1TB)
    {
        hdd = new HDD1TB();
    }
}

void PCBuilder::SetDVD(DVDEnum dvdEnum)
{
    delete dvd;

    if(dvdEnum == DVDEnum::DVD)
    {
        dvd = new DVD();
    }
}

void PCBuilder::SetCooler(CoolerEnum coolerEnum)
{
    delete cooler;

    if(coolerEnum == CoolerEnum::CPU_COOLER)
    {
        cooler = new CPUCooler();
    }
    else if(coolerEnum == CoolerEnum::LIQUID_COOLER)
    {
        cooler = new LiquidCooler();
    }
}

void PCBuilder::SetGraphicsCard(GraphicsCardEnum graphicsCradEnum)
{
    delete graphicsCard;

    if(graphicsCradEnum == GraphicsCardEnum::GRAPHICS_CARD_2GB)
    {
        graphicsCard = new GraphicsCard2GB();
    }
    else if(graphicsCradEnum == GraphicsCardEnum::GRAPHICS_CARD_4GB)
    {
        graphicsCard = new GraphicsCard4GB();
    }
}

void PCBuilder::RemoveProcessor()
{
    delete processor;

    processor = NULL;
}

void PCBuilder::RemoveRAM()
{
    delete ram;

    ram = NULL;
}

void PCBuilder::RemoveHDD()
{
    delete hdd;

    hdd = NULL;
}

void PCBuilder::RemoveDVD()
{
    delete dvd;

    dvd = NULL;
}

void PCBuilder::RemoveCooler()
{
    delete cooler;

    cooler = NULL;
}

void PCBuilder::RemoveGraphicsCard()
{
    delete graphicsCard;

    graphicsCard = NULL;
}