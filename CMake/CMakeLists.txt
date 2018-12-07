cmake_minimum_required(VERSION 3.1)
project(cmake Fortran)

include(CheckFortranSourceCompiles)
check_fortran_source_compiles("program a; end program" FCOMP SRC_EXT F90)
message("compile: " ${FCOMP})

if(CMAKE_VERSION VERSION_GREATER_EQUAL 3.14)
  include(CheckFortranSourceRuns)
  check_fortran_source_runs("program a; end program" FRUN SRC_EXT F90)
  message("run: " ${FRUN})
endif()
