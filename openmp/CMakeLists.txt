cmake_minimum_required(VERSION 3.14)
project(OpenMP_Fortran
LANGUAGES Fortran)
enable_testing()

find_package(OpenMP COMPONENTS Fortran)

include(CheckFortranSourceCompiles)
set(CMAKE_REQUIRED_FLAGS ${OpenMP_Fortran_FLAGS})
set(CMAKE_REQUIRED_INCLUDES ${OpenMP_Fortran_INCLUDE_DIRS})
set(CMAKE_REQUIRED_LIBRARIES ${OpenMP_Fortran_LIBRARIES})
check_fortran_source_compiles("use, intrinsic:: iso_fortran_env, only: dp=>real64, int64
implicit none (type, external)
integer(int64), external :: omp_get_wtick
integer(int64) :: rate
rate = omp_get_wtick()
end program" hasOMP SRC_EXT f90)

if(NOT hasOMP)
  return()
endif()

add_executable(timeprec timeprec.f90)
target_link_libraries(timeprec PRIVATE OpenMP::OpenMP_Fortran)
add_test(NAME "OpenMP:TimeMeasure" COMMAND timeprec)
set_tests_properties(OpenMP:TimeMeasure PROPERTIES RUN_SERIAL true)
