#pragma once

#include <string>
#include "Color.h"
#include "Engine.h"
#include "WheelType.h"

class Car
{
protected:
    std::string name;
    Color *color;
    Engine *engine;
    WheelType *wheelType;

    Car();
public:
    std::string GetName();
    Color *GetColor();
    Engine *GetEngine();
    WheelType *GetWheelType();
    ~Car();
};