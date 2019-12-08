# https://cmake.org/cmake/help/latest/module/FindOpenACC.html

cmake_minimum_required(VERSION 3.10)
project(DemoOpenACC Fortran)
enable_testing()

find_package(OpenACC)

if(NOT OpenACC_Fortran_FOUND)
  message('SKIP: OpenACC')
  return()
endif()

add_executable(simple_openacc simple_openacc.f90)
target_compile_options(simple_openacc PRIVATE ${OpenACC_Fortran_FLAGS})

add_test(NAME OpenACCsimple COMMAND simple_openacc)
set_tests_properties(OpenACCsimple PROPERTIES TIMEOUT 15)
