cmake_minimum_required (VERSION 3.7)
project(fortran2018demo Fortran C)
enable_testing()

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


if(CMAKE_BUILD_TYPE STREQUAL Debug)
  add_compile_options(-g -O0)
else()
  add_compile_options(-O3)
endif()

if(${CMAKE_Fortran_COMPILER_ID} STREQUAL Intel)
  set(FFLAGS -check all -traceback -warn -debug extended)
elseif(${CMAKE_Fortran_COMPILER_ID} STREQUAL GNU)
  if(${CMAKE_Fortran_COMPILER_VERSION} VERSION_GREATER_EQUAL 8.1)
    set(FFLAGS -std=f2018)
  else()
    set(FFLAGS -std=f2008ts)
  endif()
  list(APPEND FFLAGS -march=native -Wall -Wextra -Wpedantic -Werror=array-bounds -fbacktrace -fcheck=all)
# if you've compiled these libraries with ifort, you can move them up to use with ifort
    add_subdirectory(hdf5)
    add_subdirectory(netcdf)
elseif(${CMAKE_Fortran_COMPILER_ID} STREQUAL PGI)
  set(FFLAGS -Mallocatable=03)
elseif(${CMAKE_Fortran_COMPILER_ID} STREQUAL Flang) 
  add_compile_options(-Mallocatable=03)
  link_libraries(-static-flang-libs)
  set(CFLAGS -W)
endif()

#------------------------
list(APPEND CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/cmake/Modules/)
# https://software.intel.com/en-us/articles/intel-mkl-link-line-advisor
find_package(MKL)
if(MKL_FOUND)
    set(MKLROOT $ENV{MKLROOT})
    include_directories(${MKL_INCLUDE_DIRS} ${MKLROOT}/include/intel64/lp64)
    
    find_package(Threads REQUIRED)

    set(FLIBS mkl_blas95_lp64 mkl_lapack95_lp64 mkl_gf_lp64 mkl_tbb_thread mkl_core tbb stdc++ ${CMAKE_THREAD_LIBS_INIT} ${CMAKE_DL_LIBS} m)
endif()

add_subdirectory(cxx)

add_subdirectory(mpi)

add_subdirectory(coarray)

# ------- NaN sentinel Fortran example ----------------
add_executable(nan nans.f90)
target_compile_options(nan PRIVATE ${FFLAGS})
add_test(NAME FortranNaN COMMAND nan)

add_executable(split split_string.f90)
target_compile_options(split PRIVATE ${FFLAGS})
add_test(NAME Fortransplit COMMAND split)

add_executable(justwait replace_pause.f90)
target_compile_options(justwait PRIVATE ${FFLAGS})
#add_test(NAME FortranWait COMMAND justwait)

add_executable(termio terminal_io.f90)
target_compile_options(termio PRIVATE ${FFLAGS})
if(NOT WIN32) # FIXME doable via windows command
  add_test(NAME FortranTerminalIO COMMAND bash -c "./termio <<< 0")
endif()

add_executable(precprob precision_problems.f90)
target_compile_options(precprob PRIVATE ${FFLAGS})
add_test(NAME FortranPrecision COMMAND precprob)

add_executable(polymorph polymorphic.f90)
target_compile_options(polymorph PRIVATE ${FFLAGS})
add_test(NAME FortranPolymorphic COMMAND polymorph)

add_executable(sleepstd sleep_std.f90)
target_compile_options(sleepstd PRIVATE ${FFLAGS})
add_test(NAME FortranMicrosleep COMMAND sleepstd)
set_tests_properties(FortranMicrosleep PROPERTIES TIMEOUT 1)

set(okcomp GNU Intel)
if(CMAKE_Fortran_COMPILER_ID IN_LIST okcomp)
  add_executable(bitpat bitpat.f90)
  target_compile_options(bitpat PRIVATE ${FFLAGS})
  add_test(NAME FortranBitPattern COMMAND bitpat)

  add_executable(hugeprec huge_precision.f90)
  target_compile_options(hugeprec PRIVATE ${FFLAGS})
  add_test(NAME FortranHugePrecision COMMAND hugeprec)

  add_executable(divprec div_precision.f90)
  target_compile_options(divprec PRIVATE ${FFLAGS})
  add_test(NAME FortranDivisionPrecision COMMAND divprec)
  
  add_executable(floatprec floating_precision.f90)
  target_compile_options(floatprec PRIVATE ${FFLAGS})
  add_test(NAME FortranFloatPrecision COMMAND floatprec)
  
  
  add_executable(charlen charlen.f90)
  target_compile_options(charlen PRIVATE ${FFLAGS})
  add_test(NAME FortranCharacterLen COMMAND charlen)

  add_executable(readonly fileopen-readonly.f90)
  target_compile_options(readonly PRIVATE ${FFLAGS})
  add_test(NAME FortranReadOnly COMMAND readonly)

  add_executable(null devnull.f90 perf.f90)
  target_compile_options(null PRIVATE ${FFLAGS})
  add_test(NAME FortranNullfile COMMAND null)

  add_executable(gitrev gitrev.f90)
  target_compile_options(gitrev PRIVATE ${FFLAGS})
  add_test(NAME FortranGit COMMAND gitrev)

  add_executable(proc pragma.f90)
  target_compile_options(proc PRIVATE ${FFLAGS})
  add_test(NAME FortranPragma COMMAND proc)
    
  add_library(assert assert.f90)
  add_executable(testassert Test.f90 fib3.f90)
  target_link_libraries(testassert assert)
  target_compile_options(testassert PRIVATE ${FFLAGS})
  add_test(NAME FortranAssert COMMAND testassert)
  
  add_executable(playsound play_sound.f90)

endif()


# ------- SVD
if(MKL_FOUND AND usemkl)
    add_executable(svd intel_gesvd.f90)
    target_link_libraries(svd ${FLIBS})
    target_compile_options(svd PRIVATE ${FFLAGS})
    add_test(NAME FortranSVD COMMAND svd)
endif()

add_executable(overwrite_stdout overwrite_stdout.f90)
target_compile_options(overwrite_stdout PRIVATE ${FFLAGS} -fall-intrinsics)
add_test(NAME FortranOverwriteStdout COMMAND overwrite_stdout)
set_tests_properties(FortranOverwriteStdout PROPERTIES TIMEOUT 6)


