function(check_mpi)

find_package(MPI COMPONENTS C Fortran)
find_package(Threads)

set(CMAKE_REQUIRED_INCLUDES)
set(CMAKE_REQUIRED_FLAGS)

# --- test Fortran MPI

set(CMAKE_REQUIRED_LIBRARIES MPI::MPI_Fortran Threads::Threads)
include(CheckFortranSourceCompiles)

if(NOT DEFINED MPI_Fortran_OK)
  message(STATUS "Fortran MPI:
  Libs: ${MPI_Fortran_LIBRARIES} ${CMAKE_THREAD_LIBS_INIT}
  Include: ${MPI_Fortran_INCLUDE_DIRS}
  MPIexec: ${MPIEXEC_EXECUTABLE}"
  )
endif()

# Windows Intel 2019 MPI doesn't yet have mpi_f08
check_fortran_source_compiles("use mpi; end" MPI_Fortran_OK SRC_EXT F90)

if(NOT MPI_Fortran_OK)
  message(FATAL_ERROR "MPI_Fortran not working. Please use 'cmake -Dmpi=off' option")
endif()

# --- test C MPI

set(CMAKE_REQUIRED_LIBRARIES MPI::MPI_C Threads::Threads)
include(CheckCSourceCompiles)

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

if(NOT MPI_C_OK)
  message(FATAL_ERROR "MPI_C not working. Please use 'cmake -Dmpi=off' option")
endif()

endfunction(check_mpi)

check_mpi()
