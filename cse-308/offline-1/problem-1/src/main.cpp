#include "Utilities.h"

int main()
{
    bool takingOrder = false;

    while(true)
    {
        std::string command;
        PCBuilder *pcBuilder = NULL;

        command = Utilities::ToLower(command);

        if(command == "o")
        {
            if(takingOrder)
            {
                std::cout << "Already taking an order. Better add something new?" << std::endl;
            }
            else
            {
                takingOrder = true;
                pcBuilder = new PCBuilder();
            }
        }
        else if(command == "e")
        {
            if(takingOrder)
            {
                takingOrder = false;

                delete pcBuilder;
            }
            else
            {
                std::cout << "Currently taking no order" << std::endl;
            }
        }
        else if(command == "processor")
        {
            if(takingOrder)
            {
                std::string processorModel;

                std::cin >> processorModel;

                
            }
            else
            {
                std::cout << "Start an order first" << std::endl;
            }
        }
        else if(command == "ram")
        {

        }
        else if(command == "hdd")
        {
            
        }
        else if(command == "dvd")
        {

        }
        else if(command == "cooler")
        {

        }
        else if(command == "gpu")
        {

        }
        else if(command == "gaming")
        {

        }
        else if(command == "type1")
        {

        }
        else if(command == "type2")
        {

        }
        else if(command == "type3")
        {

        }
        else
        {

        }
    }
}