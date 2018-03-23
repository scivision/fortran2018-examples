cmake_minimum_required (VERSION 3.0)
project(C++linkexample CXX Fortran) 

# This example demonstrates very basic linking of a user Fortran library called from C++ code.
# it's useful for checking if your Intel compiler is setup correctly as GCC has no problem with this.
#
# FC=ifort CC=icc CXX=icpc cmake ..
# make

# https://stackoverflow.com/tags/fortran-iso-c-binding/info

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

if(${CMAKE_Fortran_COMPILER_ID} STREQUAL Intel)
    message(STATUS "be sure you have in your ~/.bashrc source compilervars.sh")
    list(APPEND FLIBS svml imf intlc ifcoremt ifport)
endif()

add_library(mylibrary SHARED fun.f90)
target_link_libraries(mylibrary INTERFACE ${FLIBS})

# add_executable(cxxfort cxxfort.cpp fun.f90) # could just do this

add_executable(cxxfort cxxfort.cpp)
target_link_libraries(cxxfort mylibrary)

enable_testing()

add_test(NAME C++Fortran COMMAND cxxfort)

# manually:
#
# source compilervars.sh
# ifort -c -nofor-main fun.f90  -lsvml -limf -lintlc -lifcoremt -lifport 
# icpc cxxfort.cpp fun.o -lsvml -limf -lintlc -lifcoremt -lifport -pthread
