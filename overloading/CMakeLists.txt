cmake_minimum_required(VERSION 3.3)
project(f2018errorstop Fortran)
enable_testing()

get_directory_property(hasParent PARENT_DIRECTORY)
if(NOT hasParent)
  include(../cmake/compilers.cmake)
endif()

check_fortran_source_compiles("use iso_fortran_env; print *, compiler_options(); end" 
  f08version SRC_EXT f90)

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
