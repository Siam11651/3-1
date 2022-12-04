#pragma once

#include "PCBuilder.h"
#include "Intel11GenCore_i5.h"
#include "CPUCooler.h"

class Type1PCBuilder : public PCBuilder
{
public:
    void SetProcessor();
    void SetCooler();
    void SetDVD();
};