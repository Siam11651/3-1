#include "Utilities.h"

// ram
RAM8GB2666MHzDDR4 SAMPLE_RAM8GB2666MHZ_DDR4;
RAM8GB3200MHzDDR4 SAMPLE_RAM8GB3200MHZ_DDR4;
// end ram

// gpu
GraphicsCard2GB SAMPLE_GRAPHICS_CARD_2GB;
GraphicsCard4GB SAMPLE_GRAPHICS_CARD_4GB;
// end gpu

std::string ShowPrice(uint64_t price)
{
    if(price == 0)
    {
        return "Base";
    }
    else
    {
        std::stringstream sStream("");

        sStream >> price;

        return sStream.str();
    }
}

/*
void SetProcessor(Director &director)
{
    while(true)
    {
        std::cout << "Choose processor:" << std::endl;
        std::cout << "[1] " << SAMPLE_AMD_RYZEN7_5700X.Print() << "; Price: " << ShowPrice(SAMPLE_AMD_RYZEN7_5700X.GetPrice()) << std::endl;
        std::cout << "[2] " << SAMPLE_INTEL11GEN_CORE_I5.Print() << "; Price: " << ShowPrice(SAMPLE_INTEL11GEN_CORE_I5.GetPrice()) << std::endl;
        std::cout << "[3] " << SAMPLE_INTEL11GEN_CORE_I7.Print() << "; Price: " << ShowPrice(SAMPLE_INTEL11GEN_CORE_I7.GetPrice()) << std::endl;
        std::cout << "[4] " << SAMPLE_INTEL11GEN_CORE_I9.Print() << "; Price: " << ShowPrice(SAMPLE_INTEL11GEN_CORE_I9.GetPrice()) << std::endl;
        std::cout << "[0] Remove set" << std::endl;

        std::string line = Utilities::FormatNewLine();

        if(Utilities::IsInteger(line))
        {
            uint64_t item = Utilities::ParseItem(line);

            if(item == 0)
            {
                director.SetProcessor(ProcessorEnum::NONE);

                break;
            }
            else if(item == 1)
            {
                director.SetProcessor(ProcessorEnum::AMD_RYZEN7_5700X);

                break;
            }
            else if(item == 2)
            {
                director.SetProcessor(ProcessorEnum::INTEL11GEN_CORE_I5);

                break;
            }
            else if(item == 3)
            {
                director.SetProcessor(ProcessorEnum::INTEL11GEN_CORE_I7);

                break;
            }
            else if(item == 4)
            {
                director.SetProcessor(ProcessorEnum::INTEL11GEN_CORE_I9);

                break;
            }
            else
            {
                std::cout << INVALID_INPUT_MESSAGE << std::endl;
            }
        }
        else
        {
            std::cout << INVALID_INPUT_MESSAGE << std::endl;
        }
    }
}

void SetRAM(Director &director)
{
    while(true)
    {
        std::cout << "Choose RAM:" << std::endl;
        std::cout << "[1] " << SAMPLE_RAM8GB2666MHZ_DDR4.Print() << "; Price: " << ShowPrice(SAMPLE_RAM8GB2666MHZ_DDR4.GetPrice()) << std::endl;
        std::cout << "[2] " << SAMPLE_RAM8GB3200MHZ_DDR4.Print() << "; Price: " << ShowPrice(SAMPLE_RAM8GB3200MHZ_DDR4.GetPrice()) << std::endl;
        std::cout << "[0] Remove set" << std::endl;

        std::string line = Utilities::FormatNewLine();

        if(Utilities::IsInteger(line))
        {
            uint64_t item = Utilities::ParseItem(line);

            if(item == 0)
            {
                director.SetRAM(RAMEnum::NONE);

                break;
            }
            else if(item == 1)
            {
                director.SetRAM(RAMEnum::RAM8GB2666MHZ_DDR4);

                break;
            }
            else if(item == 2)
            {
                director.SetRAM(RAMEnum::RAM8GB3200MHZ_DDR4);

                break;
            }
            else
            {
                std::cout << INVALID_INPUT_MESSAGE << std::endl;
            }
        }
        else
        {
            std::cout << INVALID_INPUT_MESSAGE << std::endl;
        }
    }
}

void SetHDD(Director &director)
{
    while(true)
    {
        std::cout << "Choose HDD:" << std::endl;
        std::cout << "[1] " << SAMPLE_HDD1TB.Print() << "; Price: " << ShowPrice(SAMPLE_HDD1TB.GetPrice()) << std::endl;
        std::cout << "[0] Remove set" << std::endl;

        std::string line = Utilities::FormatNewLine();

        if(Utilities::IsInteger(line))
        {
            uint64_t item = Utilities::ParseItem(line);

            if(item == 0)
            {
                director.SetHDD(HDDEnum::NONE);

                break;
            }
            else if(item == 1)
            {
                director.SetHDD(HDDEnum::HDD1TB);

                break;
            }
            else
            {
                std::cout << INVALID_INPUT_MESSAGE << std::endl;
            }
        }
        else
        {
            std::cout << INVALID_INPUT_MESSAGE << std::endl;
        }
    }
}

void SetCooler(Director &director)
{
    while(true)
    {
        std::cout << "Choose cooler:" << std::endl;
        std::cout << "[1] " << SAMPLE_CPU_COOLER.Print() << "; Price: " << ShowPrice(SAMPLE_CPU_COOLER.GetPrice()) << std::endl;
        std::cout << "[2] " << SAMPLE_LIQUID_COOLER.Print() << "; Price: " << ShowPrice(SAMPLE_LIQUID_COOLER.GetPrice()) << std::endl;
        std::cout << "[0] Remove set" << std::endl;

        std::string line = Utilities::FormatNewLine();

        if(Utilities::IsInteger(line))
        {
            uint64_t item = Utilities::ParseItem(line);

            if(item == 0)
            {
                director.SetCooler(CoolerEnum::CPU_COOLER);

                break;
            }
            else if(item == 1)
            {
                director.SetCooler(CoolerEnum::LIQUID_COOLER);

                break;
            }
            else
            {
                std::cout << INVALID_INPUT_MESSAGE << std::endl;
            }
        }
        else
        {
            std::cout << INVALID_INPUT_MESSAGE << std::endl;
        }
    }
}

void SetGraphicsCard(Director &director)
{
    while(true)
    {
        std::cout << "Choose graphics card:" << std::endl;
        std::cout << "[1] " << SAMPLE_GRAPHICS_CARD_2GB.Print() << "; Price: " << ShowPrice(SAMPLE_GRAPHICS_CARD_2GB.GetPrice()) << std::endl;
        std::cout << "[2] " << SAMPLE_GRAPHICS_CARD_4GB.Print() << "; Price: " << ShowPrice(SAMPLE_GRAPHICS_CARD_4GB.GetPrice()) << std::endl;
        std::cout << "[0] Remove set" << std::endl;
    }
}

void SetPart(Director &director)
{
    while(true)
    {
        std::cout << "Choose part:" << std::endl;
        std::cout << "[1] Processor" << std::endl;
        std::cout << "[2] RAM" << std::endl;
        std::cout << "[3] HDD" << std::endl;
        std::cout << "[4] DVD" << std::endl;
        std::cout << "[5] Cooler" << std::endl;
        std::cout << "[6] Cooler" << std::endl;
        std::cout << "[7] Motherboard" << std::endl;
        std::cout << "[8] CPU" << std::endl;
        std::cout << "[0] Go back" << std::endl;

        std::string line = Utilities::FormatNewLine();

        if(Utilities::IsInteger(line))
        {
            uint64_t item = Utilities::ParseItem(line);

            if(item == 0)
            {
                break;
            }
            else if(item == 1)
            {
                SetProcessor(director);

                break;
            }
            else if(item == 2)
            {
                SetRAM(director);

                break;
            }
            else if(item == 3)
            {
                SetHDD(director);

                break;
            }
            else if(item == 4)
            {
                while(true)
                {
                    std::cout << "Add dvd? Price: " << ShowPrice(SAMPLE_DVD.GetPrice()) << std::endl;
                    std::cout << "[y] Yes" << std::endl;
                    std::cout << "[n] No" << std::endl;

                    std::string line = Utilities::FormatNewLine();

                    if(line == "y")
                    {
                        director.SetDVD(DVDEnum::DVD);
                    }
                    else if(line == "n")
                    {
                        director.SetDVD(DVDEnum::DVD);
                    }
                    else
                    {
                        std::cout << INVALID_INPUT_MESSAGE << std::endl;
                    }
                }

                break;
            }
            else if(item == 5)
            {
                SetCooler(director);

                break;
            }
            else if(item == 6)
            {
                SetGraphicsCard(director);

                break;
            }
            else if(item == 7)
            {
                while(true)
                {
                    std::cout << "Add motherboard? Price: " << ShowPrice(SAMPLE_MOTHERBOARD.GetPrice()) << std::endl;
                    std::cout << "[y] Yes" << std::endl;
                    std::cout << "[n] No" << std::endl;

                    std::string line = Utilities::FormatNewLine();

                    if(line == "y")
                    {
                        director.SetMotherMoard(MotherboardEnum::MOTHERBOARD);
                    }
                    else if(line == "n")
                    {
                        director.SetMotherMoard(MotherboardEnum::NONE);
                    }
                    else
                    {
                        std::cout << INVALID_INPUT_MESSAGE << std::endl;
                    }
                }

                break;
            }
            else if(item == 8)
            {
                while(true)
                {
                    std::cout << "Add CPU? Price: " << ShowPrice(SAMPLE_CPU.GetPrice()) << std::endl;
                    std::cout << "[y] Yes" << std::endl;
                    std::cout << "[n] No" << std::endl;

                    std::string line = Utilities::FormatNewLine();

                    if(line == "y")
                    {
                        director.SetCPU(CPUEnum::CPU);
                    }
                    else if(line == "n")
                    {
                        director.SetCPU(CPUEnum::NONE);
                    }
                    else
                    {
                        std::cout << INVALID_INPUT_MESSAGE << std::endl;
                    }
                }

                break;
            }
            else
            {
                std::cout << INVALID_INPUT_MESSAGE << std::endl;
            }
        }
        else
        {
            std::cout << INVALID_INPUT_MESSAGE << std::endl;
        }
    }
}
*/

