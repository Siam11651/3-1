#pragma once

#include "PCBuilder.h"
#include "Intel11GenCore_i9.h"
#include "DVD.h"

class Type3PCBuilder : public PCBuilder
{
public:
    void SetProcessor();
    void SetCooler();
    void SetDVD();
};