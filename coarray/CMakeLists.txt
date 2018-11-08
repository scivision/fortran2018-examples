cmake_minimum_required (VERSION 3.3)
project(coarraydemo Fortran)
enable_testing()
# ------- Fortran 2018 coarray examples -------
# Coarrays are easier to use than MPI and more general as an intrinsic part of Fortran 2008.

# Linux:  apt install libcoarrays-dev open-coarrays-bin
# Mac: brew install opencoarrays

if(${CMAKE_Fortran_COMPILER_ID} STREQUAL Intel)
    set(coflags -coarray=shared)
    set(OpenCoarrays_LIBRARIES -coarray=shared) 
elseif(${CMAKE_Fortran_COMPILER_ID} STREQUAL GNU AND ${CMAKE_Fortran_COMPILER_VERSION} VERSION_GREATER_EQUAL 7)

  find_package(OpenCoarrays)
  if(OpenCoarrays_FOUND)
    list(APPEND OpenCoarrays_LIBRARIES caf_mpi)
    set(coflags -fcoarray=lib)
  else()
    set(coflags -fcoarray=single)
  endif()
elseif(${CMAKE_Fortran_COMPILER_ID} STREQUAL Cray)
  # no flags needed, coarray enabled by default for Cray
else()
  return()
endif()


add_executable(coarray_hello helloworld.f90)
target_compile_options(coarray_hello PRIVATE ${FFLAGS} ${coflags})
target_link_libraries(coarray_hello ${OpenCoarrays_LIBRARIES})
add_test(NAME CoarrayHello COMMAND coarray_hello)


if(${CMAKE_Fortran_COMPILER_ID} STREQUAL Intel)
  add_executable(coarray_pi pi2008.f90)
elseif(${CMAKE_Fortran_COMPILER_ID} STREQUAL GNU)
# Intel 2018 does not yet support Fortran 2018 co_sum
  add_executable(coarray_pi pi.f90)
endif()
target_compile_options(coarray_pi PRIVATE ${FFLAGS} ${coflags})
target_link_libraries(coarray_pi ${OpenCoarrays_LIBRARIES})
add_test(NAME CoarrayPi COMMAND coarray_pi)

