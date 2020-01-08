# If you have a custom location for mpif90 / mpifort and CMake doesn't find it, try
#   FC=mpif90 cmake ..
cmake_policy(SET CMP0074 NEW)

include(mpi.cmake)
if(NOT hasMPI)
  return()
endif()


add_executable(mpivers mpivers.f90)
target_link_libraries(mpivers MPI::MPI_Fortran)

add_executable(mpi_hello helloworld.f90)
target_link_libraries(mpi_hello MPI::MPI_Fortran)

add_executable(mpi_pass thread_pass.f90)
target_link_libraries(mpi_pass MPI::MPI_Fortran)

add_test(NAME MPIversion COMMAND mpivers)

add_test(NAME MPIhello
         COMMAND ${MPIEXEC_EXECUTABLE} ${MPIEXEC_NUMPROC_FLAG} ${MPIEXEC_MAX_NUMPROCS}
  ${MPIEXEC_PREFLAGS} $<TARGET_FILE:mpi_hello> ${MPIEXEC_POSTFLAGS})
set_tests_properties(MPIhello PROPERTIES RUN_SERIAL true)

if(MPIEXEC_MAX_NUMPROCS GREATER_EQUAL 2)
add_test(NAME MPIpass
         COMMAND ${MPIEXEC_EXECUTABLE} ${MPIEXEC_NUMPROC_FLAG} ${MPIEXEC_MAX_NUMPROCS}
  ${MPIEXEC_PREFLAGS} $<TARGET_FILE:mpi_pass> ${MPIEXEC_POSTFLAGS})
set_tests_properties(MPIpass PROPERTIES RUN_SERIAL true)
endif()

# mpifort --showme
#
# gfortran -I/usr/lib/openmpi/include -pthread -I/usr/lib/openmpi/lib -Wl,-rpath -Wl,/usr/lib/openmpi/lib -Wl,--enable-new-dtags -L/usr/lib/openmpi/lib -lmpi_usempif08 -lmpi_usempi_ignore_tkr -lmpi_mpifh -lmpi

# make VERBOSE=1
#
#/usr/bin/f95  -I/usr/lib/openmpi/include -I/usr/lib/openmpi/lib  -Wl,-rpath,/usr/lib/openmpi/lib /usr/lib/openmpi/lib/libmpi_usempif08.so /usr/lib/openmpi/lib/libmpi_usempi_ignore_tkr.so /usr/lib/openmpi/lib/libmpi_mpifh.so /usr/lib/openmpi/lib/libmpi.so
