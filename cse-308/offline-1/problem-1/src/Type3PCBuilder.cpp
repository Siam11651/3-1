#include "Type3PCBuilder.h"

Type3PCBuilder::Type3PCBuilder()
{
    maxProcessors = 1;
    maxRAMs = 4;
    maxHDDs = 3;
    maxDVDs = 1;
    maxCoolers = maxProcessors;
    maxGraphicsCards = 2;

    AddProcessor(Intel11GenCore_i9());
    AddHDD(HDD1TB());
    AddDVD(DVD());
}