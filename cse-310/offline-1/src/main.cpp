#include <iostream>
#include <fstream>
#include "SymbolTable.h"

// #define FILEIO

int main()
{
#if defined FILEIO
    std::ifstream inputFileStream("input.txt");
    std::ofstream outputFileStream("output.txt");
    std::istream &input = inputFileStream;
    std::ostream &output = outputFileStream;
#else
    std::istream &input = std::cin;
    std::ostream &output = std::cout;
#endif

    size_t numberOfBuckets;

    input >> numberOfBuckets;

    SymbolTable symbolTable(numberOfBuckets);

    output << "ScopeTable# " << symbolTable.GetCurrentScope()->GetID() << " created" << std::endl;

    size_t commandCount = 0;

    while(true)
    {
        char command;

        input >> command;

        ++commandCount;

        if(command == 'I')
        {
            std::string symbolName, symbolType;

            std::cin >> symbolName >> symbolType;

            output << "Cmd " << commandCount << ": " << command << ' ' << symbolName << ' ' << symbolType << std::endl;

            SymbolInfo symbolInfo(symbolName, symbolType);

            symbolTable.Insert(symbolInfo);

            
        }
        else if(command == 'L')
        {

        }
        else if(command == 'D')
        {

        }
        else if(command == 'P')
        {

        }
        else if(command == 'S')
        {

        }
        else if(command == 'E')
        {

        }
        else if(command == 'Q')
        {

        }
        else
        {
            
        }
    }
    

#if defined FILEIO
    inputFileStream.close();
    outputFileStream.close();
#endif

    return 0;
}