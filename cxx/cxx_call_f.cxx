#include <iostream>
#include <vector>

extern "C" void timestwo(double [],double [],int*);


int main()
{
  auto N = 3;
  std::vector<double> x(N);
  std::vector<double> x2(N);

  for (auto i = 0; i < x.size(); i++)
    x[i] = i;

  timestwo(&x.front(), &x2.front(), &N);

  for (auto i: x2)
    std::cout << i << ' ';

  return EXIT_SUCCESS;
}
