cmake_minimum_required(VERSION 3.25...4.2)

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
include(CheckSourceRuns)

option(python "Fortran call Python demo")

# --- compiler checks

file(GLOB f2003features RELATIVE ${CMAKE_CURRENT_SOURCE_DIR}/cmake cmake/f03*.cmake)
file(GLOB f2008features RELATIVE ${CMAKE_CURRENT_SOURCE_DIR}/cmake cmake/f08*.cmake)
file(GLOB f2018features RELATIVE ${CMAKE_CURRENT_SOURCE_DIR}/cmake cmake/f18*.cmake)
file(GLOB f2023features RELATIVE ${CMAKE_CURRENT_SOURCE_DIR}/cmake cmake/f2023*.cmake)

foreach(i IN LISTS f2003features f2008features f2018features f2023features)
  include(cmake/${i})
endforeach()

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

include(cmake/features.cmake)
