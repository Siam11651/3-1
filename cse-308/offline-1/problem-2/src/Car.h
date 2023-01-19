#pragma once

#include <string>
#include "Color.h"
#include "Engine.h"
#include "DriveTrain.h"

class Car
{
protected:
    std::string name;
    Color *color;
    Engine *engine;
    DriveTrain *driveTrain;

    Car();
public:
    std::string GetName();
    Color *GetColor();
    Engine *GetEngine();
    DriveTrain *GetDriveTrain();
    ~Car();
};