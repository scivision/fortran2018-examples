cmake_minimum_required(VERSION 3.3)
project(C++linkexample CXX Fortran) 
enable_testing()

# This example demonstrates very basic linking of a user Fortran library called from C++ code.
# it's useful for checking if your Intel compiler is setup correctly as GCC has no problem with this.
#
# FC=ifort CC=icc CXX=icpc cmake ..
# make

# https://stackoverflow.com/tags/fortran-iso-c-binding/info

get_directory_property(hasParent PARENT_DIRECTORY)
if(NOT hasParent)
  include(../cmake/compilers.cmake)
endif()

if(CMAKE_Fortran_COMPILER_ID STREQUAL Intel)
  #  message(STATUS "be sure you have done '. compilervars.sh'")
  list(APPEND FLIBS svml imf intlc ifcoremt ifport)
endif()

add_library(mylibrary SHARED fun.f90)
target_link_libraries(mylibrary PRIVATE ${FLIBS})
target_compile_options(mylibrary PRIVATE ${FFLAGS})

add_executable(cxxfort cxxfort.cpp)
target_link_libraries(cxxfort PRIVATE mylibrary)
target_compile_options(cxxfort PRIVATE ${CFLAGS})
set_property(TARGET cxxfort PROPERTY CXX_STANDARD 11)
add_test(NAME C++Fortran COMMAND cxxfort)

# manually:
#
# source compilervars.sh
# ifort -c -nofor-main fun.f90  -lsvml -limf -lintlc -lifcoremt -lifport 
# icpc cxxfort.cpp fun.o -lsvml -limf -lintlc -lifcoremt -lifport -pthread
