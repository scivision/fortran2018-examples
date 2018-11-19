cmake_minimum_required (VERSION 3.7)
project(fortran2018demo Fortran C CXX)
enable_testing()

option(realbits "number of bits to use for real values" 64)

if(realbits EQUAL 32)   # -Drealbits=32
  file(WRITE kind.txt "integer,parameter :: wp=real32")
  message(STATUS "real kind: real32")
elseif(realbits EQUAL 64)
  file(WRITE kind.txt "integer,parameter :: wp=real64")
  message(STATUS "real kind: real64")
elseif(realbits EQUAL 128)
  file(WRITE kind.txt "integer,parameter :: wp=real128")
  message(STATUS "real kind: real128")
endif()

option(USE_MKL "Use Intel MKL" OFF)

list(APPEND CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/cmake/Modules/)

include(cmake/compilers.cmake)

if(${CMAKE_Fortran_COMPILER_ID} STREQUAL GNU)
  add_subdirectory(hdf5)
  add_subdirectory(netcdf)
endif()

add_subdirectory(character)

add_subdirectory(io)

add_subdirectory(real)

add_subdirectory(array)

add_subdirectory(cxx)

add_subdirectory(mpi)

add_subdirectory(coarray)

add_subdirectory(openmp)


add_executable(justwait replace_pause.f90)
target_compile_options(justwait PRIVATE ${FFLAGS})
#add_test(NAME FortranWait COMMAND justwait)

add_executable(polymorph polymorphic.f90)
target_compile_options(polymorph PRIVATE ${FFLAGS})
add_test(NAME FortranPolymorphic COMMAND polymorph)

add_executable(sleepstd sleep_std.f90)
target_compile_options(sleepstd PRIVATE ${FFLAGS})
add_test(NAME FortranMicrosleep COMMAND sleepstd)
set_tests_properties(FortranMicrosleep PROPERTIES TIMEOUT 1)


if(f2008)

  add_executable(statement statement_function.f90)
  target_compile_options(statement PRIVATE ${FFLAGS})
  add_test(NAME Statement COMMAND statement)
  
  add_executable(randinit random_init.f90)
  target_compile_options(randinit PRIVATE ${FFLAGS})
  add_test(NAME RandomInit COMMAND randinit)

  add_executable(bitpat bitpat.f90)
  target_compile_options(bitpat PRIVATE ${FFLAGS})
  add_test(NAME FortranBitPattern COMMAND bitpat)



  add_executable(gitrev gitrev.f90)
  target_compile_options(gitrev PRIVATE ${FFLAGS})
  add_test(NAME FortranGit COMMAND gitrev)

  add_executable(proc pragma.f90)
  target_compile_options(proc PRIVATE ${FFLAGS})
  add_test(NAME FortranPragma COMMAND proc)
    
  add_executable(playsound play_sound.f90)

endif()

