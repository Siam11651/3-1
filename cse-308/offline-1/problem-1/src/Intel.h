#pragma once

#include <iostream>
#include "Processor.h"

class Intel : public Processor
{
protected:
    uint64_t generation;
public:
    std::string Print();
};