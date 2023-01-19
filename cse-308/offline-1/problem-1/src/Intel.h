#pragma once

#include <sstream>
#include <string>
#include "Processor.h"

class Intel : public Processor
{
protected:
    uint64_t generation;
public:
    std::string Print();
};