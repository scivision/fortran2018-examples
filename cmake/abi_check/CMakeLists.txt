cmake_minimum_required(VERSION 3.13)
project(abi_check LANGUAGES C Fortran)

add_library(addone OBJECT addone.c)

add_executable(main main.f90 $<TARGET_OBJECTS:addone>)
