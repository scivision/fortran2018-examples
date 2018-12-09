cmake_minimum_required (VERSION 3.11)  # 3.9: MPI::MPI_Fortran, 3.11: Lapack
project(test_gem Fortran)
enable_testing()

# LIB_DIR: top-level path for self-compiled libraries e.g. ~/flibs-gnu-MKL

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

find_package(MPI REQUIRED COMPONENTS Fortran)

add_executable(testmumps test_mumps.f90)
target_include_directories(testmumps PRIVATE ${MUMPS_INCLUDE_DIRS})
target_link_libraries(testmumps PRIVATE
                     ${MUMPS_LIBRARIES}
                     MPI::MPI_Fortran)
add_test(NAME MUMPS
  COMMAND ${MPIEXEC_EXECUTABLE} ${MPIEXEC_NUMPROC_FLAG} ${MPIEXEC_MAX_NUMPROCS} ${CMAKE_CURRENT_BINARY_DIR}/testmumps
  WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR})
