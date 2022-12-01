#pragma once

#include <vector>
#include <map>
#include "PC.h"

class PCBuilder : public PC
{
protected:
    size_t maxProcessors;
    size_t maxRAMs;
    size_t maxHDDs;
    size_t maxDVDs;
    size_t maxCoolers;
    size_t maxGraphicsCards;
    uint64_t basePrice;
    std::vector<Part> parts;
    std::map<std::string, size_t> partTypeCount;
public:
    PCBuilder();
    void ResetBuild();
    virtual int64_t SetMaxProcessorsCount(const size_t &maxProcessors);
    virtual int64_t SetMaxRAMsCount(const size_t &maxRAMs);
    virtual int64_t SetMaxHDDsCount(const size_t &maxHDDs);
    virtual int64_t SetMaxDVDsCount(const size_t &maxDVDs);
    virtual int64_t SetMaxCoolersCount(const size_t &maxCoolers);
    virtual int64_t SetMaxGraphicsCardsCount(const size_t &maxGraphicsCards);
    virtual int64_t AddProcessor(const Processor &processor);
    virtual int64_t AddRAM(const RAM &ram);
    virtual int64_t AddHDD(const HDD &hdd);
    virtual int64_t AddDVD(const DVD &dvd);
    virtual int64_t AddCooler(const Cooler &cooler);
    virtual int64_t AddGraphicsCard(const GraphicsCard &graphicsCard);
    std::vector<Part> GetParts() const;
    std::map<std::string, size_t> GetPartTypeCount() const;
    size_t GetMaxProcessorsCount() const;
    size_t GetMaxRAMsCount() const;
    size_t GetMaxHDDsCount() const;
    size_t GetMaxDVDsCount() const;
    size_t GetMaxCoolersCount() const;
    size_t GetMaxGraphicsCardsCount() const;
    PC *GetBuiltPCPointer();
};