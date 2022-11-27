#pragma once

#include <memory>
#include <string>
#include "Continent.h"

/**
 * @brief Continent factory prducer
 * 
 */
class ContinentProducer
{
public:
    static std::unique_ptr<Continent> GetFactory(const std::string &continent);
};