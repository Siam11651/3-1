#include "Utilities.h"

void AddProcessorReturnHandler(int64_t returnValue)
{
    if(returnValue == 1)
    {
        std::cout << "All processor slots used" << std::endl;
    }
}

void AddRAMReturnHandler(int64_t returnValue)
{
    if(returnValue == 1)
    {
        std::cout << "All RAM slots used" << std::endl;
    }
}

void AddHDDReturnHandler(int64_t returnValue)
{
    if(returnValue == 1)
    {
        std::cout << "All HDD slots used" << std::endl;
    }
}

void AddDVDReturnHandler(int64_t returnValue)
{
    if(returnValue == 1)
    {
        std::cout << "All DVD slots used" << std::endl;
    }
}

void AddCoolerReturnHandler(int64_t returnValue)
{
    if(returnValue == 1)
    {
        std::cout << "All cooler slots used" << std::endl;
    }
}

void AddGraphicsCardReturnHandler(int64_t returnValue)
{
    if(returnValue == 1)
    {
        std::cout << "All graphics card slots used" << std::endl;
    }
}

void AddPart(bool &orderRunning, PCBuilder &pcBuilder)
{
    while(orderRunning)
    {
        std::cout << "Choose part to add:" << std::endl;
        std::cout << "[1] Processor" << std::endl;
        std::cout << "[2] RAM" << std::endl;
        std::cout << "[3] HDD" << std::endl;
        std::cout << "[4] DVD" << std::endl;
        std::cout << "[5] Cooler" << std::endl;
        std::cout << "[6] Graphics Card" << std::endl;
        std::cout << "[0] Go back" << std::endl;
        std::cout << "[e] Close order" << std::endl;

        std::string line = Utilities::FormatNewLine();

        if(line == "e")
        {
            orderRunning = false;
        }
        else if(Utilities::IsInteger(line))
        {
            uint64_t item = Utilities::ParseItem(line);

            if(item == 1)
            {
                AddProcessor(orderRunning, pcBuilder);
            }
            else if(item == 2)
            {
                AddRAM(orderRunning, pcBuilder);
            }
            else if(item == 3)
            {
                AddHDD(orderRunning, pcBuilder);
            }
            else if(item == 4)
            {
                AddDVD(orderRunning, pcBuilder);
            }
            else if(item == 5)
            {
                AddCooler(orderRunning, pcBuilder);
            }
            else if(item == 6)
            {
                AddGraphicsCard(orderRunning, pcBuilder);
            }
            else if(item == 0)
            {
                orderRunning = false;
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

void AddProcessor(bool &orderRunning, PCBuilder &pcBuilder)
{
    while(orderRunning)
    {
        std::cout << "Choose processor:" << std::endl;
        std::cout << "[1] AMD Ryzen 7 5700X" << std::endl;
        std::cout << "[2] Intel 11th Gen Core i5" << std::endl;
        std::cout << "[3] Intel 11th Gen Core i7" << std::endl;
        std::cout << "[4] Intel 11th Gen Core i9" << std::endl;
        std::cout << "[0] Go back" << std::endl;
        std::cout << "[e] Close order" << std::endl;

        std::string line = Utilities::FormatNewLine();

        if(line == "e")
        {
            orderRunning = false;
        }
        else if(Utilities::IsInteger(line))
        {
            uint64_t item = Utilities::ParseItem(line);
            bool validItem = true;

            if(item == 1)
            {
                AddProcessorReturnHandler(pcBuilder.AddProcessor(AMD_Ryzen7_5700X()));
            }
            else if(item == 2)
            {
                AddProcessorReturnHandler(pcBuilder.AddProcessor(Intel11GenCore_i5()));
            }
            else if(item == 3)
            {
                AddProcessorReturnHandler(pcBuilder.AddProcessor(Intel11GenCore_i7()));
            }
            else if(item == 4)
            {
                AddProcessorReturnHandler(pcBuilder.AddProcessor(Intel11GenCore_i9()));
            }
            else if(item != 0)
            {
                std::cout << INVALID_INPUT_MESSAGE << std::endl;

                validItem = false;
            }
            
            if(validItem)
            {
                break;
            }
        }
        else
        {
            std::cout << INVALID_INPUT_MESSAGE << std::endl;
        }
    }
}

void AddRAM(bool &orderRunning, PCBuilder &pcBuilder)
{
    while(orderRunning)
    {
        std::cout << "Choose RAM:" << std::endl;
        std::cout << "[1] 8 GB DDR4 2666 MHz" << std::endl;
        std::cout << "[2] 8 GB DDR4 3200 MHz" << std::endl;
        std::cout << "[0] Go back" << std::endl;
        std::cout << "[e] Close order" << std::endl;

        std::string line = Utilities::FormatNewLine();

        if(line == "e")
        {
            orderRunning = false;
        }
        else if(Utilities::IsInteger(line))
        {
            uint64_t item = Utilities::ParseItem(line);

            if(item == 1)
            {
                AddRAMReturnHandler(pcBuilder.AddRAM(RAM8GB2666MHzDDR4()));

                break;
            }
            else if(item == 2)
            {
                AddRAMReturnHandler(pcBuilder.AddRAM(RAM8GB3200MHzDDR4()));

                break;
            }
            else if(item == 0)
            {
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

void AddHDD(bool &orderRunning, PCBuilder &pcBuilder)
{
    while(orderRunning)
    {
        std::cout << "Choose HDD:" << std::endl;
        std::cout << "[1] 1 TB HDD" << std::endl;
        std::cout << "[0] Go back" << std::endl;
        std::cout << "[e] Close order" << std::endl;

        std::string line = Utilities::FormatNewLine();

        if(line == "e")
        {
            orderRunning = false;
        }
        else if(Utilities::IsInteger(line))
        {
            uint64_t item = Utilities::ParseItem(line);

            if(item == 1)
            {
                AddHDDReturnHandler(pcBuilder.AddHDD(HDD1TB()));

                break;
            }
            else if(item == 0)
            {
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

void AddDVD(bool &orderRunning, PCBuilder &pcBuilder)
{
    while(orderRunning)
    {
        std::cout << "Add DVD?" << std::endl;
        std::cout << "[y] Yes" << std::endl;
        std::cout << "[n] No" << std::endl;
        std::cout << "[e] Close order" << std::endl;

        std::string line = Utilities::FormatNewLine();

        if(line == "e")
        {
            orderRunning = false;
        }
        else if(line == "y")
        {
            AddDVDReturnHandler(pcBuilder.AddDVD(DVD()));

            break;
        }
        else if(line != "n")
        {
            break;
        }
        else
        {
            std::cout << INVALID_INPUT_MESSAGE << std::endl;
        }
    }
}

void AddCooler(bool &orderRunning, PCBuilder &pcBuilder)
{
    while(orderRunning)
    {
        std::cout << "Choose cooler:" << std::endl;
        std::cout << "[1] CPU Coolder" << std::endl;
        std::cout << "[2] Liquid Cooler" << std::endl;
        std::cout << "[0] Go back" << std::endl;
        std::cout << "[e] Close order" << std::endl;

        std::string line = Utilities::FormatNewLine();

        if(line == "e")
        {
            orderRunning = false;
        }
        else if(Utilities::IsInteger(line))
        {
            uint64_t item = Utilities::ParseItem(line);
            bool validItem = true;

            if(item == 1)
            {
                AddCoolerReturnHandler(pcBuilder.AddCooler(CPUCooler()));
            }
            else if(item == 2)
            {
                AddCoolerReturnHandler(pcBuilder.AddCooler(LiquidCooler()));
            }
            else if(item != 0)
            {
                std::cout << INVALID_INPUT_MESSAGE << std::endl;

                validItem = false;
            }

            if(validItem)
            {
                break;
            }
        }
        else
        {
            std::cout << INVALID_INPUT_MESSAGE << std::endl;
        }
    }
}

void AddGraphicsCard(bool &orderRunning, PCBuilder &pcBuilder)
{
    while(orderRunning)
    {
        std::cout << "Choose graphics card:" << std::endl;
        std::cout << "[1] 2 GB GPU" << std::endl;
        std::cout << "[2] 4 GB GPU" << std::endl;
        std::cout << "[0] Go back" << std::endl;
        std::cout << "[e] Close order" << std::endl;

        std::string line = Utilities::FormatNewLine();

        if(line == "e")
        {
            orderRunning = false;
        }
        else if(Utilities::IsInteger(line))
        {
            uint64_t item = Utilities::ParseItem(line);
            bool validItem = true;

            if(item == 1)
            {
                AddGraphicsCardReturnHandler(pcBuilder.AddGraphicsCard(GraphicsCard2GB()));
            }
            else if(item == 2)
            {
                AddGraphicsCardReturnHandler(pcBuilder.AddGraphicsCard(GraphicsCard4GB()));
            }
            else if(item != 0)
            {
                std::cout << INVALID_INPUT_MESSAGE << std::endl;

                validItem = false;
            }

            if(validItem)
            {
                break;
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
    bool takingOrder = false;

    while(true)
    {
        PCBuilder *pcBuilder = NULL;
        bool orderRunning = true;

        std::cout << "Available commands:" << std::endl;
        std::cout << "[o] Create new order" << std::endl;
        std::cout << "[q] Exit" << std::endl;

        std::string line = Utilities::FormatNewLine();

        if(line == "o")
        {
            while(orderRunning)
            {
                std::cout << "Choose your build:" << std::endl;
                std::cout << "[1] Gaming" << std::endl;
                std::cout << "[2] Type 1" << std::endl;
                std::cout << "[3] Type 2" << std::endl;
                std::cout << "[4] Type 3" << std::endl;
                std::cout << "[5] Custom" << std::endl;
                std::cout << "[e] Close order" << std::endl;

                line = Utilities::FormatNewLine();

                if(line == "e")
                {
                    orderRunning = false;
                }
                else if(Utilities::IsInteger(line))
                {
                    uint64_t item = Utilities::ParseItem(line);
                    bool validItem = true;

                    if(item == 1)
                    {
                        pcBuilder = new GamingPCBuilder();
                    }
                    else if(item == 2)
                    {
                        pcBuilder = new Type1PCBuilder();
                    }
                    else if(item == 3)
                    {
                        pcBuilder = new Type2PCBuilder();
                    }
                    else if(item == 4)
                    {
                        pcBuilder = new Type3PCBuilder();
                    }
                    else if(item == 5)
                    {
                        pcBuilder = new PCBuilder();
                    }
                    else
                    {
                        std::cout << INVALID_INPUT_MESSAGE << std::endl;

                        validItem = false;
                    }

                    if(validItem)
                    {
                        AddPart(orderRunning, *pcBuilder);
                    }
                }
                else
                {
                    std::cout << INVALID_INPUT_MESSAGE << std::endl;
                }
            }
        }
        else if(line == "q")
        {
            std::cout << "Have a great day, sir" << std::endl;

            break;
        }
        else
        {
            std::cout << INVALID_INPUT_MESSAGE << std::endl;
        }
    }
}