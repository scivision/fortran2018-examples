cmake_minimum_required(VERSION 3.19)

file(STRINGS ${CMAKE_CURRENT_SOURCE_DIR}/VERSION PROJECT_VERSION
  REGEX "^([0-9]+\.[0-9]+\.[0-9]+)" LIMIT_INPUT 16 LENGTH_MAXIMUM 16 LIMIT_COUNT 1)

project(Fortran2018Examples
LANGUAGES C Fortran
DESCRIPTION "Example of using modern Fortran syntax"
VERSION ${PROJECT_VERSION})

enable_testing()

include(cmake/compilers.cmake)

add_subdirectory(src)
