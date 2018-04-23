cmake_minimum_required (VERSION 3.0)
project(coarraydemo Fortran)
enable_testing()
# ------- Fortran 2018 coarray examples -------
# Coarrays are easier to use than MPI and more general as an intrinsic part of Fortran 2008.

# Linux:  apt install libcoarrays-dev open-coarrays-bin
# Mac: brew install opencoarrays

if(${CMAKE_Fortran_COMPILER_ID} STREQUAL Intel)
    add_compile_options(-coarray=shared)
    link_libraries(-coarray=shared) # seems silly but that's what's needed at object code step for ifort
elseif(${CMAKE_Fortran_COMPILER_ID} STREQUAL GNU)

  find_package(OpenCoarrays)
  if(OpenCoarrays_FOUND)
    list(APPEND OpenCoarrays_LIBRARIES caf_mpi)
    add_compile_options(-fcoarray=lib)
  else()
    add_compile_options(-fcoarray=single)
  endif()
endif()


add_executable(coarray_hello helloworld.f90)
target_link_libraries(coarray_hello ${OpenCoarrays_LIBRARIES})

if(${CMAKE_Fortran_COMPILER_ID} STREQUAL Intel)
  add_executable(coarray_pi pi2008.f90)
elseif(${CMAKE_Fortran_COMPILER_ID} STREQUAL GNU)
# Intel 2018 does not yet support Fortran 2018 co_sum
  add_executable(coarray_pi pi.f90)
endif()
target_link_libraries(coarray_pi ${OpenCoarrays_LIBRARIES})


add_test(NAME CoarrayHello COMMAND coarray_hello)
add_test(NAME CoarrayPi COMMAND coarray_pi)

