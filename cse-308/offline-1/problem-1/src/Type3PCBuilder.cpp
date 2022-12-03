#include "Type3PCBuilder.h"

Type3PCBuilder::Type3PCBuilder()
{
    processor = new Intel11GenCore_i9();
    hdd = new HDD1TB();
    dvd = new DVD();
}