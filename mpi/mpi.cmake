find_package(MPI COMPONENTS C Fortran)
if(NOT MPI_FOUND)
  return()
endif()
find_package(Threads)

set(CMAKE_REQUIRED_INCLUDES)
set(CMAKE_REQUIRED_FLAGS)

# --- test Fortran MPI

set(CMAKE_REQUIRED_LIBRARIES MPI::MPI_Fortran Threads::Threads)
include(CheckFortranSourceCompiles)

# Windows Intel 2019 MPI doesn't yet have mpi_f08
if(NOT DEFINED MPI_Fortran_OK)
  check_fortran_source_compiles("use mpi; end" MPI_Fortran_OK SRC_EXT F90)

  message(STATUS "Fortran MPI:
  Libs: ${MPI_Fortran_LIBRARIES} ${CMAKE_THREAD_LIBS_INIT}
  Include: ${MPI_Fortran_INCLUDE_DIRS}
  MPIexec: ${MPIEXEC_EXECUTABLE}"
  )
endif()

if(NOT MPI_Fortran_OK)
  message(FATAL_ERROR "MPI Fortran library mpif.h not functioning with ${CMAKE_Fortran_COMPILER_ID} ${CMAKE_Fortran_COMPILER_VERSION}")
endif()

# --- test C MPI

set(CMAKE_REQUIRED_LIBRARIES MPI::MPI_C Threads::Threads)
include(CheckCSourceCompiles)

if(NOT DEFINED MPI_C_OK)
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

  message(STATUS "C MPI:
  Libs: ${MPI_C_LIBRARIES} ${CMAKE_THREAD_LIBS_INIT}
  Include: ${MPI_C_INCLUDE_DIRS}
  MPIexec: ${MPIEXEC_EXECUTABLE}"
  )
endif()

if(NOT MPI_C_OK)
  message(FATAL_ERROR "MPI C library mpi.h not functioning with ${CMAKE_C_COMPILER_ID} ${CMAKE_C_COMPILER_VERSION}")
endif()
