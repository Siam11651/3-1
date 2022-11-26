#include "StrinkTokens.h"

StringTokens::StringTokens(const std::string &string)
{
    if(string.size() == 0)
    {
        tokens = NULL;
        count = 0;
    }
    else
    {
        count = 0;

        for(size_t i = 0; i < string.size(); ++i)
        {
            if(count == 0)
            {
                if(string[i] != ' ')
                {
                    
                }
            }

            if(i > 0 && i < string.size() - 1)
            {
                if(string[i] == ' ')
            }
        }
    }
}