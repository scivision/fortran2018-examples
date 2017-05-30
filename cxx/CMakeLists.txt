cmake_minimum_required (VERSION 2.8.12)
project(C++linkexample CXX Fortran) 

# This example demonstrates very basic linking of a user Fortran library called from C++ code.
# it's useful for checking if your Intel compiler is setup correctly as GCC has no problem with this.
#
# FC=ifort CC=icc CXX=icpc cmake ..
# make

# https://stackoverflow.com/tags/fortran-iso-c-binding/info

if(${CMAKE_Fortran_COMPILER_ID} STREQUAL "Intel")
    message(STATUS "be sure you have in your ~/.bashrc source compilervars.sh")
    set(IFORTLIBS svml imf intlc ifcoremt ifport)
endif()

add_library(mylibrary SHARED fun.f90)
target_link_libraries(mylibrary INTERFACE ${IFORTLIBS})

# add_executable(cxxfort cxxfort.cpp fun.f90) # could just do this

add_executable(cxxfort cxxfort.cpp)
target_link_libraries(cxxfort mylibrary)

# manually:
# ifort -c -nofor-main fun.f90  -lsvml -limf -lintlc -lifcoremt -lifport 
# icpc cxxfort.cpp fun.o -lsvml -limf -lintlc -lifcoremt -lifport -pthread
