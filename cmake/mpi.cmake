include(CheckCSourceCompiles)
include(CheckFortranSourceCompiles)


set(CMAKE_REQUIRED_INCLUDES)
set(CMAKE_REQUIRED_FLAGS)


find_package(MPI COMPONENTS C Fortran)
if(NOT MPI_FOUND)
  return()
endif()

find_package(Threads REQUIRED)

# --- test Fortran MPI

set(CMAKE_REQUIRED_LIBRARIES MPI::MPI_Fortran Threads::Threads)

if(NOT DEFINED MPI_Fortran_OK)
  message(STATUS "Fortran MPI:
  Libs: ${MPI_Fortran_LIBRARIES} ${CMAKE_THREAD_LIBS_INIT}
  Include: ${MPI_Fortran_INCLUDE_DIRS}
  MPIexec: ${MPIEXEC_EXECUTABLE}"
  )
endif()

# MPI_VERSION isn't always defined. Better test the required API level.
check_fortran_source_compiles("
program test
use mpi_f08, only : mpi_init, mpi_finalize
implicit none
call mpi_init()
call mpi_finalize()
end program" MPI_Fortran_OK SRC_EXT F90)

# --- test C MPI

set(CMAKE_REQUIRED_LIBRARIES MPI::MPI_C Threads::Threads)

if(NOT DEFINED MPI_C_OK)
  message(STATUS "C MPI:
  Libs: ${MPI_C_LIBRARIES} ${CMAKE_THREAD_LIBS_INIT}
  Include: ${MPI_C_INCLUDE_DIRS}"
  )
endif()

check_c_source_compiles("
#include <mpi.h>
#ifndef NULL
#define NULL 0
#endif
int main(void) {
    MPI_Init(NULL, NULL);
    MPI_Finalize();
    return 0;}
" MPI_C_OK)

set(CMAKE_REQUIRED_LIBRARIES)
