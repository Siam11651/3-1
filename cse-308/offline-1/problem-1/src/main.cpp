#include "Utilities.h"

// processor
const AMD_Ryzen7_5700X SAMPLE_AMD_RYZEN7_5700X;
const Intel11GenCore_i5 SAMPLE_INTEL11GEN_CORE_I5;
const Intel11GenCore_i7 SAMPLE_INTEL11GEN_CORE_I7;
const Intel11GenCore_i9 SAMPLE_INTEL11GEN_CORE_I9;
// end processor

// ram
const RAM8GB2666MHzDDR4 SAMPLE_RAM8GB2666MHZ_DDR4;
const RAM8GB3200MHzDDR4 SAMPLE_RAM8GB3200MHZ_DDR4;
// end ram

// hdd
const HDD1TB SAMPLE_HDD1TB;
// end hdd

// dvd
const DVD SAMPLE_DVD;
// end dvd

// cooler
const CPUCooler SAMPLE_CPU_COOLER;
const LiquidCooler SAMPLE_LIQUID_COOLER;
// end coolder

// gpu
const GraphicsCard2GB GRAPHICS_CARD_2GB;
const GraphicsCard4GB GRAPHICS_CARD_4GB;
// end gpu

int main()
{
    PCBuilder *pcBuilder = NULL;
    Director *director = NULL;

    while(true)
    {
        std::string line = Utilities::FormatNewLine();

        if(line == "o")
        {
            std::cout << "Choose build type:" << std::endl;
            std::cout << "[1] Gaming Build" << std::endl;
            std::cout << "[2] Type 1 Build" << std::endl;
            std::cout << "[3] Type 2 Build" << std::endl;
            std::cout << "[4] Type 3 Build" << std::endl;
            std::cout << "[5] Custom" << std::endl;
            std::cout << "[e] Close order" << std::endl;

            std::string line = Utilities::FormatNewLine();

            if(line == "1")
            {

            }
            else if(line == "2")
            {

            }
            else if(line == "3")
            {

            }
            else if(line == "4")
            {

            }
            else if(line == "5")
            {

            }
            else if(line == "e")
            {

            }
            else
            {
                std::cout << 
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