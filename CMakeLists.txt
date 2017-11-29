cmake_minimum_required (VERSION 2.8.12)
project(fortran2018demo Fortran)

add_subdirectory(cxx)

if(${CMAKE_Fortran_COMPILER_ID} STREQUAL "Intel")
    set(FFLAGS ${FFLAGS} -check all)
else()
    add_executable(proc pragma.f90)
# if you've compiled these libraries with ifort, you can move them up to use with ifort
    add_subdirectory(hdf5)
    add_subdirectory(mpi)
    add_subdirectory(netcdf)
    set(FFLAGS ${FFLAGS} -march=native -Wall -Wextra -pedantic -Werror=array-bounds)
endif()

add_compile_options( -g ${FFLAGS})
#------------------------
set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${CMAKE_SOURCE_DIR}/cmake/Modules/")
# https://software.intel.com/en-us/articles/intel-mkl-link-line-advisor
find_package(MKL)
if(MKL_FOUND)
    set(MKLROOT $ENV{MKLROOT})
    include_directories(${MKL_INCLUDE_DIRS} ${MKLROOT}/include/intel64/lp64)

    set(FLIBS ${FLIBS} mkl_blas95_lp64 mkl_lapack95_lp64 mkl_gf_lp64 mkl_tbb_thread mkl_core tbb stdc++ pthread dl m)
endif()
# ------- testNaN.f90  NaN sentinel Fortran example ----------------
add_executable(nan testnan.f90)
# ------- null file example ------------
add_executable(null devnull.f90 perf.f90)
#---------- string example
add_executable(split split_string.f90)
# --------- test safe readonly file open --
add_executable(readonly fileopen-readonly.f90)
# -------- pause replacement
add_executable(justwait replace_pause.f90)

add_executable(overwrite_stdout overwrite_stdout.f90)
add_executable(bitpat bitpat.f90)
add_executable(charlen charlen.f90)
add_executable(termio terminal_io.f90)

# ------- SVD
if(${CMAKE_Fortran_COMPILER_ID} STREQUAL "Intel")
    add_executable(svd intel_gesvd.f90)
    target_link_libraries(svd ${FLIBS})
endif()
