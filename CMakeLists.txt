cmake_minimum_required (VERSION 2.8.12)
project(fortran2015examples Fortran)

find_package(MPI REQUIRED)
set(CMAKE_Fortran_COMPILER ${MPI_Fortran_COMPILER}) #wrapper compiler mpif90
# FIXME these lines should work, but used wrapper compiler mpif90 instead
# consider mpif90 --showme
# https://www.open-mpi.org/faq/?category=mpi-apps
#
#add_definitions(${MPI_Fortran_COMPILE_FLAGS})
#include_directories(${MPI_Fortran_INCLUDE_PATH})
#list(APPEND CMAKE_Fortran_LINK_FLAGS ${MPI_Fortran_LINK_FLAGS})

add_executable(hello hello.f90)
#target_link_libraries(hello ${MPI_Fortran_LIBRARIES})

