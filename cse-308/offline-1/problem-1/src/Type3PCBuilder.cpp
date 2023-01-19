#include "Type3PCBuilder.h"

void Type3PCBuilder::SetProcessor()
{
    parts.push_back(new Intel11GenCore_i9());
}

void Type3PCBuilder::SetCooler()
{

}

void Type3PCBuilder::SetDVD()
{
    parts.push_back(new DVD());
}