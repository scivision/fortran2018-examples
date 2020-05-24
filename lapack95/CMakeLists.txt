cmake_minimum_required(VERSION 3.15)
project(F18lapack95 LANGUAGES Fortran)
enable_testing()

get_directory_property(hasParent PARENT_DIRECTORY)
if(NOT hasParent)
  list(APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/../cmake/Modules)
endif()

find_package(LAPACK COMPONENTS LAPACK95)

if(LAPACK_LAPACK95_FOUND)

  if(DEFINED ENV{MKLROOT})
    set(lapack95_use "use lapack95, only: gesvd")
  else()
    set(lapack95_use "use f95_lapack, only: gesvd=>la_gesvd")
  endif()

  configure_file(demo_gesvd.in.f90 demo_gesvd.f90)

  add_executable(svd ${CMAKE_CURRENT_BINARY_DIR}/demo_gesvd.f90)
  target_link_libraries(svd PRIVATE ${LAPACK_LIBRARIES})
  target_include_directories(svd PRIVATE ${LAPACK_INCLUDE_DIRS})
  add_test(NAME Lapack95SVD COMMAND svd)
endif()

#=== LAPACK MKL example with Intel OR Gfortran compilers ===
if(NOT LAPACK_FOUND)
  find_package(LAPACK)
endif()

if(LAPACK_FOUND)
  add_executable(dsvd intel_dgesvd.f90)
  target_link_libraries(dsvd PRIVATE ${LAPACK_LIBRARIES})
  target_include_directories(dsvd PRIVATE ${LAPACK_INCLUDE_DIRS})
  add_test(NAME LapackDsvd COMMAND dsvd)
endif()
