#include <bits/stdc++.h>

uint64_t GCD(uint64_t l, uint64_t s)
{
    if(l < s)
    {
        std::swap(l, s);
    }

    if(s == 0)
    {
        return l;
    }
    else
    {
        return GCD(s, l % s);
    }
}

int main()
{
    size_t t;

    std::cin >> t;

    while(t--)
    {
        size_t n;

        std::cin >> n;

        std::vector<uint64_t> a(n);

        for(size_t i = 0; i < n; ++i)
        {
            std::cin >> a[i];
        }

        std::vector<uint64_t> r(n, 0);
        uint64_t newColor = 1;

        for(size_t i = 0; i < n; ++i)
        {
            if(r[i] == 0)
            {
                r[i] = newColor;
                ++newColor;
            }

            for(size_t j = i + 1; j < n; ++j)
            {
                if(r[j] == 0)
                {
                    if(GCD(a[i], a[j]) > 1)
                    {
                        r[j] = r[i];

                        break;
                    }
                }
            }
        }

        std::cout << newColor - 1 << std::endl;

        for(size_t i = 0; i < n; ++i)
        {
            std::cout << r[i] << ' ';
        }

        std::cout << std::endl;
    }

    return 0;
}