cmake_minimum_required(VERSION 3.7)
project(cmake Fortran)

if(CMAKE_VERSION VERSION_GREATER_EQUAL 3.14)
  include(CheckFortranSourceCompiles)
  check_fortran_source_compiles("program a; end program" FCOMP)
  message("compile: " ${FCOMP})

  include(CheckFortranSourceRuns)
  check_fortran_source_runs("program a; end program" FRUN)
  message("run: " ${FRUN})
endif()
