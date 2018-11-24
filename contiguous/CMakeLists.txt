# This example also shows CMake Fortran preprocessor directives
cmake_minimum_required(VERSION 3.1)
project(f2008contig Fortran)
enable_testing()

get_directory_property(hasParent PARENT_DIRECTORY)
if(NOT hasParent)
  include(../cmake/compilers.cmake)
endif()

# ifort-19 yes, Flang yes, PGI yes, NAG yes, gfortran-8 no
include(CheckFortranSourceCompiles)
check_fortran_source_compiles("program c; print*,is_contiguous([0,0]); end" f08contig
                              SRC_EXT f90)

add_executable(contig contiguous.F90)
target_compile_options(contig PRIVATE ${FFLAGS})
target_link_libraries(contig PRIVATE ${FLIBS})
if(f08contig)
  set_target_properties(contig PROPERTIES 
                        COMPILE_DEFINITIONS ISCONTIG)
endif()
if(CMAKE_Fortran_COMPILER_ID STREQUAL GNU)
  target_compile_options(contig PRIVATE -Warray-temporaries)
endif()
