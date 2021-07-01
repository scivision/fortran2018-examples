check_source_compiles(Fortran
"program test
character :: x
error stop x
end program"
f18errorstop)

if(NOT f18errorstop)
  message(FATAL_ERROR "Fortran 2018 error stop is used throughout.")
endif()
