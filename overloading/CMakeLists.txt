cmake_minimum_required(VERSION 3.3)
project(f2018errorstop Fortran)
enable_testing()

get_directory_property(hasParent PARENT_DIRECTORY)
if(NOT hasParent)
  include(../cmake/compilers.cmake)
endif()

include(${CMAKE_CURRENT_SOURCE_DIR}/../cmake/f08version.cmake)
include(${CMAKE_CURRENT_SOURCE_DIR}/../cmake/f18errorstop.cmake)

if(f08version)
add_executable(proc pragma.f90)
target_compile_options(proc PRIVATE ${FFLAGS})
target_link_libraries(proc ${FLIBS})
add_test(NAME FortranPragma COMMAND proc)
endif()

if(f18errorstop)
add_executable(f18es f2018errorstop.f90)
target_compile_options(f18es PRIVATE ${FFLAGS})
target_link_libraries(f18es PRIVATE ${FLIBS})
endif()
