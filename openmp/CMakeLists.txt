cmake_minimum_required (VERSION 3.9)  # >= 3.9 for OpenMP components
project(Fortran2018OpenMP Fortran)
enable_testing()

find_package(OpenMP COMPONENTS Fortran)

if(OpenMP_Fortran_FOUND)
  add_executable(timeprec timeprec.f90)
  target_compile_options(timeprec PRIVATE ${FFLAGS} ${OpenMP_Fortran_FLAGS})
  target_link_libraries(timeprec PRIVATE ${OpenMP_Fortran_LIBRARIES})
  add_test(NAME TimeMeasure COMMAND timeprec)
endif()
