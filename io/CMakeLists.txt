cmake_minimum_required(VERSION 3.14)
project(fortran2018io C Fortran)
enable_testing()

add_library(logging logging.f90)

if(CMAKE_Fortran_COMPILER_ID STREQUAL PGI)
  message(STATUS "PGI doesn't work correctly for this append_file example, even alone")
else()
  add_executable(append_file append_file.f90)
  target_link_libraries(append_file PRIVATE logging)
  add_test(NAME io:appendFile COMMAND append_file)
endif()

add_executable(termio terminal_io.f90)
if(NOT WIN32)
  add_test(NAME io:terminal COMMAND bash -c "$<TARGET_FILE:termio> <<< 0")
endif()

add_executable(leading_zeros leading_zeros.f90)
add_test(NAME io:leading_zeros COMMAND leading_zeros)
set_tests_properties(io:leading_zeros PROPERTIES
  PASS_REGULAR_EXPRESSION "hello1234.5600000")

add_executable(notermsize noenv.f90)
add_test(NAME io:NoTermSize COMMAND notermsize)

add_executable(readonly fileopen-readonly.f90)
add_test(NAME io:ReadOnly COMMAND readonly)

add_executable(null devnull.f90)
add_test(NAME io:nullfile COMMAND null)

add_library(pathlib pathlib.F90)
add_executable(test_pathlib test_pathlib.f90)
target_link_libraries(test_pathlib pathlib)
add_test(NAME io:pathlib COMMAND $<TARGET_FILE:test_pathlib>)


include(CheckCSourceRuns)
if(NOT APPLE)  # FIXME: need to make check in Fortran not C.
# has to be run() test for detecting defective system realpath()
if(WIN32)
  set(_code "
#include <stdlib.h>
#include <string.h>
int main(void) {
char resolved_path[_MAX_PATH];
_fullpath(resolved_path, \"..\", _MAX_PATH);
if(strcmp(\"..\", resolved_path) == 0 || strcmp(\".\", resolved_path) == 0) return 1;
return 0; }")
check_c_source_runs("${_code}" windowsio_OK)
  set(posixio_OK false)
else()
  set(_code "
#include <limits.h>
#include <stdlib.h>
#include <string.h>
int main(void) {
char resolved_path[PATH_MAX];
realpath(\"..\", resolved_path);
if(strcmp(\"..\", resolved_path) == 0 || strcmp(\".\", resolved_path) == 0) return 1;
return 0; }")
  check_c_source_runs("${_code}" posixio_OK)
  set(windowsio_OK false)
endif()

if(posixio_OK)
  add_executable(realpath realpath_posix.f90)
elseif(windowsio_OK)
  add_executable(realpath fullpath_windows.f90)
endif()
if(posixio_OK OR windowsio_OK)
  add_test(NAME io:canonical COMMAND $<TARGET_FILE:realpath>)
  set_tests_properties(io:canonical PROPERTIES SKIP_RETURN_CODE 77)
endif()
endif(NOT APPLE)


# C++ is goofed up for PGI on Windows, including with CL
if(WIN32 AND CMAKE_Fortran_COMPILER_ID STREQUAL PGI)
  message(STATUS "PGI does not have a C++ compiler on Windows")
  return()
endif()

include(CheckLanguage)
check_language(CXX)
if(CMAKE_CXX_COMPILER)
  enable_language(CXX)
else()
  return()
endif()

include(CheckCXXSourceRuns)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# verify C++ compiler can do C++17 filesystem
# GCC 10, Intel 2020
file(READ cxx17filesystem.cxx _code)
set(CMAKE_REQUIRED_FLAGS -std=c++17)
check_cxx_source_runs("${_code}" cxx17filesystem_ok)

if(NOT cxx17filesystem_ok)
  message(STATUS "${CMAKE_CXX_COMPILER_ID} ${CMAKE_CXX_COMPILER_VERSION} does not support C++17 filesystem")
  return()
endif()

add_library(canonical_cxx canonical.cxx)
set_target_properties(canonical_cxx PROPERTIES CXX_STANDARD 17)

# NOTE: icl canonical.cxx canonical_demo.cxx works, so this must be a CMake bug.
#  LNK2019: unresolved external symbol wmemcmp referenced in function "public: static int __cdecl std::_WChar_traits<wchar_t>::compare
if(WIN32 AND CMAKE_CXX_COMPILER_ID STREQUAL Intel)
  message(STATUS "CMake has a bug with Intel 2020 linking c++17")
else()
  add_executable(canonical_demo canonical_demo.cxx)
  target_link_libraries(canonical_demo PRIVATE canonical_cxx)
  set_target_properties(canonical_demo PROPERTIES CXX_STANDARD 17)
  add_test(NAME CanonicalC++ COMMAND canonical_demo)

  add_executable(realpath_fortran_cxx17 realpath_cxx.f90)
  target_link_libraries(realpath_fortran_cxx17 PRIVATE canonical_cxx)
endif()
