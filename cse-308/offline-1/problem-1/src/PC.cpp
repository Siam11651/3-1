#include "PC.h"

PC::PC()
{
    processor = NULL;
    ram = NULL;
    hdd = NULL;
    dvd = NULL;
    cooler = NULL;
    graphicsCard = NULL;
    motherboard = NULL;
    cpu = NULL;
}

PC::PC(const PCBuilder &pcBuilder)
{
    processor = pcBuilder.GetProcessor();
    ram = pcBuilder.GetRAM();
    hdd = pcBuilder.GetHDD();
    dvd = pcBuilder.GetDVD();
    cooler = pcBuilder.GetCooler();
    graphicsCard = pcBuilder.GetGraphicsCard();
    motherboard = pcBuilder.GetMotherboard();
    cpu = pcBuilder.GetCPU();
}

PC::~PC()
{
    delete processor;
    delete ram;
    delete hdd;
    delete dvd;
    delete cooler;
    delete graphicsCard;
    delete motherboard;
    delete cpu;
}