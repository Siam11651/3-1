#include <iostream>
#include <fstream>
#include <string>
#include <cstring>
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

    SymbolTable symbolTable(numberOfBuckets, &output);

    while(true)
    {
        std::string line;

        std::getline(input, line);

        std::string command(std::strtok(line.data(), " "));

        if(command == "I")
        {
            std::string name(std::strtok(line.data(), " "));
            std::string type(std::strtok(line.data(), " "));

            if(std::strtok(line.data(), " ") == NULL)
            {
                output << "Number of parameters mismatch for the command " << command << std::endl;
            }
            else
            {
                symbolTable.Insert(SymbolInfo(name, type));
            }
        }
        else if(command == "L")
        {
            std::string name(std::strtok(line.data(), " "));

            if(std::strtok(line.data(), " ") == NULL)
            {
                output << "Number of parameters mismatch for the command " << command << std::endl;
            }
            else
            {
                symbolTable.LookUp(name);
            }
        }
        else if(command == "D")
        {
            std::string name(std::strtok(line.data(), " "));

            if(std::strtok(line.data(), " ") == NULL)
            {
                output << "Number of parameters mismatch for the command " << command << std::endl;
            }
            else
            {
                symbolTable.Delete(name);
            }
        }
        else if(command == "P")
        {
            std::string type(std::strtok(line.data(), " "));

            if(std::strtok(line.data(), " ") == NULL)
            {
                output << "Number of parameters mismatch for the command " << command << std::endl;
            }
            else
            {
                if(type == "A")
                {
                    symbolTable.PrintAllScope();
                }
                else
                {
                    symbolTable.PrintCurrentScope();
                }
            }
        }
        else if(command == "S")
        {
            if(std::strtok(line.data(), " ") == NULL)
            {
                output << "Number of parameters mismatch for the command " << command << std::endl;
            }
            else
            {
                symbolTable.EnterScope();
            }
        }
        else if(command == "E")
        {
            if(std::strtok(line.data(), " ") == NULL)
            {
                output << "Number of parameters mismatch for the command " << command << std::endl;
            }
            else
            {
                symbolTable.ExitScope();
            }
        }
        else if(command == "Q")
        {
            if(std::strtok(line.data(), " ") == NULL)
            {
                output << "Number of parameters mismatch for the command " << command << std::endl;
            }
            else
            {
                
            }
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