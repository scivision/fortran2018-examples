cmake_minimum_required (VERSION 3.3)
project(fortran2018benchmark Fortran)
enable_testing()


add_executable(ackermann ackermann.f90)
target_compile_options(ackermann PRIVATE ${FFLAGS})
