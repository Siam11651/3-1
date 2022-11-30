#pragma once

#include <vector>
#include <map>
#include "Processor.h"
#include "RAM.h"
#include "HDD.h"
#include "DVD.h"
#include "Cooler.h"
#include "GraphicsCard.h"

class PC
{
private:
    static const size_t MAX_PROCESSORS = 1;
    static const size_t MAX_RAMS = 4;
    static const size_t MAX_HDDS = 3;
    static const size_t MAX_DVDS = 1;
    static const size_t MAX_GPUS = 2;
    std::vector<Part *> parts;
    std::map<std::string, size_t> partTypeCount;
public:
    int64_t AddPart(const Part &part);
    ~PC();
};