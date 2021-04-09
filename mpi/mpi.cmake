include(CheckFortranSourceCompiles)

function(check_mpi)

set(CMAKE_REQUIRED_INCLUDES)
set(CMAKE_REQUIRED_FLAGS)
set(CMAKE_REQUIRED_LIBRARIES)

# --- test Fortran MPI

set(CMAKE_REQUIRED_LIBRARIES MPI::MPI_Fortran Threads::Threads)

if(NOT DEFINED MPI_Fortran_OK)
  message(STATUS "Fortran MPI:
  Libs: ${MPI_Fortran_LIBRARIES} ${CMAKE_THREAD_LIBS_INIT}
  Include: ${MPI_Fortran_INCLUDE_DIRS}
  MPIexec: ${MPIEXEC_EXECUTABLE}"
  )
endif()

check_fortran_source_compiles("use mpi
integer :: i
call mpi_init(i)
call mpi_finalize(i)
end" MPI_Fortran_OK SRC_EXT F90)

if(NOT MPI_Fortran_OK)
  message(STATUS "SKIP: MPI_Fortran not working.")
  return()
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
  message(STATUS "SKIP: MPI_C not working.")
  return()
endif()

endfunction(check_mpi)

find_package(MPI COMPONENTS C Fortran)
if(NOT MPI_FOUND)
  return()
endif()

find_package(Threads REQUIRED)

check_mpi()
