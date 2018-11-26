cmake_minimum_required (VERSION 3.3)
project(mpidemo Fortran C)
enable_testing()

get_directory_property(hasParent PARENT_DIRECTORY)
if(NOT hasParent)
  include(../cmake/compilers.cmake)
endif()

# for Gfortran + OpenMPI: 
#    cmake -DMPI_Fortran_COMPILER=/usr/bin/mpif90.openmpi ..

# ------- MPI Fortran examples ----------------
find_package(MPI COMPONENTS Fortran)
if(NOT MPI_Fortran_FOUND)
  return()
endif() 
  # DON'T USE WRAPPER COMPILER AND FLAGS -- one or the other!
  #set(CMAKE_Fortran_COMPILER ${MPI_Fortran_COMPILER}) #wrapper compiler mpif90
  # consider mpif90 --showme
  # https://www.open-mpi.org/faq/?category=mpi-apps
  
list(APPEND FLIBS ${MPI_Fortran_LIBRARIES} ${CMAKE_THREAD_LIBS_INIT})
list(APPEND FFLAGS ${MPI_Fortran_COMPILE_OPTIONS})
  
find_package(Threads REQUIRED QUIET) 

set(CMAKE_REQUIRED_FLAGS ${MPI_Fortran_COMPILE_OPTIONS})
set(CMAKE_REQUIRED_INCLUDES ${MPI_Fortran_INCLUDE_DIRS})
set(CMAKE_REQUIRED_LIBRARIES ${MPI_Fortran_LIBRARIES} ${CMAKE_THREAD_LIBS_INIT})
include(CheckFortranSourceCompiles)
check_fortran_source_compiles("program a; use mpi; end" hasMPI
                              SRC_EXT f90)
if(NOT hasMPI)
  return()
endif()   

add_executable(mpi_hello helloworld.f90)
target_compile_options(mpi_hello PRIVATE ${FFLAGS})
target_include_directories(mpi_hello PRIVATE ${MPI_Fortran_INCLUDE_DIRS})
target_link_libraries(mpi_hello ${FLIBS})
add_test(NAME MPIhello 
         COMMAND ${MPIEXEC_EXECUTABLE} ${MPIEXEC_NUMPROC_FLAG} ${MPIEXEC_MAX_NUMPROCS}
  ${MPIEXEC_PREFLAGS} ./mpi_hello ${MPIEXEC_POSTFLAGS})    

add_executable(mpi_pass thread_pass.f90)
target_compile_options(mpi_pass PRIVATE ${FFLAGS})
target_include_directories(mpi_pass PRIVATE ${MPI_Fortran_INCLUDE_DIRS})
target_link_libraries(mpi_pass ${FLIBS})
add_test(NAME MPIpass 
         COMMAND ${MPIEXEC_EXECUTABLE} ${MPIEXEC_NUMPROC_FLAG} ${MPIEXEC_MAX_NUMPROCS}
  ${MPIEXEC_PREFLAGS} ./mpi_pass ${MPIEXEC_POSTFLAGS})

# mpifort --showme
#
# gfortran -I/usr/lib/openmpi/include -pthread -I/usr/lib/openmpi/lib -Wl,-rpath -Wl,/usr/lib/openmpi/lib -Wl,--enable-new-dtags -L/usr/lib/openmpi/lib -lmpi_usempif08 -lmpi_usempi_ignore_tkr -lmpi_mpifh -lmpi

# make VERBOSE=1
#
#/usr/bin/f95  -I/usr/lib/openmpi/include -I/usr/lib/openmpi/lib  -Wl,-rpath,/usr/lib/openmpi/lib /usr/lib/openmpi/lib/libmpi_usempif08.so /usr/lib/openmpi/lib/libmpi_usempi_ignore_tkr.so /usr/lib/openmpi/lib/libmpi_mpifh.so /usr/lib/openmpi/lib/libmpi.so

