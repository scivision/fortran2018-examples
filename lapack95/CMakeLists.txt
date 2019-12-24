if(DEFINED ENV{MKLROOT})
  find_package(LAPACK COMPONENTS MKL LAPACK95)
else()
  find_package(LAPACK COMPONENTS LAPACK95)
endif()

if(LAPACK_LAPACK95_FOUND)
  add_executable(svd demo_gesvd.F90)
  target_link_libraries(svd PRIVATE ${LAPACK_LIBRARIES})
  target_include_directories(svd PRIVATE ${LAPACK_INCLUDE_DIRS})
  if(DEFINED ENV{MKLROOT})
    target_compile_definitions(svd PRIVATE USEMKL)
  endif()
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

