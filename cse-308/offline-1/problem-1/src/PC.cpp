#include "PC.h"

int64_t PC::AddPart(const Part &part)
{
    std::string partType = part.GetPartType();
    Part *newPart = NULL;
    size_t maxCount = 0;

    if(partType == "PROCESSOR")
    {
        newPart = new Processor(*((Processor *)&part));
        maxCount = MAX_PROCESSORS;
    }
    else if(partType == "RAM")
    {
        newPart = new RAM(*((RAM *)&part));
        maxCount = MAX_RAMS;
    }
    else if(partType == "HDD")
    {
        newPart = new HDD(*((HDD *)&part));
        maxCount = MAX_HDDS;
    }
    else if(partType == "DVD")
    {
        newPart = new DVD(*((DVD *)&part));
        maxCount = MAX_DVDS;
    }
    else if(partType == "COOLER")
    {
        newPart = new Cooler(*((Cooler *)&part));
        maxCount = MAX_PROCESSORS;
    }
    else if(partType == "GRAPHICS_CARD")
    {
        newPart = new GraphicsCard(*((GraphicsCard *)&part));
        maxCount = MAX_GPUS;
    }
    else
    {
        return 1; // invalid part type
    }

    if(partTypeCount.find(partType) == partTypeCount.end())
    {
        partTypeCount.insert({partType, 1});
        parts.push_back(newPart);
    }
    else
    {
        if(partTypeCount[partType] < maxCount)
        {
            ++partTypeCount[partType];
            
            parts.push_back(newPart);

            return 0; // success
        }
        else
        {
            return 2; // too many parts of same type
        }
    }
}

PC::~PC()
{
    for(size_t i = 0; i < parts.size(); ++i)
    {
        delete parts[i];
    }
}