#include "Type1PCBuilder.h"

void Type1PCBuilder::SetProcessor()
{
    parts.push_back(new Intel11GenCore_i5());
}

void Type1PCBuilder::SetCooler()
{
    parts.push_back(new CPUCooler());
}

void Type1PCBuilder::SetDVD()
{
    
}