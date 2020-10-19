check_fortran_source_compiles("character :: x; error stop x; end" f18errorstop SRC_EXT f90)
if(NOT f18errorstop)
  message(FATAL_ERROR "Fortran 2018 error stop is used throughout.")
endif()
