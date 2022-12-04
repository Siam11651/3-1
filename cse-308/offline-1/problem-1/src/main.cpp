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

        sStream << price;

        return sStream.str();
    }
}

void DirectBuild(Director &director)
{
    while(true)
    {
        std::cout << "Set RAM:" << std::endl;
        std::cout << "[1] " << SAMPLE_RAM8GB2666MHZ_DDR4.Print() << "; Price: " << ShowPrice(SAMPLE_RAM8GB2666MHZ_DDR4.GetPrice()) << std::endl;
        std::cout << "[2] " << SAMPLE_RAM8GB3200MHZ_DDR4.Print() << "; Price: " << ShowPrice(SAMPLE_RAM8GB3200MHZ_DDR4.GetPrice()) << std::endl;
        std::cout << "[0] Do not add" << std::endl;

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

    while(true)
    {
        std::cout << "Set Graphics Card:" << std::endl;
        std::cout << "[1] " << SAMPLE_GRAPHICS_CARD_2GB.Print() << "; Price: " << ShowPrice(SAMPLE_GRAPHICS_CARD_2GB.GetPrice()) << std::endl;
        std::cout << "[2] " << SAMPLE_GRAPHICS_CARD_4GB.Print() << "; Price: " << ShowPrice(SAMPLE_GRAPHICS_CARD_4GB.GetPrice()) << std::endl;
        std::cout << "[0] Do not add" << std::endl;

        std::string line = Utilities::FormatNewLine();

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
        std::vector<PC *> pcs;

        if(line == "o")
        {
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
                    director->Build();
                    pcs.push_back(pcBuilder->GetBuiltPCPointer());
                }
                else if(line == "2")
                {
                    pcBuilder = new Type1PCBuilder();
                    director = new Director(pcBuilder);

                    DirectBuild(*director);
                    director->Build();
                    pcs.push_back(pcBuilder->GetBuiltPCPointer());
                }
                else if(line == "3")
                {
                    pcBuilder = new Type2PCBuilder();
                    director = new Director(pcBuilder);

                    DirectBuild(*director);
                    director->Build();
                    pcs.push_back(pcBuilder->GetBuiltPCPointer());
                }
                else if(line == "4")
                {
                    pcBuilder = new Type3PCBuilder();
                    director = new Director(pcBuilder);

                    DirectBuild(*director);
                    director->Build();
                    pcs.push_back(pcBuilder->GetBuiltPCPointer());
                }
                else if(line == "e")
                {
                    if(pcs.size() > 0)
                    {
                        for(size_t i = 0; i < pcs.size(); ++i)
                        {
                            std::stringstream sStreamTitle("");
                            
                            sStreamTitle << "PC " << i + 1 << ':';

                            std::string title = sStreamTitle.str();
                            std::string dashes(title.size(), '-');

                            std::cout << title << std::endl;
                            std::cout << dashes << std::endl;
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
                                std::cout << "\tPrice: " << ShowPrice(pcs[i]->GetDVD()->GetPrice()) << std::endl;
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
                            std::cout << std::endl;
                        }

                        for(size_t i = 0; i < pcs.size(); ++i)
                        {
                            delete pcs[i];
                        }

                        delete pcBuilder;
                        delete director;

                        break;
                    }
                    else
                    {
                        std::cout << "Order atleast one PC to close" << std::endl;
                    }
                }
                else
                {
                    std::cout << INVALID_INPUT_MESSAGE << std::endl;
                }

                delete pcBuilder;
                delete director;
            }
        }
        else if(line == "q")
        {
            std::cout << "Have a good day" << std::endl;

            break;
        }
        else
        {
            std::cout << INVALID_INPUT_MESSAGE << std::endl;
        }
    }

    return 0;
}
