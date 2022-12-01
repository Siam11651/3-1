#include "Type1PCBuilder.h"

Type1PCBuilder::Type1PCBuilder()
{
    maxProcessors = 1;
    maxRAMs = 4;
    maxHDDs = 3;
    maxDVDs = 1;
    maxCoolers = maxProcessors;
    maxGraphicsCards = 2;

    AddProcessor(Intel11GenCore_i5());
    AddHDD(HDD1TB());
    AddCooler(CPUCooler());
}