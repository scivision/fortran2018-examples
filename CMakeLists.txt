cmake_minimum_required(VERSION 3.19...3.23)

file(STRINGS ${CMAKE_CURRENT_SOURCE_DIR}/VERSION PROJECT_VERSION
  REGEX "^([0-9]+\.[0-9]+\.[0-9]+)" LIMIT_INPUT 16 LENGTH_MAXIMUM 16 LIMIT_COUNT 1)

project(Fortran2018Examples
  LANGUAGES C Fortran
  DESCRIPTION "Example of using modern Fortran syntax"
  VERSION ${PROJECT_VERSION})

enable_testing()

list(APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/cmake/Modules/)

set(CMAKE_EXPORT_COMPILE_COMMANDS on)

# ---

include(cmake/compilers.cmake)

add_subdirectory(array)
add_subdirectory(benchmarks)
add_subdirectory(block)
add_subdirectory(character)
add_subdirectory(compile)
add_subdirectory(contiguous)
add_subdirectory(git)
add_subdirectory(io)
add_subdirectory(debug)
add_subdirectory(maximum)
add_subdirectory(namelist)
# add_subdirectory(openacc)
add_subdirectory(openmp)
add_subdirectory(overloading)
add_subdirectory(pointer)
add_subdirectory(random)
add_subdirectory(real)
add_subdirectory(standard)
add_subdirectory(submodule)
add_subdirectory(system)

# --- summary
include(FeatureSummary)
add_feature_info(Openmp hasOMP "tests using OpenMP")

feature_summary(WHAT ENABLED_FEATURES)
