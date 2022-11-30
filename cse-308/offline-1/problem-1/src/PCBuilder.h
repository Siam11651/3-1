#pragma once

#include "PC.h"

class PCBuilder : public PC
{
protected:
    PC* pc;
public:
    PCBuilder();
    virtual int64_t SetProcessor(const Processor &processor);
    virtual int64_t SetRAM(const RAM &ram);
    virtual int64_t SetHDD(const HDD &hdd);
    virtual int64_t SetDVD(const DVD &dvd);
    virtual int64_t SetGraphicsCard(const GraphicsCard &graphicsCard);
    PC *GetBuiltPC();
    ~PCBuilder();
};