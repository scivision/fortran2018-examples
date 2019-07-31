add_executable(badbounds badbounds.f90)
if(CMAKE_Fortran_COMPILER_ID STREQUAL GCC)
  target_compile_options(badbounds PRIVATE -fcheck=bounds)
  set(xfail true)
elseif(CMAKE_Fortran_COMPILER_ID STREQUAL Intel)
  set(xfail true)
else()
  set(xfail false)
endif()

# falsely trips with segfault
# add_test(NAME BoundsFail COMMAND badbounds WILL_FAIL ${xfail})

if(WIN32 AND CMAKE_Fortran_COMPILER_ID STREQUAL PGI)
  message(STATUS "CMake bug with PGI on Windows -- pgfortran.exe itself works")
else()
  add_executable(nanmaxmin maxmin_nan.f90)
  add_test(NAME debug:NaNminmax COMMAND nanmaxmin)
endif()

add_executable(typecast typecast.f90)
add_test(NAME debug:Typecasting COMMAND typecast)
