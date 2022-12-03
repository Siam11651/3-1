#pragma once

#include <sstream>
#include <string>
#include "Processor.h"

class AMD : public Processor
{
protected:
    uint64_t series;
public:
    std::string Print();
};