cmake_minimum_required (VERSION 3.11)  # 3.9: MPI::MPI_Fortran, 3.11: Lapack
project(test_gem Fortran C)  # need C for scalapack findThreads with MKL/Intel
enable_testing()

# GNU with MKL (first compile https://github.com/scivision/fortran-libs with MKL)
# cmake -DLIB_DIR=~/flibs-gnu-mkl -DUSEMKL=yes ..

# LIB_DIR: top-level path for self-compiled libraries e.g. ~/flibs-gnu-MKL

option(USEMKL "Use Intel MKL libraries")

if($ENV{MKLROOT})
  set(USEMKL ON)
endif()

if(NOT realbits)
  set(realbits 64)
endif()

if(${CMAKE_VERSION} VERSION_GREATER_EQUAL "3.12.0")  # quotes are needed!
  cmake_policy(SET CMP0074 NEW)
endif()

get_directory_property(hasParent PARENT_DIRECTORY)
if(NOT hasParent)
  include(../cmake/compilers.cmake)
  list(APPEND CMAKE_MODULE_PATH ${PROJECT_SOURCE_DIR}/../cmake/Modules/)
endif()

#------------

include(${PROJECT_SOURCE_DIR}/../cmake/mumps.cmake)

if(CMAKE_Fortran_COMPILER_ID STREQUAL GNU)
  set(MPI_Fortran_COMPILER /usr/bin/mpif90)
endif()
find_package(MPI REQUIRED COMPONENTS Fortran)

add_executable(testmumps test_mumps.f90)
target_include_directories(testmumps PRIVATE ${MUMPS_INCLUDE_DIRS})
target_link_libraries(testmumps PRIVATE
                     ${MUMPS_LIBRARIES}
                     MPI::MPI_Fortran)
add_test(NAME MUMPS
  COMMAND ${MPIEXEC_EXECUTABLE} ${MPIEXEC_NUMPROC_FLAG} ${MPIEXEC_MAX_NUMPROCS} ${CMAKE_CURRENT_BINARY_DIR}/testmumps
  WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR})
