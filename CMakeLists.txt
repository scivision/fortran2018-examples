cmake_minimum_required (VERSION 2.8.12)
project(fortran2015demo Fortran) 

add_subdirectory(hdf5)
add_subdirectory(mpi)
add_subdirectory(netcdf)
add_subdirectory(cxx)

if(${CMAKE_Fortran_COMPILER_ID} STREQUAL "Intel")
    set(FFLAGS ${FFLAGS} -Wall -Wextra -Wpedantic -Werror=array-bounds)
endif()

add_compile_options(-march=native -g ${FFLAGS})
# ------- testNaN.f90  NaN sentinel Fortran example ----------------
add_executable(nan testnan.f90)
# ------- null file example ------------
add_executable(null devnull.f90 perf.f90)
#---------- string example
add_executable(split split_string.f90)
# --------- test safe readonly file open --
add_executable(readonly fileopen-readonly.f90)

