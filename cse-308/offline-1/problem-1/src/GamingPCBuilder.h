#pragma once

#include "PCBuilder.h"
#include "AMD_Ryzen7_5700X.h"

class GamingPCBuilder : public PCBuilder
{
public:
    void SetProcessor();
    void SetCooler();
    void SetDVD();
};