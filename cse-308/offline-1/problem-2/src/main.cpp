#include "Utilities.h"

int main()
{
    while(true)
    {
        std::string continent;

        std::cin >> continent;

        continent = Utilities::ToLower(continent);

        CarFactory *carFactory = NULL;

        if(continent == "asia")
        {
            carFactory = CarFactory::GetFactoryPointerOnContinent(ContinentEnum::ASIA);
        }
        else if(continent == "europe")
        {
            carFactory = CarFactory::GetFactoryPointerOnContinent(ContinentEnum::EUROPE);
        }
        else if(continent == "usa")
        {
            carFactory = CarFactory::GetFactoryPointerOnContinent(ContinentEnum::USA);
        }
        else
        {
            std::cout << "Invalid continent name" << std::endl;
        }

        if(carFactory != NULL)
        {
            Car *car = carFactory->GetNewCarPointer();

            std::cout << "Name: " << car->GetName() << std::endl;
            std::cout << "Color: " << car->GetColor()->GetName() << std::endl;
            std::cout << "Engine: " << car->GetEngine()->GetName() << std::endl;
            std::cout << "Drive Train: " << car->GetDriveTrain()->GetName() << std::endl;

            delete car;
            delete carFactory;
        }
    }

    return 0;
}