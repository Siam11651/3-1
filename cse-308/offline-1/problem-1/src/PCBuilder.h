#pragma once

#include "PC.h"

class PCBuilder : public PC
{
protected:
    PC* pc;
public:
    PCBuilder();
    virtual int64_t AddProcessor(const Processor &processor);
    virtual int64_t AddRAM(const RAM &ram);
    virtual int64_t AddHDD(const HDD &hdd);
    virtual int64_t AddDVD(const DVD &dvd);
    virtual int64_t AddGraphicsCard(const GraphicsCard &graphicsCard);
    PC *GetBuiltPC();
};