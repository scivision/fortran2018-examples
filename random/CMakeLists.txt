cmake_minimum_required(VERSION 3.3)
project(f2018random Fortran)
enable_testing()

get_directory_property(hasParent PARENT_DIRECTORY)
if(NOT hasParent)
  include(../cmake/compilers.cmake)
endif()

if(NOT f08submod OR NOT f08errorstop)
  return()
endif()

add_executable(random random.f90 random_demo.f90)
target_compile_options(random PRIVATE ${FFLAGS})
target_link_libraries(random PRIVATE ${FLIBS})
add_test(NAME RandomInit COMMAND random)
if(f2018random)
  target_sources(random PRIVATE random_init_f2018.f90)
else()
  target_sources(random PRIVATE random_init.f90)
endif()

