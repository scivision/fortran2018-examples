cmake_minimum_required(VERSION 3.14...3.20)
project(mpi_fortran
LANGUAGES C Fortran)

include(CTest)
# If you have a custom location for mpif90 / mpifort and CMake doesn't find it, try
#   FC=mpif90 cmake ..

include(mpi.cmake)
if(NOT MPI_Fortran_OK)
  return()
endif()

# --- does MPI library work at all

add_executable(mpi_basic basic.f90)
target_link_libraries(mpi_basic MPI::MPI_Fortran)
add_test(NAME mpi:fortran:basic COMMAND $<TARGET_FILE:mpi_basic>)
set_tests_properties(mpi:fortran:basic PROPERTIES TIMEOUT 5)

add_executable(mpi_version mpivers.f90)
target_link_libraries(mpi_version MPI::MPI_Fortran)
add_test(NAME mpi:fortran:version COMMAND $<TARGET_FILE:mpi_version>)
set_tests_properties(mpi:fortran:version PROPERTIES TIMEOUT 5)


add_executable(mpi_basic-C basic.c)
target_link_libraries(mpi_basic-C MPI::MPI_C)
add_test(NAME mpi:C:basic COMMAND $<TARGET_FILE:mpi_basic-C>)
set_tests_properties(mpi:C:basic PROPERTIES TIMEOUT 5)

add_executable(mpi_version-C mpivers.c)
target_link_libraries(mpi_version-C MPI::MPI_C)
add_test(NAME mpi:C:version COMMAND $<TARGET_FILE:mpi_version-C>)
set_tests_properties(mpi:C:version PROPERTIES TIMEOUT 5)

# --- more than one MPI image

add_executable(mpi_hello helloworld.f90)
target_link_libraries(mpi_hello MPI::MPI_Fortran)

add_test(NAME mpi:hello
  COMMAND ${MPIEXEC_EXECUTABLE} ${MPIEXEC_NUMPROC_FLAG} ${MPIEXEC_MAX_NUMPROCS} $<TARGET_FILE:mpi_hello>)
set_tests_properties(mpi:hello PROPERTIES
  RESOURCE_LOCK cpu_mpi
  TIMEOUT 5
  FIXTURES_SETUP mpi_fxt)

# --- actual message passing

add_executable(mpi_pass thread_pass.f90)
target_link_libraries(mpi_pass MPI::MPI_Fortran)

if(MPIEXEC_MAX_NUMPROCS GREATER_EQUAL 2)

add_test(NAME mpi:pass
  COMMAND ${MPIEXEC_EXECUTABLE} ${MPIEXEC_NUMPROC_FLAG} 2 $<TARGET_FILE:mpi_pass>)

set_tests_properties(mpi:pass PROPERTIES
  RESOURCE_LOCK cpu_mpi
  TIMEOUT 5
  FIXTURES_REQUIRED mpi_fxt)

endif()
