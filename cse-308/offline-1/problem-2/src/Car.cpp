#include "Car.h"

Car::Car()
{
    name = "";
    color = NULL;
    engine = NULL;
    driveTrain = NULL;
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

DriveTrain *Car::GetDriveTrain()
{
    return driveTrain;
}

Car::~Car()
{
    delete color;
    delete engine;
    delete driveTrain;
}