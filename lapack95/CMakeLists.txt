cmake_minimum_required (VERSION 3.12)
if(NOT CMAKE_BUILD_TYPE)
  set(CMAKE_BUILD_TYPE Release CACHE STRING "Debug or Release")
endif()
project(fortran2018array C Fortran)  # C is necessary for MKL detection!
enable_testing()

cmake_policy(SET CMP0074 NEW)

get_directory_property(hasParent PARENT_DIRECTORY)
if(NOT hasParent)
  include(${CMAKE_CURRENT_SOURCE_DIR}/../cmake/compilers.cmake)
  list(APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/../cmake/Modules/)
endif()


if(DEFINED ENV{MKLROOT})
  set(USEMKL 1)
  find_package(LAPACK COMPONENTS MKL LAPACK95)
else()
  set(USEMKL 0)
  find_package(LAPACK COMPONENTS LAPACK95)
endif()


if(LAPACK_LAPACK95_FOUND)
  add_executable(svd demo_gesvd.F90)
  target_link_libraries(svd PRIVATE ${LAPACK_LIBRARIES} ${FLIBS})
  target_include_directories(svd PRIVATE ${LAPACK_INCLUDE_DIRS})
  target_compile_options(svd PRIVATE ${FFLAGS})
  target_compile_definitions(svd PRIVATE USEMKL=${USEMKL})
  add_test(NAME Lapack95SVD COMMAND svd)
endif()

#=== LAPACK MKL example with Intel OR Gfortran compilers ===
if(NOT LAPACK_FOUND)
  find_package(LAPACK)
endif()

if(LAPACK_FOUND)
  add_executable(dsvd intel_dgesvd.f90)
  target_link_libraries(dsvd PRIVATE ${LAPACK_LIBRARIES} ${FLIBS})
  target_include_directories(dsvd PRIVATE ${LAPACK_INCLUDE_DIRS})
  add_test(NAME LapackDsvd COMMAND dsvd)
endif()

