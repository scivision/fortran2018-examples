cmake_minimum_required (VERSION 3.0)
project(fortran2018demo Fortran C)


if(realbits EQUAL 32)   # -Drealbits=32
  file(WRITE kind.txt "integer,parameter :: wp=real32")
  message(STATUS "real kind: real32")
elseif(realbits EQUAL 64)
  file(WRITE kind.txt "integer,parameter :: wp=real64")
  message(STATUS "real kind: real64")
elseif(realbits EQUAL 128)
  file(WRITE kind.txt "integer,parameter :: wp=real128")
  message(STATUS "real kind: real128")
else()
  file(WRITE kind.txt "integer,parameter :: wp=real64")
  message(STATUS "real kind: real64")
endif()

if(${CMAKE_Fortran_COMPILER_ID} STREQUAL Intel)
  list(APPEND FFLAGS -check all -traceback -warn -debug extended)
elseif(${CMAKE_Fortran_COMPILER_ID} STREQUAL GNU)
  list(APPEND FFLAGS -march=native -Wall -Wextra -Wpedantic -Werror=array-bounds -fbacktrace -fcheck=all)
# if you've compiled these libraries with ifort, you can move them up to use with ifort
    add_subdirectory(hdf5)
    add_subdirectory(netcdf)
endif()

add_compile_options(-O3 -g ${FFLAGS})
#------------------------
set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${CMAKE_SOURCE_DIR}/cmake/Modules/")
# https://software.intel.com/en-us/articles/intel-mkl-link-line-advisor
find_package(MKL)
if(MKL_FOUND)
    set(MKLROOT $ENV{MKLROOT})
    include_directories(${MKL_INCLUDE_DIRS} ${MKLROOT}/include/intel64/lp64)
    
    find_package(Threads REQUIRED)

    set(FLIBS ${FLIBS} mkl_blas95_lp64 mkl_lapack95_lp64 mkl_gf_lp64 mkl_tbb_thread mkl_core tbb stdc++ ${CMAKE_THREAD_LIBS_INIT} ${CMAKE_DL_LIBS} m)
endif()

add_subdirectory(cxx)
add_subdirectory(mpi)
add_subdirectory(coarray)
# ------- NaN sentinel Fortran example ----------------
add_executable(nan nans.f90)
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

add_executable(hugeprec huge_precision.f90)
add_executable(divprec div_precision.f90)
add_executable(floatprec floating_precision.f90)

add_executable(playsound play_sound.f90)
add_executable(precprob precision_problems.f90)
add_executable(polymorph polymorphic.f90)

add_library(assert assert.f90)
add_executable(proc pragma.f90)

add_executable(testassert Test.f90 fib3.f90)
target_link_libraries(testassert assert)

add_executable(sleepstd sleep_std.f90)

add_executable(gitrev gitrev.f90)

# ------- SVD
if(MKL_FOUND AND usemkl)
    add_executable(svd intel_gesvd.f90)
    target_link_libraries(svd ${FLIBS})
endif()

#---------------------------
enable_testing()
add_test(NAME FortranNaN COMMAND nan)
add_test(NAME Fortransplit COMMAND split)
add_test(NAME FortranHugePrecision COMMAND hugeprec)
add_test(NAME FortranAssert COMMAND testassert)
add_test(NAME FortranGit COMMAND gitrev)
add_test(NAME FortranMicrosleep COMMAND sleepstd)
add_test(NAME FortranGitRev COMMAND gitrev)
