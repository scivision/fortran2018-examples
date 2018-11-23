cmake_minimum_required(VERSION 3.12)
project(f2008submod Fortran)
enable_testing()

get_directory_property(hasParent PARENT_DIRECTORY)
if(NOT hasParent)
  include(../cmake/compilers.cmake)
endif()

file(READ minimal.f90 mincode)
include(CheckFortranSourceCompiles)
check_fortran_source_compiles(${mincode} f2008submod
                              SRC_EXT f90)
                              
if(NOT f2008submod)
  return()
endif()


add_executable(new points.f90 geo.f90)

add_executable(old points.f90 geo_legacy.f90)
