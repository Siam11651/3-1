#include "Type1PCBuilder.h"

Type1PCBuilder::Type1PCBuilder()
{
    Type1Setup();
}

void Type1PCBuilder::Type1Setup()
{
    pc->AddPart(AMD_Ryzen7_5700X());
    pc->AddPart(HDD1TB());
    pc->AddPart(CPUCooler());
}

PC *Type1PCBuilder::GetBuiltPC()
{
    PC *toReturn = pc;
    pc = new PC();

    Type1Setup();

    return toReturn;
}