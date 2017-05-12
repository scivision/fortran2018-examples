cmake_minimum_required (VERSION 3.2.2)
project(fortran2015demo Fortran) 

# if h5fc not found and you have Anaconda/Miniconda Python installed, try
# PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin cmake ..
add_subdirectory(hdf5)

add_subdirectory(mpi)

add_subdirectory(netcdf)

add_compile_options(-march=native -Wall -Wextra -Wpedantic -Werror=array-bounds -g)

# ------- testNaN.f90  NaN sentinel Fortran example ----------------
add_executable(nan testnan.f90)
# ------- null file example ------------
add_executable(null devnull.f90 perf.f90)
#---------- string example
add_executable(split split_string.f90)
# --------- test safe readonly file open --
add_executable(readonly fileopen-readonly.f90)

