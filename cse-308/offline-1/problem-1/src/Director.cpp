#include "Director.h"

Director::Director(PCBuilder *pcBuilder)
{
    this->pcBuilder = pcBuilder;
    ramEnum = RAMEnum::NONE;
    graphicsCardEnum = GraphicsCardEnum::NONE;
}

void Director::SetRAM(RAMEnum ramEnum)
{
    this->ramEnum = ramEnum;
}

void Director::SetGraphicsCard(GraphicsCardEnum graphicsCradEnum)
{
    this->graphicsCardEnum = graphicsCardEnum;
}

void Director::Build()
{
    pcBuilder->SetCPU();
    pcBuilder->SetMotherboard();
    pcBuilder->SetProcessor();
    pcBuilder->SetCooler();
    pcBuilder->SetRAM(ramEnum);
    pcBuilder->SetHDD();
    pcBuilder->SetDVD();
    pcBuilder->SetGraphicsCard(graphicsCardEnum);
}