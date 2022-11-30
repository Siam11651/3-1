#pragma once

#include "Part.h"

class Processor : public Part
{
protected:
    std::string model;
public:
    Processor();
    std::string GetModel();
    std::string Print();
};