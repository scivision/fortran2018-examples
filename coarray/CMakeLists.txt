cmake_minimum_required (VERSION 3.3)
project(coarraydemo Fortran)
enable_testing()
# ------- Fortran 2018 coarray examples -------
# Coarrays are easier to use than MPI and more general as an intrinsic part of Fortran 2008.

# Linux:  apt install libcoarrays-dev open-coarrays-bin
# Mac: brew install opencoarrays

if(CMAKE_Fortran_COMPILER_ID STREQUAL Intel)
    list(APPEND FFLAGS -coarray=shared)
    list(APPEND FLIBS -coarray=shared) 
elseif(CMAKE_Fortran_COMPILER_ID STREQUAL GNU)
  find_package(OpenCoarrays)
  if(OpenCoarrays_FOUND)
    list(APPEND FLIBS OpenCoarrays::caf_mpi)
  else()
    list(APPEND FFLAGS -fcoarray=single)
  endif()
elseif(CMAKE_Fortran_COMPILER_ID STREQUAL Cray)
  # no flags needed, coarray enabled by default for Cray
endif()

set(CMAKE_REQUIRED_FLAGS ${FFLAGS})
set(CMAKE_REQUIRED_LIBRARIES ${FLIBS})
include(CheckFortranSourceCompiles)
check_fortran_source_compiles("program cs; real :: x[*]; end" f2008coarray
                              SRC_EXT f90)

if(NOT f2008coarray)
  return()
endif()

check_fortran_source_compiles("program cs; real :: x[*]; call co_sum(x); end" f2018coarray
                              SRC_EXT f90)
                              

add_executable(coarray_hello helloworld.f90)
target_compile_options(coarray_hello PRIVATE ${FFLAGS})
target_link_libraries(coarray_hello ${FLIBS})
add_test(NAME CoarrayHello COMMAND coarray_hello)


if(f2018coarray)
  add_executable(coarray_pi pi.f90)
else()
# Intel 2018 does not yet support Fortran 2018 co_sum
  add_executable(coarray_pi pi2008.f90)
endif()
target_compile_options(coarray_pi PRIVATE ${FFLAGS})
target_link_libraries(coarray_pi ${FLIBS})
add_test(NAME CoarrayPi COMMAND coarray_pi)

