#pragma once

#include <string>

class Part
{
protected:
    uint64_t price;
    std::string partType;
public:
    uint64_t GetPrice() const;
    std::string GetPartType() const;
    virtual std::string Print() = 0;
};