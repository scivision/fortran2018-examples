cmake_minimum_required(3.1)
project(debugopts Fortran)
enable_testing()


add_executable(badbounds badbounds.f90)
target_compile_options(badbounds PRIVATE -fcheck=bounds)
add_test(NAME BoundsFail COMMAND badbounds)

add_executable(nanmaxmin  maxmin_nan.f90)

