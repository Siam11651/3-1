#include "Type2PCBuilder.h"

Type2PCBuilder::Type2PCBuilder()
{
    maxProcessors = 1;
    maxRAMs = 4;
    maxHDDs = 3;
    maxDVDs = 1;
    maxCoolers = maxProcessors;
    maxGraphicsCards = 2;

    AddProcessor(Intel11GenCore_i7());
    AddHDD(HDD1TB());
    AddCooler(LiquidCooler());
}