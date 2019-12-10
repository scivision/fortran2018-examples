#include <iostream>
#include <filesystem>

namespace fs = std::filesystem;

int main(void){
    fs::path p = fs::path("..") / ".." ;
    std::cout << "Current path is " << fs::current_path() << '\n'
              << "Canonical path for " << p << " is " << fs::canonical(p) << '\n';
    return EXIT_SUCCESS;
}