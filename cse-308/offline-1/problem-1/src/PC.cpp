#include "PC.h"

PC::PC()
{
    processor = NULL;
    ram = NULL;
    hdd = NULL;
    dvd = NULL;
    cooler = NULL;
    graphicsCard = NULL;
}

PC::PC(PCBuilder *pcBuilder)
{
    processor = pcBuilder->GetProcessor();
    ram = pcBuilder->GetRAM();
    hdd = pcBuilder->GetHDD();
    dvd = pcBuilder->GetDVD();
    cooler = pcBuilder->GetCooler();
    graphicsCard = pcBuilder->GetGraphicsCard();
}

PC::~PC()
{
    delete processor;
    delete ram;
    delete hdd;
    delete dvd;
    delete cooler;
    delete graphicsCard;
}