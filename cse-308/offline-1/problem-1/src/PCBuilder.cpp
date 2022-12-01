#include "PCBuilder.h"

PCBuilder::PCBuilder()
{
    maxProcessors = 0;
    maxRAMs = 0;
    maxHDDs = 0;
    maxDVDs = 0;
    maxCoolers = 0;
    maxGraphicsCards = 0;
    basePrice = 70000;
}

int64_t PCBuilder::SetMaxProcessorsCount(const size_t &maxProcessors)
{
    int64_t toReturn = 0;

    if(this->maxProcessors > 0)
    {
        toReturn = 1; // had to reset build

        ResetBuild();
    }

    this->maxProcessors = maxProcessors;

    return toReturn;
}

int64_t PCBuilder::SetMaxRAMsCount(const size_t &maxRAMs)
{
    int64_t toReturn = 0;

    if(this->maxRAMs > 0)
    {
        toReturn = 1; // had to reset build

        ResetBuild();
    }

    this->maxRAMs = maxRAMs;

    return toReturn;
}

int64_t PCBuilder::SetMaxHDDsCount(const size_t &maxHDDs)
{
    int64_t toReturn = 0;

    if(this->maxHDDs > 0)
    {
        toReturn = 1; // had to reset build

        ResetBuild();
    }

    this->maxHDDs = maxHDDs;

    return toReturn;
}

int64_t PCBuilder::SetMaxDVDsCount(const size_t &maxDVDs)
{
    int64_t toReturn = 0;

    if(this->maxDVDs > 0)
    {
        toReturn = 1; // had to reset build

        ResetBuild();
    }

    this->maxDVDs = maxDVDs;

    return toReturn;
}

int64_t PCBuilder::SetMaxCoolersCount(const size_t &maxCoolers)
{
    int64_t toReturn = 0;

    if(this->maxCoolers > 0)
    {
        toReturn = 1; // had to reset build

        ResetBuild();
    }

    this->maxCoolers = maxCoolers;

    return toReturn;
}

int64_t PCBuilder::SetMaxGraphicsCardsCount(const size_t &maxGraphicsCards)
{
    int64_t toReturn = 0;

    if(this->maxGraphicsCards > 0)
    {
        toReturn = 1; // had to reset build

        ResetBuild();
    }

    this->maxGraphicsCards = maxGraphicsCards;

    return toReturn;
}

int64_t PCBuilder::AddProcessor(const Processor &processor)
{
    if(partTypeCount["PROCESSOR"] < maxProcessors)
    {
        parts.push_back(processor);

        ++partTypeCount["PROCESSOR"];

        return 0; // success
    }
    else
    {
        return 1; // max limit of processors reached
    }
}

int64_t PCBuilder::AddRAM(const RAM &ram)
{
    if(partTypeCount["RAM"] < maxRAMs)
    {
        parts.push_back(ram);

        ++partTypeCount["RAM"];
    }
    else
    {
        return 1; // max limit of rams reached
    }
}

int64_t PCBuilder::AddHDD(const HDD &hdd)
{
    if(partTypeCount["HDD"] < maxHDDs)
    {
        parts.push_back(hdd);

        ++partTypeCount["HDD"];
    }
    else
    {
        return 1; // max limit of hdds reached
    }
}

int64_t PCBuilder::AddDVD(const DVD &dvd)
{
    if(partTypeCount["DVD"] < maxDVDs)
    {
        parts.push_back(dvd);

        ++partTypeCount["DVD"];
    }
    else
    {
        return 1; // max limit of dvds reached
    }
}

int64_t PCBuilder::AddCooler(const Cooler &cooler)
{
    if(partTypeCount["COOLER"] < maxCoolers)
    {
        parts.push_back(cooler);

        ++partTypeCount["COOLER"];
    }
    else
    {
        return 1; // max limit of coolers reached
    }
}

int64_t PCBuilder::AddGraphicsCard(const GraphicsCard &graphicsCard)
{
    if(partTypeCount["GRAPHICS_CARD"] < maxGraphicsCards)
    {
        parts.push_back(graphicsCard);

        ++partTypeCount["GRAPHICS_CARD"];
    }
    else
    {
        return 1; // max limit of gpus reached
    }
}

std::vector<Part> PCBuilder::GetParts() const
{
    return parts;
}

std::map<std::string, size_t> PCBuilder::GetPartTypeCount() const
{
    return partTypeCount;
}

void PCBuilder::ResetBuild()
{
    parts.clear();
    partTypeCount.clear();
}

size_t PCBuilder::GetMaxProcessorsCount() const
{
    return maxProcessors;
}

size_t PCBuilder::GetMaxRAMsCount() const
{
    return maxRAMs;
}

size_t PCBuilder::GetMaxDVDsCount() const
{
    return maxDVDs;
}

size_t PCBuilder::GetMaxCoolersCount() const
{
    return maxCoolers;
}

size_t PCBuilder::GetMaxGraphicsCardsCount() const
{
    return maxGraphicsCards;
}

PC *PCBuilder::GetBuiltPCPointer()
{
    pc = new PC(this);

    return pc;
}