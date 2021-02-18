cmake_minimum_required(VERSION 3.14)

include(cmake/policy.cmake)
include(cmake/compiler_find.cmake)
find_c_fortran()

project(Fortran2018Examples
LANGUAGES C Fortran
DESCRIPTION "Example of using modern Fortran syntax"
VERSION 1.3.4)

include(CTest)
if(NOT DEFINED ${PROJECT_NAME}_BUILD_TESTING)
  set(${PROJECT_NAME}_BUILD_TESTING ${BUILD_TESTING})
endif()

list(APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/cmake/Modules/)

option(mpi "MPI tests" on)

include(cmake/compilers.cmake)

add_subdirectory(array)
add_subdirectory(benchmarks)
add_subdirectory(block)
add_subdirectory(character)
add_subdirectory(coarray)
add_subdirectory(contiguous)
add_subdirectory(git)
add_subdirectory(io)
add_subdirectory(debug)
add_subdirectory(lapack95)
add_subdirectory(maximum)
add_subdirectory(mpi)
add_subdirectory(namelist)
# add_subdirectory(openacc)
add_subdirectory(openmp)
add_subdirectory(overloading)
add_subdirectory(random)
add_subdirectory(real)
add_subdirectory(standard)
add_subdirectory(submodule)
add_subdirectory(system)

# --- summary
include(FeatureSummary)
add_feature_info(Openmp hasOMP "tests using OpenMP")
add_feature_info(MPI MPI_Fortran_OK "tests using MPI")

feature_summary(WHAT ALL)
