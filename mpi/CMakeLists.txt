cmake_minimum_required(VERSION 3.3)
project(mpidemo Fortran C)
enable_testing()

if(CMAKE_VERSION VERSION_GREATER_EQUAL 3.12)
  cmake_policy(SET CMP0074 NEW)
endif()

get_directory_property(hasParent PARENT_DIRECTORY)
if(NOT hasParent)
  include(../cmake/compilers.cmake)
endif()

find_package(MPI COMPONENTS Fortran)
if(NOT MPI_Fortran_FOUND)
  return()
endif()

include(mpi.cmake)

add_executable(mpivers mpivers.f90)
target_compile_options(mpivers PRIVATE ${FFLAGS})
target_link_libraries(mpivers ${FLIBS} MPI::MPI_Fortran)
add_test(NAME MPIversion COMMAND mpivers)

add_executable(mpi_hello helloworld.f90)
target_compile_options(mpi_hello PRIVATE ${FFLAGS})
target_link_libraries(mpi_hello ${FLIBS} MPI::MPI_Fortran)
add_test(NAME MPIhello 
         COMMAND ${MPIEXEC_EXECUTABLE} ${MPIEXEC_NUMPROC_FLAG} ${MPIEXEC_MAX_NUMPROCS}
  ${MPIEXEC_PREFLAGS} ./mpi_hello ${MPIEXEC_POSTFLAGS})    

add_executable(mpi_pass thread_pass.f90)
target_compile_options(mpi_pass PRIVATE ${FFLAGS})
target_link_libraries(mpi_pass ${FLIBS} MPI::MPI_Fortran)
add_test(NAME MPIpass 
         COMMAND ${MPIEXEC_EXECUTABLE} ${MPIEXEC_NUMPROC_FLAG} ${MPIEXEC_MAX_NUMPROCS}
  ${MPIEXEC_PREFLAGS} ./mpi_pass ${MPIEXEC_POSTFLAGS})

# mpifort --showme
#
# gfortran -I/usr/lib/openmpi/include -pthread -I/usr/lib/openmpi/lib -Wl,-rpath -Wl,/usr/lib/openmpi/lib -Wl,--enable-new-dtags -L/usr/lib/openmpi/lib -lmpi_usempif08 -lmpi_usempi_ignore_tkr -lmpi_mpifh -lmpi

# make VERBOSE=1
#
#/usr/bin/f95  -I/usr/lib/openmpi/include -I/usr/lib/openmpi/lib  -Wl,-rpath,/usr/lib/openmpi/lib /usr/lib/openmpi/lib/libmpi_usempif08.so /usr/lib/openmpi/lib/libmpi_usempi_ignore_tkr.so /usr/lib/openmpi/lib/libmpi_mpifh.so /usr/lib/openmpi/lib/libmpi.so

