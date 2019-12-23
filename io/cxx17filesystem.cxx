// snippet to test compilers for C++17 filesystem
#include <filesystem>
namespace fs = std::filesystem;

int main(void) {
fs::path p = fs::path(".");
return 0; }