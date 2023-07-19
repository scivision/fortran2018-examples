cmake_minimum_required(VERSION 3.19...3.27)

if(CMAKE_SOURCE_DIR STREQUAL CMAKE_BINARY_DIR)
  message(FATAL_ERROR "Please specify build directory like:
  cmake -B build")
endif()

project(Fortran2018Examples
LANGUAGES Fortran
DESCRIPTION "Example of using modern Fortran syntax"
VERSION 1.4.0)

enable_testing()

include(cmake/compilers.cmake)

set(CMAKE_Fortran_MODULE_DIRECTORY ${PROJECT_BINARY_DIR}/include)
# for ease of use

foreach(a IN ITEMS array character compile debug do_concurrent io maximum namelist
  openacc openmp overloading pointer real standard submodule)
  add_subdirectory(test/${a})
endforeach()

foreach(a IN ITEMS git system)
  add_subdirectory(src/${a})
endforeach()

file(GENERATE OUTPUT .gitignore CONTENT "*")
