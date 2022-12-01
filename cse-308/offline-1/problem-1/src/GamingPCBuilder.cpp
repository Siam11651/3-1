#include "GamingPCBuilder.h"

GamingPCBuilder::GamingPCBuilder()
{
    maxProcessors = 1;
    maxRAMs = 4;
    maxHDDs = 3;
    maxDVDs = 1;
    maxCoolers = maxProcessors;
    maxGraphicsCards = 2;

    AddProcessor(AMD_Ryzen7_5700X());
    AddHDD(HDD1TB());
    AddCooler(CPUCooler());
}