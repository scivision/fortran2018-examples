cmake_minimum_required (VERSION 3.7)
project(fortran2018demo Fortran C)
enable_testing()

set(f2008 Cray GNU Intel NAG)

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


list(APPEND CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/cmake/Modules/)

include(cmake/compilers.cmake)

if(${CMAKE_Fortran_COMPILER_ID} STREQUAL GNU)
  add_subdirectory(hdf5)
  add_subdirectory(netcdf)
endif()

add_subdirectory(character)

add_subdirectory(real)

add_subdirectory(array)

add_subdirectory(cxx)

add_subdirectory(mpi)

add_subdirectory(coarray)

add_subdirectory(openmp)


add_executable(justwait replace_pause.f90)
target_compile_options(justwait PRIVATE ${FFLAGS})
#add_test(NAME FortranWait COMMAND justwait)

add_executable(termio terminal_io.f90)
target_compile_options(termio PRIVATE ${FFLAGS})
if(NOT WIN32) # FIXME doable via windows command
  add_test(NAME FortranTerminalIO COMMAND bash -c "./termio <<< 0")
endif()


add_executable(expanduser expanduser.f90)
target_compile_options(expanduser PRIVATE ${FFLAGS})

add_executable(notermsize noenv.f90)
target_compile_options(notermsize PRIVATE ${FFLAGS})
add_test(NAME NoTermSize COMMAND notermsize)

add_executable(polymorph polymorphic.f90)
target_compile_options(polymorph PRIVATE ${FFLAGS})
add_test(NAME FortranPolymorphic COMMAND polymorph)

add_executable(sleepstd sleep_std.f90)
target_compile_options(sleepstd PRIVATE ${FFLAGS})
add_test(NAME FortranMicrosleep COMMAND sleepstd)
set_tests_properties(FortranMicrosleep PROPERTIES TIMEOUT 1)


if(CMAKE_Fortran_COMPILER_ID IN_LIST f2008)

  add_executable(statement statement_function.f90)
  target_compile_options(statement PRIVATE ${FFLAGS})
  add_test(NAME Statement COMMAND statement)
  
  add_executable(randinit random_init.f90)
  target_compile_options(randinit PRIVATE ${FFLAGS})
  add_test(NAME RandomInit COMMAND randinit)

  add_executable(bitpat bitpat.f90)
  target_compile_options(bitpat PRIVATE ${FFLAGS})
  add_test(NAME FortranBitPattern COMMAND bitpat)

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
    
  add_executable(playsound play_sound.f90)

endif()

