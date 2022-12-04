#include "GamingPCBuilder.h"

GamingPCBuilder::GamingPCBuilder()
{
    processor = new AMD_Ryzen7_5700X();
    hdd = new HDD1TB();
    motherboard = new Motherboard();
    cpu = new CPU();
}