void DirectBuild(Director &director)
{
    while(true)
    {
        std::cout << "Set RAM:" << std::endl;
        std::cout << "[1] " << SAMPLE_RAM8GB2666MHZ_DDR4.Print() << "; Price: " << ShowPrice(SAMPLE_RAM8GB2666MHZ_DDR4.GetPrice()) << std::endl;
        std::cout << "[2] " << SAMPLE_RAM8GB3200MHZ_DDR4.Print() << "; Price: " << ShowPrice(SAMPLE_RAM8GB3200MHZ_DDR4.GetPrice()) << std::endl;
        std::cout << "[0] Do not add" << std::endl;

        std::string line;

        if(Utilities::IsInteger(line))
        {
            uint64_t item = Utilities::ParseItem(line);

            if(item == 0)
            {
                director.SetRAM(RAMEnum::NONE);

                break;
            }
            else if(item == 1)
            {
                director.SetRAM(RAMEnum::RAM8GB2666MHZ_DDR4);

                break;
            }
            else if(item == 2)
            {
                director.SetRAM(RAMEnum::RAM8GB3200MHZ_DDR4);

                break;
            }
            else
            {
                std::cout << INVALID_INPUT_MESSAGE << std::endl;
            }
        }
        else
        {
            std::cout << INVALID_INPUT_MESSAGE << std::endl;
        }
    }

    while(true)
    {
        std::cout << "Set Graphics Card:" << std::endl;
        std::cout << "[1] " << SAMPLE_GRAPHICS_CARD_2GB.Print() << "; Price: " << ShowPrice(SAMPLE_GRAPHICS_CARD_2GB.GetPrice()) << std::endl;
        std::cout << "[2] " << SAMPLE_GRAPHICS_CARD_4GB.Print() << "; Price: " << ShowPrice(SAMPLE_GRAPHICS_CARD_4GB.GetPrice()) << std::endl;
        std::cout << "[0] Do not add" << std::endl;

        std::string line;

        if(Utilities::IsInteger(line))
        {
            uint64_t item = Utilities::ParseItem(line);

            if(item == 0)
            {
                director.SetGraphicsCard(GraphicsCardEnum::NONE);

                break;
            }
            else if(item == 1)
            {
                director.SetGraphicsCard(GraphicsCardEnum::GRAPHICS_CARD_2GB);

                break;
            }
            else if(item == 2)
            {
                director.SetGraphicsCard(GraphicsCardEnum::GRAPHICS_CARD_4GB);

                break;
            }
            else
            {
                std::cout << INVALID_INPUT_MESSAGE << std::endl;
            }
        }
        else
        {
            std::cout << INVALID_INPUT_MESSAGE << std::endl;
        }
    }
}

