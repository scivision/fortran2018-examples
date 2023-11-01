cmake_minimum_required(VERSION 3.19...3.28)

if(CMAKE_SOURCE_DIR STREQUAL CMAKE_BINARY_DIR)
  message(FATAL_ERROR "Please specify build directory like:
  cmake -B build")
endif()

project(Fortran2018Examples
LANGUAGES Fortran
DESCRIPTION "Example of using modern Fortran syntax"
VERSION 1.4.0)

enable_testing()

include(CheckSourceCompiles)

# --- compiler checks

include(cmake/f18abstract.cmake)
include(cmake/f08contig.cmake)
include(cmake/f18random.cmake)
include(cmake/f18assumed_rank.cmake)
include(cmake/f08kind.cmake)
include(cmake/f18prop.cmake)
include(cmake/f03utf8.cmake)
include(cmake/f03ieee.cmake)
include(cmake/f2Xrank_integer.cmake)
include(cmake/f2Xternary.cmake)
include(cmake/f2Xtokenize.cmake)
include(cmake/f2Xreal16.cmake)

include(cmake/compilers.cmake)

set(CMAKE_Fortran_MODULE_DIRECTORY ${PROJECT_BINARY_DIR}/include)
# for ease of use

foreach(a IN ITEMS array character compile debug io maximum namelist
         overloading pointer real standard submodule)
  add_subdirectory(test/${a})
endforeach()

foreach(a IN ITEMS git system)
  add_subdirectory(src/${a})
endforeach()

file(GENERATE OUTPUT .gitignore CONTENT "*")
