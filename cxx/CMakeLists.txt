cmake_minimum_required(VERSION 3.14)
project(fortran2018io C Fortran)
enable_testing()

# This example demonstrates very basic linking of
# * C++ calling Fortran
# * Fortran calling C++
# * Fortran calling C


# https://stackoverflow.com/tags/fortran-iso-c-binding/info

add_library(c_lib call_c.c)
target_compile_options(c_lib PRIVATE ${CFLAGS})

add_executable(f_call_c f_call_c.f90)
target_link_libraries(f_call_c PRIVATE c_lib)
add_test(NAME FortranCallC COMMAND f_call_c)

# Workaround for PGI not having CXX on Windows and wrong CXX compiler being found
if(WIN32 AND CMAKE_C_COMPILER_ID STREQUAL PGI)
  message(STATUS "SKIP: CXX - PGI on Windows does not currently have a CXX compiler")
  return()
endif()

include(CheckLanguage)
check_language(CXX)
if(CMAKE_CXX_COMPILER)
  enable_language(CXX)
else()
  return()
endif()

set(CMAKE_CXX_STANDARD_REQUIRED ON)

# -- C++ calling Fortran
add_library(call_f c_call_f.f90)
set_target_properties(call_f PROPERTIES POSITION_INDEPENDENT_CODE ON)

# LD_LIBRARY_PATH=~/.local/pgi/linux86-64/2018/lib:$LD_LIBRARY_PATH ./cxx_call_f
add_executable(cxx_call_f cxx_call_f.cxx)
target_link_libraries(cxx_call_f PRIVATE call_f)
target_compile_options(cxx_call_f PRIVATE ${CFLAGS})
set_target_properties(cxx_call_f PROPERTIES CXX_STANDARD 11)
add_test(NAME CXXCallFortran COMMAND cxx_call_f)

# -- Fortran calling C++
add_library(cxx_lib call_cxx.cxx)

add_executable(f_call_cxx f_call_cxx.f90)
target_link_libraries(f_call_cxx PRIVATE cxx_lib)
# LINKER_LANGUAGE option is necessary for ifort at least
set_target_properties(f_call_cxx PROPERTIES LINKER_LANGUAGE Fortran)
add_test(NAME FortranCallC++ COMMAND f_call_cxx)
