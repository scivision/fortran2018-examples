cmake_minimum_required(VERSION 3.1)
project(debugopts Fortran)
enable_testing()


add_executable(badbounds badbounds.f90)
if(CMAKE_Fortran_COMPILER_ID STREQUAL GCC)
  target_compile_options(badbounds PRIVATE -fcheck=bounds)
  set(xfail true)
elseif(CMAKE_Fortran_COMPILER_ID STREQUAL Intel)
  set(xfail true)
else()
  set(xfail false)
endif()

if(NOT $ENV{CI})  # falsely trips some CIs with segfault
  add_test(NAME BoundsFail COMMAND badbounds WILL_FAIL ${xfail})
endif()

add_executable(nanmaxmin maxmin_nan.f90)

add_executable(typecast typecast.f90)
