cmake_minimum_required (VERSION 3.9)  # >= 3.9 for OpenMP components
project(Fortran2018OpenMP Fortran)
enable_testing()

get_directory_property(hasParent PARENT_DIRECTORY)
if(NOT hasParent)
  include(../cmake/compilers.cmake)
endif()

find_package(OpenMP COMPONENTS Fortran)

set(CMAKE_REQUIRED_FLAGS ${OpenMP_Fortran_FLAGS})
set(CMAKE_REQUIRED_LIBRARIES ${OpenMP_Fortran_LIBRARIES})
include(CheckFortranSourceCompiles)
check_fortran_source_compiles("use omp_lib; rate = omp_get_wtick(); end" hasOMP SRC_EXT f90)
if(NOT hasOMP)
  return()
endif()

add_executable(timeprec timeprec.f90)
target_compile_options(timeprec PRIVATE ${FFLAGS})
target_link_libraries(timeprec PRIVATE OpenMP::OpenMP_Fortran)
add_test(NAME TimeMeasure COMMAND timeprec)

