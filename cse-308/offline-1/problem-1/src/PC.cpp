#include "PC.h"

PC::PC()
{
    basePrice = 70000;
}

PC::PC(const PCBuilder &pcBuilder)
{
    basePrice = 70000;

    parts = pcBuilder.GetParts();
}

std::vector<Part *> PC::GetParts() const
{
    return parts;
}

Processor *PC::GetProcessor() const
{
    for(size_t i = 0; i < parts.size(); ++i)
    {
        if(parts[i]->GetPartType() == "PROCESSOR")
        {
            return (Processor *)parts[i];
        }
    }

    return NULL;
}

RAM *PC::GetRAM() const
{
    for(size_t i = 0; i < parts.size(); ++i)
    {
        if(parts[i]->GetPartType() == "RAM")
        {
            return (RAM *)parts[i];
        }
    }

    return NULL;
}

HDD *PC::GetHDD() const
{
    for(size_t i = 0; i < parts.size(); ++i)
    {
        if(parts[i]->GetPartType() == "HDD")
        {
            return (HDD *)parts[i];
        }
    }

    return NULL;
}

DVD *PC::GetDVD() const
{
    for(size_t i = 0; i < parts.size(); ++i)
    {
        if(parts[i]->GetPartType() == "DVD")
        {
            return (DVD *)parts[i];
        }
    }

    return NULL;
}

Cooler *PC::GetCooler() const
{
    for(size_t i = 0; i < parts.size(); ++i)
    {
        if(parts[i]->GetPartType() == "COOLER")
        {
            return (Cooler *)parts[i];
        }
    }

    return NULL;
}

GraphicsCard *PC::GetGraphicsCard() const
{
    for(size_t i = 0; i < parts.size(); ++i)
    {
        if(parts[i]->GetPartType() == "GRAPHICS_CARD")
        {
            return (GraphicsCard *)parts[i];
        }
    }

    return NULL;
}

Motherboard *PC::GetMotherBoard() const
{
    for(size_t i = 0; i < parts.size(); ++i)
    {
        if(parts[i]->GetPartType() == "MOTHERBOARD")
        {
            return (Motherboard *)parts[i];
        }
    }

    return NULL;
}

CPU *PC::GetCPU() const
{
    for(size_t i = 0; i < parts.size(); ++i)
    {
        if(parts[i]->GetPartType() == "CPU")
        {
            return (CPU *)parts[i];
        }
    }

    return NULL;
}

uint64_t PC::GetBasePrice() const
{
    return basePrice;
}

uint64_t PC::GetTotalPrice() const
{
    uint64_t totalPrice = basePrice;

    for(size_t i = 0; i < parts.size(); ++i)
    {
        totalPrice += parts[i]->GetPrice();
    }

    return totalPrice;
}

PC::~PC()
{
    for(size_t i = 0; i < parts.size(); ++i)
    {
        delete parts[i];
    }
}