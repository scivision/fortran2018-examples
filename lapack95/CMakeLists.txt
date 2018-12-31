cmake_minimum_required (VERSION 3.12)
project(fortran2018array Fortran C)  # C is NECESSARY for MKL detection!
enable_testing()

cmake_policy(SET CMP0074 NEW)

get_directory_property(hasParent PARENT_DIRECTORY)
if(NOT hasParent)
  include(../cmake/compilers.cmake)
  list(APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/../cmake/Modules/)
endif()

if(UNIX AND CMAKE_INSTALL_PREFIX_INITIALIZED_TO_DEFAULT)
  set(CMAKE_INSTALL_PREFIX "~/.local" CACHE PATH "..." FORCE)
endif()

if(DEFINED ENV{MKLROOT})
  set(USEMKL 1)
else()
  set(USEMKL 0)
endif()

if(NOT CMAKE_Fortran_COMPILER_ID STREQUAL Intel)
  set(LAPACK95_ROOT ${CMAKE_INSTALL_PREFIX})
endif()


find_package(LAPACK95)

if(USEMKL AND NOT LAPACK95_FOUND)
  get_filename_component(FC ${CMAKE_Fortran_COMPILER} NAME)
  
  execute_process(COMMAND make libintel64 INSTALL_DIR=${CMAKE_INSTALL_PREFIX} interface=lp64 FC=${FC}
  WORKING_DIRECTORY $ENV{MKLROOT}/interfaces/lapack95)
    
  find_package(LAPACK95)
endif()

if(LAPACK95_FOUND)
  add_executable(svd demo_gesvd.F90)
  target_link_libraries(svd PRIVATE ${LAPACK95_LIBRARIES} ${FLIBS})
  target_include_directories(svd PRIVATE ${LAPACK95_INCLUDE_DIRS})
  target_compile_options(svd PRIVATE ${FFLAGS})
  target_compile_definitions(svd PRIVATE USEMKL=${USEMKL})
  add_test(NAME FortranSVD COMMAND svd)
endif()

#=== LAPACK MKL example with Intel OR Gfortran compilers ===
find_package(LAPACK)

if(LAPACK_FOUND)
  add_executable(dsvd intel_dgesvd.f90)
  target_link_libraries(dsvd PRIVATE ${LAPACK_LIBRARIES} ${FLIBS})
  target_include_directories(dsvd PRIVATE ${LAPACK_INCLUDE_DIRS})
  add_test(NAME FortranDsvd COMMAND dsvd)
endif()

