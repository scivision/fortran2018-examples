cmake_minimum_required (VERSION 3.7)
project(FortranOpenMP Fortran)
enable_testing()

find_package(OpenMP)

if(${OpenMP_Fortran_FOUND})
  add_executable(timeprec timeprec.f90)
  target_compile_options(timeprec PRIVATE ${FFLAGS} ${OpenMP_Fortran_FLAGS})
  target_link_libraries(timeprec PRIVATE ${OpenMP_Fortran_LIBRARIES})
  add_test(NAME TimeMeasure COMMAND timeprec)
else()
  message(WARNING "Skipping OpenMP tesss")
endif()
