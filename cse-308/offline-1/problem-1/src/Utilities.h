#pragma once

#include <string>

#include "Part.h"
#include "PC.h"
#include "PCBuilder.h"
#include "GamingPCBuilder.h"
#include "Type1PCBuilder.h"
#include "Type2PCBuilder.h"
#include "Type3PCBuilder.h"

// processors
#include "Processor.h"
#include "AMD_Ryzen7_5700X.h"
#include "Intel11GenCore_i5.h"
#include "Intel11GenCore_i7.h"
#include "Intel11GenCore_i9.h"
// end processors

// rams
#include "RAM.h"
#include "RAM8GB2666MHzDDR4.h"
#include "RAM8GB3200MHzDDR4.h"
// end rams

// hdds
#include "HDD.h"
#include "HDD1TB.h"
// end hdds

// dvd
#include "DVD.h"
// end dvd

// coolers
#include "Cooler.h"
#include "CPUCooler.h"
#include "LiquidCooler.h"
// end coolers

// gpus cards
#include "GraphicsCard.h"
#include "GraphicsCard2GB.h"
#include "GraphicsCard4GB.h"
// end gpus

namespace Utilities
{
    std::string ToLower(const std::string &string);
} // namespace Utilities
