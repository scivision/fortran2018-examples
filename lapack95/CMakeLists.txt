if(WIN32 AND CMAKE_Fortran_COMPILER_ID STREQUAL PGI)
  message(STATUS "skipping: PGI Lapack is buggy on Windows")
  return()
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
  target_link_libraries(svd PRIVATE ${LAPACK_LIBRARIES})
  target_include_directories(svd PRIVATE ${LAPACK_INCLUDE_DIRS})
  target_compile_definitions(svd PRIVATE USEMKL=${USEMKL})
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

