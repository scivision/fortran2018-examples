cmake_minimum_required (VERSION 2.8.12)
project(coarraydemo Fortran)

# ------- Fortran 2018 coarray examples -------
# Coarrays are easier to use than MPI and more general as an intrinsic part of Fortran 2008.

# Linux:  apt install libcoarrays-dev open-coarrays-bin
# Mac: brew install opencoarrays

if(${CMAKE_Fortran_COMPILER_ID} STREQUAL Intel)
    add_compile_options(-coarray=shared)
elseif(${CMAKE_Fortran_COMPILER_ID} STREQUAL GNU)
    add_compile_options(-fcoarray=lib)
    set(FCAF ${FCAF} caf_mpi)
endif()


add_executable(coarray_hello helloworld.f90)
target_link_libraries(coarray_hello ${FCAF})

if(${CMAKE_Fortran_COMPILER_ID} STREQUAL GNU)
# Intel 2018 does not yet support Fortran 2018 co_sum
    add_executable(coarray_pi pi.f90)
    target_link_libraries(coarray_pi assert ${FCAF})
endif()

