// snippet to test compilers for C++17 filesystem
#include <filesystem>
#include <iostream>
namespace fs = std::filesystem;

int main(void) {
fs::path p = fs::path(".");
std::cout << p << fs::canonical(p) << std::endl;
return EXIT_SUCCESS; }