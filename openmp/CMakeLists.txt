cmake_minimum_required(VERSION 3.19...3.22)
project(OpenMP_Fortran
LANGUAGES Fortran)

enable_testing()

find_package(OpenMP COMPONENTS Fortran)

include(CheckSourceCompiles)
set(CMAKE_REQUIRED_FLAGS ${OpenMP_Fortran_FLAGS})
set(CMAKE_REQUIRED_INCLUDES ${OpenMP_Fortran_INCLUDE_DIRS})
set(CMAKE_REQUIRED_LIBRARIES ${OpenMP_Fortran_LIBRARIES})

check_source_compiles(Fortran
"program test
use, intrinsic:: iso_fortran_env, only: dp=>real64, int64
implicit none (type, external)
integer(int64), external :: omp_get_wtick
integer(int64) :: rate
rate = omp_get_wtick()
end program"
hasOMP)


set_directory_properties(PROPERTIES LABELS openmp)

add_executable(timeprec timeprec.f90)
set_target_properties(timeprec PROPERTIES EXCLUDE_FROM_ALL $<NOT:${hasOMP}>)
target_link_libraries(timeprec PRIVATE OpenMP::OpenMP_Fortran)

add_test(NAME OpenMP:TimeMeasure COMMAND timeprec)
set_tests_properties(OpenMP:TimeMeasure PROPERTIES DISABLED $<NOT:${hasOMP}>)
