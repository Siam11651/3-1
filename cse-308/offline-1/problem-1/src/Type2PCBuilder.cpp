#include "Type2PCBuilder.h"

void Type2PCBuilder::SetProcessor()
{
    parts.push_back(new Intel11GenCore_i7());
}

void Type2PCBuilder::SetCooler()
{
    parts.push_back(new LiquidCooler());
}

void Type2PCBuilder::SetDVD()
{
    
}