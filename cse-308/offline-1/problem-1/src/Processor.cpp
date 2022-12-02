#include "Processor.h"

Processor::Processor()
{
    partType = "PROCESSOR";
}

std::string Processor::GetBrand() const
{
    return brand;
}