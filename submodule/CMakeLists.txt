cmake_minimum_required(VERSION 3.12)
project(f2008submod Fortran)
enable_testing()

get_directory_property(hasParent PARENT_DIRECTORY)
if(NOT hasParent)
  include(../cmake/compilers.cmake)
endif()
                             
if(NOT f08submod)
  message(WARNING ${CMAKE_Fortran_COMPILER_ID} ${CMAKE_Fortran_COMPILER_VERSION} " does not support Fortran 2008 SUBMODULE")
  return()
endif()

add_executable(basic basic.f90 basic_sub.f90)
add_test(NAME BasicSubmod COMMAND basic)

add_executable(points_basic points_basic.f90 geo_basic.f90)
add_test(NAME BasicPoints COMMAND points_basic)

add_executable(new points.f90 geo.f90)
add_test(NAME PointsNew COMMAND new)

add_executable(old points.f90 geo_legacy.f90)
add_test(NAME PointsOld COMMAND old)
