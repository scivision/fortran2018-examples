#include <iostream>
#include <filesystem>

int main(){

std::cout << std::filesystem::path::preferred_separator << std::endl;

return EXIT_SUCCESS;
}
