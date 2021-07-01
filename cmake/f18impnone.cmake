check_source_compiles(Fortran
"program test
implicit none (type, external)
end program"
f2018impnone)

if(NOT f2018impnone)
  message(FATAL_ERROR "does not support Fortran 2018 IMPLICIT NONE (type, external): ${CMAKE_Fortran_COMPILER_ID} ${CMAKE_Fortran_COMPILER_VERSION}")
endif()
