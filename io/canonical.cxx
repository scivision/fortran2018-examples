// MSVC 2017 or newer:
// cl /std:c++17 /EHsc canonical.cxx

// Clang >= 9  or  g++ >= 8
// clang++ -std=c++17 canonical.cxx

// Intel compiler does not yet support as of version 19.0
// https://software.intel.com/en-us/articles/c17-features-supported-by-intel-c-compiler

#include <filesystem>
#include <string>
#include <cstring>

namespace fs = std::filesystem;

void expanduser(char *pathstr){
// does not handle ~username/foo

if(pathstr[0] != '~')
  return;

std::string s;
#ifdef _WIN32
s = std::getenv("USERPROFILE");
#else
s = std::getenv("HOME");
#endif

std::string r = pathstr;
r.erase(r.begin());

if (!s.empty()){
  s += r;
  std::strcpy(pathstr, s.c_str());
}
}


extern "C" void canonical(char *pathstr){
// does NOT expand tilde ~
fs::path p = fs::path(pathstr);
// get absolute canonical path from relative path
p = fs::canonical(p);
// const char* to char*
std::strcpy(pathstr, p.string().c_str());
}
