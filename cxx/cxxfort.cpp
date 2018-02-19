#include <iostream>
#include <cstdlib>
#include <vector>

extern "C" void timestwo(double [],double [],int*);


int main()
{
    int N = 3;
    std::vector<double> x((std::size_t(N)));
    std::vector<double> x2((std::size_t(N)));

    for (std::vector<double>::size_type i = 0; i < x.size(); i++)
    {
        x[i] = i;
    }

    timestwo(&x.front(), &x2.front(), &N);
    
    for (auto xx: x2)
        std::cout << xx << ' ';


    return EXIT_SUCCESS;
}
