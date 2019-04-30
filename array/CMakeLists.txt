cmake_minimum_required (VERSION 3.3)
project(fortran2018array Fortran)
enable_testing()

get_directory_property(hasParent PARENT_DIRECTORY)
if(NOT hasParent)
  include(${CMAKE_CURRENT_SOURCE_DIR}/../cmake/compilers.cmake)
endif()

add_executable(rotflip test_rot90.f90 rot90.f90)
target_link_libraries(rotflip ${FLIBS})
target_compile_options(rotflip PRIVATE ${FFLAGS})
add_test(NAME RotFlip COMMAND rotflip)
