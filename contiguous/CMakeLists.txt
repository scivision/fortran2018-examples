# This example also shows CMake Fortran preprocessor directives
cmake_minimum_required(VERSION 3.1)
project(f2008contig Fortran)
enable_testing()

get_directory_property(hasParent PARENT_DIRECTORY)
if(NOT hasParent)
  include(${CMAKE_CURRENT_SOURCE_DIR}/../cmake/compilers.cmake)
endif()

include(${CMAKE_CURRENT_SOURCE_DIR}/../cmake/f08contig.cmake)

add_executable(contig contiguous.F90)
target_compile_options(contig PRIVATE ${FFLAGS})
target_link_libraries(contig PRIVATE ${FLIBS})
if(f08contig)
  target_compile_definitions(contig PRIVATE ISCONTIG)
endif()
if(CMAKE_Fortran_COMPILER_ID STREQUAL GNU)
  target_compile_options(contig PRIVATE -Warray-temporaries)
endif()
add_test(NAME Contiguous COMMAND contig)
