#include "Car.h"

Car::Car()
{
    name = "";
    color = NULL;
    engine = NULL;
    wheelType = NULL;
}

std::string Car::GetName()
{
    return name;
}

Color *Car::GetColor()
{
    return color;
}

Engine *Car::GetEngine()
{
    return engine;
}

WheelType *Car::GetWheelType()
{
    return wheelType;
}

Car::~Car()
{
    delete color;
    delete engine;
    delete wheelType;
}