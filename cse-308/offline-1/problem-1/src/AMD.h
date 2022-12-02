#pragma once

#include <iostream>
#include "Processor.h"

class AMD : public Processor
{
protected:
    uint64_t series;
public:
    std::string Print();
};