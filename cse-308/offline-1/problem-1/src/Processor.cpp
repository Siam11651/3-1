#include "Processor.h"

Processor::Processor()
{
    partType = "PROCESSOR";
}

std::string Processor::GetModel()
{
    return model;
}

std::string Processor::Print()
{
    return model;
}