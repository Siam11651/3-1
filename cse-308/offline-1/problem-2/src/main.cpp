#include "Utilities.h"

int main()
{
    while(true)
    {
        std::string continent;

        std::cin >> continent;

        continent = Utilities::ToLower(continent);

        CarFactory *carFactory = CarFactory::GetFactoryPointerOnContinent(continent);

        if(carFactory != NULL)
        {
            Car *car = carFactory->GetNewCarPointer();

            std::cout << "Brand: " << car->GetName() << std::endl;
            std::cout << "Color: " << car->GetColor()->GetName() << std::endl;
            std::cout << "Engine: " << car->GetEngine()->GetName() << std::endl;
            std::cout << "Drive Train: " << car->GetDriveTrain()->GetName() << std::endl;

            delete car;
            delete carFactory;
        }
    }

    return 0;
}