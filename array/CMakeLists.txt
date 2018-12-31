cmake_minimum_required (VERSION 3.3)
project(fortran2018array Fortran)
enable_testing()

get_directory_property(hasParent PARENT_DIRECTORY)
if(NOT hasParent)
  include(../cmake/compilers.cmake)
endif()

if(f08errorstop)
  # ------- rot90, flip --------
  add_library(rotflip rot90.f90)
  target_compile_options(rotflip PRIVATE ${FFLAGS})
  target_link_libraries(rotflip PRIVATE ${FLIBS})

  add_executable(rotflip_test test_rot90.f90)
  target_link_libraries(rotflip_test rotflip ${FLIBS})
  target_compile_options(rotflip_test PRIVATE ${FFLAGS})
  add_test(NAME RotFlip COMMAND rotflip_test)
  #---
endif()
