cmake_minimum_required(VERSION 3.15)  # implicit CMP0094

if(NOT CMAKE_BUILD_TYPE)
  set(CMAKE_BUILD_TYPE Release CACHE STRING "default build type")
endif()

project(Fortran2018Examples
LANGUAGES C Fortran
DESCRIPTION "Example of using modern Fortran syntax"
VERSION 1.2.3)

enable_testing()

set(CTEST_TEST_TIMEOUT 10)  # default timeout [seconds]

list(APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/cmake/Modules/)

include(CheckLanguage)
check_language(CXX)
if(CMAKE_CXX_COMPILER)
  enable_language(CXX)
  include(CheckCXXSourceRuns)
endif()

include(cmake/compilers.cmake)

add_subdirectory(array)
add_subdirectory(benchmarks)
add_subdirectory(block)
add_subdirectory(character)
add_subdirectory(coarray)
add_subdirectory(contiguous)
if(CMAKE_CXX_COMPILER)
  add_subdirectory(io)
  add_subdirectory(cxx)
endif()
add_subdirectory(debug)
add_subdirectory(lapack95)
add_subdirectory(mpi)
add_subdirectory(namelist)
# add_subdirectory(openacc)
add_subdirectory(openmp)
add_subdirectory(overloading)
add_subdirectory(random)
add_subdirectory(real)
add_subdirectory(standard)
add_subdirectory(submodule)
add_subdirectory(system)



include(FeatureSummary)
add_feature_info(cxx_fs cxx17filesystem_ok "tests using C++17 filesystem")
add_feature_info(Openmp hasOMP "tests using OpenMP")
add_feature_info(mpi hasMPI "tests using MPI")

feature_summary(WHAT ALL)