cmake_minimum_required(VERSION 3.7)
project(fortran2018demo Fortran C CXX)
enable_testing()

if(CMAKE_VERSION VERSION_GREATER_EQUAL 3.12)
  cmake_policy(SET CMP0074 NEW)
endif()

option(USE_MKL "Use Intel MKL" OFF)

list(APPEND CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/cmake/Modules/)

include(cmake/compilers.cmake)


add_subdirectory(array)
add_subdirectory(benchmarks)
add_subdirectory(character)
add_subdirectory(coarray)
add_subdirectory(contiguous)
add_subdirectory(cxx)
add_subdirectory(hdf5)
add_subdirectory(io)
add_subdirectory(lapack95)
add_subdirectory(mpi)
add_subdirectory(netcdf)
add_subdirectory(openmp)
add_subdirectory(overloading)
add_subdirectory(random)
add_subdirectory(real)
add_subdirectory(standard)
add_subdirectory(submodule)
add_subdirectory(system)

