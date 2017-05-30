// note that iostream is not included, the printing comes via Fortran code
#include <cstdlib>
#include <vector>


extern "C" void yourmsg(float [],int*);


int main()
{
    int N = 3;
    std::vector<float> x((std::size_t(N)));

    for (std::vector<double>::size_type i = 0; i < x.size(); i++)
    {
        x[i] = 2.*i;
    }

    yourmsg(&x.front(), &N);

    
    return EXIT_SUCCESS;
}
