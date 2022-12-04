#include "PCBuilder.h"

void PCBuilder::SetRAM(RAMEnum ramEnum)
{
    if(ramEnum == RAMEnum::RAM8GB2666MHZ_DDR4)
    {
        parts.push_back(new RAM8GB2666MHzDDR4());
    }
    else if(ramEnum == RAMEnum::RAM8GB3200MHZ_DDR4)
    {
        parts.push_back(new RAM8GB3200MHzDDR4());
    }
}

void PCBuilder::SetHDD()
{
    parts.push_back(new HDD1TB());
}

void PCBuilder::SetGraphicsCard(GraphicsCardEnum graphicsCradEnum)
{
    if(graphicsCradEnum == GraphicsCardEnum::GRAPHICS_CARD_2GB)
    {
        parts.push_back(new GraphicsCard2GB());
    }
    else if(graphicsCradEnum == GraphicsCardEnum::GRAPHICS_CARD_4GB)
    {
        parts.push_back(new GraphicsCard4GB());
    }
}

void PCBuilder::SetMotherboard()
{
    parts.push_back(new Motherboard());
}

void PCBuilder::SetCPU()
{
    parts.push_back(new CPU());
}

PC *PCBuilder::GetBuiltPCPointer() const
{
    return new PC(*this);
}