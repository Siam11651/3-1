#include "Type2PCBuilder.h"

Type2PCBuilder::Type2PCBuilder()
{
    processor = new Intel11GenCore_i7();
    hdd = new HDD1TB();
    cooler = new LiquidCooler();
}