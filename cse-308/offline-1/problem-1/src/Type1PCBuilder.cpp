#include "Type1PCBuilder.h"

Type1PCBuilder::Type1PCBuilder()
{
    processor = new Intel11GenCore_i5();
    hdd = new HDD1TB();
    cooler = new CPUCooler();
}