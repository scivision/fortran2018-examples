cmake_minimum_required(VERSION 3.3)
if(NOT CMAKE_BUILD_TYPE)
  set(CMAKE_BUILD_TYPE Release CACHE STRING "Debug or Release")
endif()
project(C++linkexample C Fortran)
enable_testing()

# This example demonstrates very basic linking of
# * Fortran call from C++
# * C call from Fortran
#
# FC=ifort CC=icc CXX=icpc cmake ..
# make

# https://stackoverflow.com/tags/fortran-iso-c-binding/info

get_directory_property(hasParent PARENT_DIRECTORY)
if(NOT hasParent)
  include(${CMAKE_CURRENT_SOURCE_DIR}/../cmake/compilers.cmake)
endif()

if(CMAKE_Fortran_COMPILER_ID STREQUAL Intel)
  if(NOT WIN32)
    list(APPEND FLIBS svml imf intlc ifcoremt ifport)  # FIXME: all all these needed on Linux?
  endif()
endif()

add_library(call_c call_c.c)
target_compile_options(call_c PRIVATE ${CFLAGS})

add_executable(f_call_c f_call_c.f90)
target_link_libraries(f_call_c PRIVATE call_c ${FLIBS})
target_compile_options(f_call_c PRIVATE ${FFLAGS})
add_test(NAME Fortran2C COMMAND f_call_c)

# Workaround for PGI not having CXX on Windows and wrong CXX compiler being found
if(WIN32 AND CMAKE_C_COMPILER_ID STREQUAL PGI)
  message(STATUS "PGI on Windows does not currently have a CXX compiler")
  return()
endif()

include(CheckLanguage)
check_language(CXX)
if(CMAKE_CXX_COMPILER)
enable_language(CXX)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

add_library(call_f c_call_f.f90)
target_link_libraries(call_f PRIVATE ${FLIBS})
target_compile_options(call_f PRIVATE ${FFLAGS})
set_target_properties(call_f PROPERTIES POSITION_INDEPENDENT_CODE ON)

# LD_LIBRARY_PATH=~/.local/pgi/linux86-64/2018/lib:$LD_LIBRARY_PATH ./cxx_call_f
add_executable(cxx_call_f cxx_call_f.cxx)
target_link_libraries(cxx_call_f PRIVATE call_f)
target_compile_options(cxx_call_f PRIVATE ${CFLAGS})
set_target_properties(cxx_call_f PROPERTIES CXX_STANDARD 11)
add_test(NAME CXX2Fortran COMMAND cxx_call_f)

endif()

# manually:
#
# source compilervars.sh
# ifort -c -nofor-main fun.f90  -lsvml -limf -lintlc -lifcoremt -lifport
# icpc cxx_call_f.cpp fun.o -lsvml -limf -lintlc -lifcoremt -lifport -pthread
