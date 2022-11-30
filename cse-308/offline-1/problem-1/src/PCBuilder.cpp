#include "PCBuilder.h"

PCBuilder::PCBuilder()
{
    pc = new PC();
}

int64_t PCBuilder::AddProcessor(const Processor &processor)
{
    return pc->AddPart(processor);
}

int64_t PCBuilder::AddRAM(const RAM &ram)
{
    return pc->AddPart(ram);
}

int64_t PCBuilder::AddHDD(const HDD &hdd)
{
    return pc->AddPart(hdd);
}

int64_t PCBuilder::AddDVD(const DVD &dvd)
{
    return pc->AddPart(dvd);
}

int64_t PCBuilder::AddGraphicsCard(const GraphicsCard &graphicsCard)
{
    return pc->AddPart(graphicsCard);
}

PC *PCBuilder::GetBuiltPC()
{
    PC *toReturn = pc;
    pc = new PC();

    return toReturn;
}