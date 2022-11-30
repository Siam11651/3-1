#pragma once

#include "PCBuilder.h"
#include "AMD_Ryzen7_5700X.h"
#include "HDD1TB.h"
#include "CPUCooler.h"

class Type1PCBuilder : public PCBuilder
{
protected:
    void Type1Setup();
public:
    Type1PCBuilder();
    PC *GetBuiltPC();
};

typedef Type1PCBuilder GamingPCBuilder;