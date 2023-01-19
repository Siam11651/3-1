#pragma once

#include "PCBuilder.h"
#include "Intel11GenCore_i7.h"
#include "LiquidCooler.h"

class Type2PCBuilder : public PCBuilder
{
public:
    void SetProcessor();
    void SetCooler();
    void SetDVD();
};