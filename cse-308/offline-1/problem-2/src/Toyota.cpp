#include "Toyota.h"

Toyota::Toyota()
{
    name = "Toyota";
    color = new Red();
    engine = new HydrogenFuelCell();
    wheelType = new RearWheel();
}