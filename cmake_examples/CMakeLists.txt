if(CMAKE_VERSION VERSION_GREATER_EQUAL 3.14)
  include(CheckFortranSourceCompiles)
  check_fortran_source_compiles("end program" FCOMP SRC_EXT F90)

  include(CheckFortranSourceRuns)
  check_fortran_source_runs("end program" FRUN)
endif()
