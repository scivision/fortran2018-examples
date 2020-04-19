find_package(OpenMP COMPONENTS Fortran)

set(CMAKE_REQUIRED_FLAGS ${OpenMP_Fortran_FLAGS})
set(CMAKE_REQUIRED_LIBRARIES ${OpenMP_Fortran_LIBRARIES})
check_fortran_source_compiles("use omp_lib; rate = omp_get_wtick(); end" hasOMP SRC_EXT f90)

if(NOT hasOMP)
  return()
endif()

add_executable(timeprec timeprec.f90)
target_link_libraries(timeprec PRIVATE OpenMP::OpenMP_Fortran)
add_test(NAME "OpenMP:TimeMeasure" COMMAND timeprec)
set_tests_properties(OpenMP:TimeMeasure PROPERTIES RUN_SERIAL true)
