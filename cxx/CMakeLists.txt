cmake_minimum_required(VERSION 3.15)
project(fortran2018io
LANGUAGES C Fortran CXX)
enable_testing()

# This example demonstrates very basic linking of
# * C++ calling Fortran
# * Fortran calling C++
# * Fortran calling C


# https://stackoverflow.com/tags/fortran-iso-c-binding/info

add_library(c_lib call_c.c)

add_executable(f_call_c f_call_c.f90)
target_link_libraries(f_call_c PRIVATE c_lib)
add_test(NAME FortranCallC COMMAND f_call_c)

# -- C++ calling Fortran
add_library(call_f OBJECT c_call_f.f90)

add_executable(cxx_call_f cxx_call_f.cxx)
target_link_libraries(cxx_call_f PRIVATE call_f)
target_compile_features(cxx_call_f PRIVATE cxx_std_11)
add_test(NAME CXXCallFortran COMMAND cxx_call_f)

# -- Fortran calling C++
add_library(cxx_lib OBJECT call_cxx.cxx)

add_executable(f_call_cxx f_call_cxx.f90)
target_link_libraries(f_call_cxx PRIVATE cxx_lib)
# LINKER_LANGUAGE option is necessary for ifort at least
set_target_properties(f_call_cxx PROPERTIES LINKER_LANGUAGE Fortran)
add_test(NAME FortranCallC++ COMMAND f_call_cxx)
