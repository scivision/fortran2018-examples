add_executable(badbounds badbounds.f90)
if(CMAKE_Fortran_COMPILER_ID STREQUAL GCC)
  target_compile_options(badbounds PRIVATE -fcheck=bounds)
endif()

add_executable(nanmaxmin maxmin_nan.f90)
add_test(NAME debug:NaNminmax COMMAND nanmaxmin)
