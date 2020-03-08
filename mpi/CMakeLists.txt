cmake_minimum_required(VERSION 3.14)
project(mpi_fortran
LANGUAGES C Fortran)
enable_testing()
# If you have a custom location for mpif90 / mpifort and CMake doesn't find it, try
#   FC=mpif90 cmake ..

# Windows Intel 2019 MPI doesn't yet have mpi_f08

include(mpi.cmake)
if(NOT hasMPI)
  return()
endif()

add_executable(mpivers mpivers.f90)
target_link_libraries(mpivers MPI::MPI_Fortran)
add_test(NAME MPIversion COMMAND mpivers)

add_executable(mpi_hello helloworld.f90)
target_link_libraries(mpi_hello MPI::MPI_Fortran)
add_test(NAME MPIhello
  COMMAND ${MPIEXEC_EXECUTABLE} ${MPIEXEC_NUMPROC_FLAG} ${MPIEXEC_MAX_NUMPROCS}
  ${MPIEXEC_PREFLAGS} $<TARGET_FILE:mpi_hello> ${MPIEXEC_POSTFLAGS})
set_tests_properties(MPIhello PROPERTIES RUN_SERIAL true)

add_executable(mpi_pass thread_pass.f90)
target_link_libraries(mpi_pass MPI::MPI_Fortran)

if(MPIEXEC_MAX_NUMPROCS GREATER_EQUAL 2)
add_test(NAME MPIpass
  COMMAND ${MPIEXEC_EXECUTABLE} ${MPIEXEC_NUMPROC_FLAG} ${MPIEXEC_MAX_NUMPROCS}
  ${MPIEXEC_PREFLAGS} $<TARGET_FILE:mpi_pass> ${MPIEXEC_POSTFLAGS})
set_tests_properties(MPIpass PROPERTIES RUN_SERIAL true)
endif()
