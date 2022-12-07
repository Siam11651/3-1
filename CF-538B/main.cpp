#include <bits/stdc++.h>

int main()
{
    size_t n;

    std::cin >> n;

    std::stringstream sStream("");

    sStream << n;

    std::string number = sStream.str();
    size_t digitCount = number.size();
    std::vector<size_t> valueEachDigit(digitCount);
    size_t maxDigit = 0;

    for(size_t i = 0; i < digitCount; ++i)
    {
        size_t digit = number[i] - '0';
        maxDigit = std::max(maxDigit, digit);
        valueEachDigit[i] = digit;
    }

    std::vector<std::string> binaries(maxDigit, std::string(digitCount, '0'));

    for(size_t i = 0; i < digitCount; ++i)
    {
        for(size_t j = 0; j < valueEachDigit[i]; ++j)
        {
            binaries[j][i] = '1';
        }
    }

    std::cout << binaries.size() << std::endl;

    for(size_t i = 0; i < binaries.size(); ++i)
    {
        sStream.clear();
        sStream.str(binaries[i]);

        size_t toPrint;

        sStream >> toPrint;

        std::cout << toPrint << ' ';
    }

    std::cout << std::endl;

    return 0;
}