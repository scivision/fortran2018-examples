cmake_minimum_required (VERSION 3.9)  # >= 3.9 for OpenMP components
project(Fortran2018OpenMP Fortran)
enable_testing()

get_directory_property(hasParent PARENT_DIRECTORY)
if(NOT hasParent)
  include(../cmake/compilers.cmake)
endif()

find_package(OpenMP COMPONENTS Fortran)

if(NOT OpenMP_Fortran_FOUND)
  return()
endif()

set(CMAKE_REQUIRED_FLAGS ${OpenMP_Fortran_FLAGS})
set(CMAKE_REQUIRED_LIBRARIES ${OpenMP_Fortran_LIBRARIES})
include(CheckFortranSourceCompiles)
check_fortran_source_compiles("program a; use omp_lib; end" hasOMP
                              SRC_EXT f90)
if(NOT hasOMP)
  return()
endif()

add_executable(timeprec timeprec.f90)
target_compile_options(timeprec PRIVATE ${FFLAGS} ${OpenMP_Fortran_FLAGS})
target_link_libraries(timeprec PRIVATE ${FLIBS} ${OpenMP_Fortran_LIBRARIES})
add_test(NAME TimeMeasure COMMAND timeprec)

