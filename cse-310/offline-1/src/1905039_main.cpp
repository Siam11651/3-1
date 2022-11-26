#include <iostream>
#include <fstream>
#include <string>
#include <sstream>
#include <cstring>
#include "1905039_SymbolTable.h"
#include "1905039_StringTokens.h"

#define FILEIO

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
    std::string line;

    std::getline(input, line);

    std::stringstream ss(line);

    ss >> numberOfBuckets;

    SymbolTable *symbolTable = new SymbolTable(numberOfBuckets, &output);

    size_t count = 0;

    while(true)
    {
        ++count;

        std::getline(input, line);

        if(line.back() == '\r')
        {
            line = line.substr(0, line.size() - 1);
        }

        output << "Cmd " << count <<  ": " << line << std::endl;

        StringTokens stringTokens(line);

        if(stringTokens.GetToken(0) == "I")
        {
            if(stringTokens.GetCount() != 3)
            {
                output << "\tNumber of parameters mismatch for the command " << stringTokens.GetToken(0) << std::endl;
            }
            else
            {
                std::string name(stringTokens.GetToken(1));
                std::string type(stringTokens.GetToken(2));

                symbolTable->Insert(SymbolInfo(name, type));
            }
        }
        else if(stringTokens.GetToken(0) == "L")
        {
            if(stringTokens.GetCount() != 2)
            {
                output << "\tNumber of parameters mismatch for the command " << stringTokens.GetToken(0) << std::endl;
            }
            else
            {
                std::string name(stringTokens.GetToken(1));

                symbolTable->LookUp(name);
            }
        }
        else if(stringTokens.GetToken(0) == "D")
        {
            if(stringTokens.GetCount() != 2)
            {
                output << "\tNumber of parameters mismatch for the  command " << stringTokens.GetToken(0) << std::endl;
            }
            else
            {
                std::string name(stringTokens.GetToken(1));

                symbolTable->Delete(name);
            }
        }
        else if(stringTokens.GetToken(0) == "P")
        {
            if(stringTokens.GetCount() != 2)
            {
                output << "\tNumber of parameters mismatch for the command " << stringTokens.GetToken(0) << std::endl;
            }
            else
            {
                std::string type(stringTokens.GetToken(1));

                if(type == "A")
                {
                    symbolTable->PrintAllScope();
                }
                else
                {
                    symbolTable->PrintCurrentScope();
                }
            }
        }
        else if(stringTokens.GetToken(0) == "S")
        {
            if(stringTokens.GetCount() != 1)
            {
                output << "\tNumber of parameters mismatch for the command " << stringTokens.GetToken(0) << std::endl;
            }
            else
            {
                symbolTable->EnterScope();
            }
        }
        else if(stringTokens.GetToken(0) == "E")
        {
            if(stringTokens.GetCount() != 1)
            {
                output << "\tNumber of parameters mismatch for the command " << stringTokens.GetToken(0) << std::endl;
            }
            else
            {
                symbolTable->ExitScope();
            }
        }
        else if(stringTokens.GetToken(0) == "Q")
        {
            if(stringTokens.GetCount() != 1)
            {
                output << "\tNumber of parameters mismatch for the command " << stringTokens.GetToken(0) << std::endl;
            }
            else
            {
                delete symbolTable;

                break;
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