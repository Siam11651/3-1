#include "PC.h"

PC::PC(PCBuilder *pcBuilder)
{
    parts = pcBuilder->GetParts();
}