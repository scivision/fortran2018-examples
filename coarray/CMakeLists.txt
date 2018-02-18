cmake_minimum_required (VERSION 2.8.12)
project(coarraydemo Fortran)

# ------- Fortran 2018 coarray examples -------
# Coarrays are easier to use than MPI and more general as an intrinsic part of Fortran 2008.

# Linux:  apt install libcoarrays-dev open-coarrays-bin
# Mac: brew install opencoarrays

if(${CMAKE_Fortran_COMPILER_ID} STREQUAL Intel)
    add_compile_options(-coarray)
elseif(${CMAKE_Fortran_COMPILER_ID} STREQUAL GNU)
    add_compile_options(-fcoarray=lib)
endif()

add_executable(hello helloworld.f90)
add_executable(pi pi.f90)
add_executable(iter iter.f90)



# make VERBOSE=1
#
#/usr/bin/f95  -I/usr/lib/openmpi/include -I/usr/lib/openmpi/lib  -Wl,-rpath,/usr/lib/openmpi/lib /usr/lib/openmpi/lib/libmpi_usempif08.so /usr/lib/openmpi/lib/libmpi_usempi_ignore_tkr.so /usr/lib/openmpi/lib/libmpi_mpifh.so /usr/lib/openmpi/lib/libmpi.so

