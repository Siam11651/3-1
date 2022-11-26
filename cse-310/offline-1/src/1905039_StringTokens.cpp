#include "1905039_StringTokens.h"

StringTokens::StringTokens(const std::string &string)
{
    count = 0;
    bool checkSpace = false;

    for(size_t i = 0; i < string.size(); ++i)
    {
        if(checkSpace)
        {
            if(string[i] == ' ')
            {
                checkSpace = false;
            }
        }
        else
        {
            if(string[i] != ' ')
            {
                checkSpace = true;
                ++count;
            }
        }
    }

    if(count)
    {
        tokens = new std::string[count];
        std::string word = "";
        size_t allocated = 0;

        for(size_t i = 0; i < string.size() && allocated < count; ++i)
        {
            if(string[i] == ' ')
            {
                if(word != "")
                {
                    tokens[allocated] = word;
                    word = "";
                    ++allocated;
                }
            }
            else
            {
                word += string[i];
            }
        }

        if(allocated < count && word != "")
        {
            tokens[allocated] = word;
        }
    }
    else
    {
        tokens = NULL;
    }
}

std::string StringTokens::GetToken(size_t index)
{
    if(index >= count)
    {
        return "";
    }
    else
    {
        return tokens[index];
    }
}

size_t StringTokens::GetCount()
{
    return count;
}

StringTokens::~StringTokens()
{
    if(tokens != NULL)
    {
        delete[] tokens;
    }
}