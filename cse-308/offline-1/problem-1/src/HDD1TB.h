#pragma once

#include "HDD.h"

class HDD1TB : public HDD
{
protected:
    uint64_t volume;
public:
    HDD1TB();
};