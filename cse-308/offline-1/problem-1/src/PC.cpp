#include "PC.h"

PC::PC(PCBuilder *pcBuilder)
{
    maxProcessors = pcBuilder->GetMaxProcessorsCount();
    maxRAMs = pcBuilder->GetMaxRAMsCount();
    maxHDDs = pcBuilder->GetMaxHDDsCount();
    maxDVDs = pcBuilder->GetMaxDVDsCount();
    maxCoolers = pcBuilder->GetMaxCoolersCount();
    maxGraphicsCards = pcBuilder->GetMaxGraphicsCardsCount();
    parts = pcBuilder->GetParts();
    partTypeCount = pcBuilder->GetPartTypeCount();
}