int main()
{
    while(true)
    {
        std::string line = Utilities::FormatNewLine();

        if(line == "o")
        {
            std::vector<PC *> pcs;

            while(true)
            {
                std::cout << "Choose build type:" << std::endl;
                std::cout << "[1] Gaming Build" << std::endl;
                std::cout << "[2] Type 1 Build" << std::endl;
                std::cout << "[3] Type 2 Build" << std::endl;
                std::cout << "[4] Type 3 Build" << std::endl;
                std::cout << "[e] Close order" << std::endl;

                std::string line = Utilities::FormatNewLine();
                PCBuilder *pcBuilder = NULL;
                Director *director = NULL;

                if(line == "1")
                {
                    pcBuilder = new GamingPCBuilder();
                    director = new Director(pcBuilder);

                    DirectBuild(*director);
                    pcs.push_back(pcBuilder->GetBuiltPCPointer());
                }
                else if(line == "2")
                {
                    pcBuilder = new Type1PCBuilder();
                    director = new Director(pcBuilder);

                    DirectBuild(*director);
                    pcs.push_back(pcBuilder->GetBuiltPCPointer());
                }
                else if(line == "3")
                {
                    pcBuilder = new Type2PCBuilder();
                    director = new Director(pcBuilder);

                    DirectBuild(*director);
                    pcs.push_back(pcBuilder->GetBuiltPCPointer());
                }
                else if(line == "4")
                {
                    pcBuilder = new Type3PCBuilder();
                    director = new Director(pcBuilder);

                    DirectBuild(*director);
                    pcs.push_back(pcBuilder->GetBuiltPCPointer());
                }
                else if(line == "e")
                {
                    if(pcs.size() > 0)
                    {
                        for(size_t i = 0; i < pcs.size(); ++i)
                        {
                            std::cout << "PC " << i + 1 << ':' << std::endl;
                            std::cout << "Processor: " << pcs[i]->GetProcessor()->Print() << std::endl;
                            std::cout << "\tPrice: " << ShowPrice(pcs[i]->GetProcessor()->GetPrice()) << std::endl;

                            if(pcs[i]->GetRAM() != NULL)
                            {
                                std::cout << "RAM: " << pcs[i]->GetRAM()->Print() << std::endl;
                                std::cout << "\tPrice: " << ShowPrice(pcs[i]->GetRAM()->GetPrice()) << std::endl;
                            }
                            else
                            {
                                std::cout << "RAM: None" << std::endl;
                            }

                            std::cout << "HDD: " << pcs[i]->GetHDD()->Print() << std::endl;
                            std::cout << "\tPrice: " << ShowPrice(pcs[i]->GetHDD()->GetPrice()) << std::endl;
                            
                            if(pcs[i]->GetCooler() != NULL)
                            {
                                std::cout << "Cooler: " << pcs[i]->GetCooler()->Print() << std::endl;
                                std::cout << "\tPrice: " << ShowPrice(pcs[i]->GetCooler()->GetPrice()) << std::endl;
                            }
                            else
                            {
                                std::cout << "Cooler: None" << std::endl;
                            }

                            if(pcs[i]->GetDVD() != NULL)
                            {
                                std::cout << "DVD: Present" << std::endl;
                                std::cout << "\tPrice: " << ShowPrice(pcs[i]->GetCooler()->GetPrice()) << std::endl;
                            }
                            else
                            {
                                std::cout << "DVD: None" << std::endl;
                            }

                            if(pcs[i]->GetGraphicsCard() != NULL)
                            {
                                std::cout << "Graphics Card: " << pcs[i]->GetGraphicsCard()->Print() << std::endl;
                                std::cout << "\tPrice: " << ShowPrice(pcs[i]->GetGraphicsCard()->GetPrice()) << std::endl;
                            }
                            else
                            {
                                std::cout << "Graphics Card: None" << std::endl;
                            }

                            std::cout << "Base Price: " << pcs[i]->GetBasePrice() << std::endl;
                            std::cout << "Total Price: " << pcs[i]->GetTotalPrice() << std::endl;
                        }

                        for(size_t i = 0; i < pcs.size(); ++i)
                        {
                            delete pcs[i];
                        }

                        delete pcBuilder;
                        delete director;

                        break;
                    }
                }
                else
                {
                    std::cout << INVALID_INPUT_MESSAGE << std::endl;
                }

                for(size_t i = 0; i < pcs.size(); ++i);

                delete pcBuilder;
                delete director;
            }
        }
        else if(line == "q")
        {
            break;
        }
        else
        {
            std::cout << INVALID_INPUT_MESSAGE << std::endl;
        }
    }

    return 0;
}
