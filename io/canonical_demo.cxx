#include <cstring>
#include <iostream>
#include "canonical.hpp"

int main(void){

char pathstr[LEN];

std::strcpy(pathstr, "~/foo");
expanduser(pathstr);
std::cout << pathstr << std::endl;

std::strcpy(pathstr, "../..");
canonical(pathstr);
std::cout << pathstr << std::endl;
return 0;
}