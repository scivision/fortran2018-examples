include(CheckFortranSourceCompiles)

function(check_mpi)

set(CMAKE_REQUIRED_INCLUDES)
set(CMAKE_REQUIRED_FLAGS)
set(CMAKE_REQUIRED_LIBRARIES)

find_package(MPI COMPONENTS Fortran)
if(NOT MPI_FOUND)
  return()
endif()

find_package(Threads)

# --- test Fortran MPI

set(CMAKE_REQUIRED_LIBRARIES MPI::MPI_Fortran Threads::Threads)

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
  message(STATUS "SKIP: MPI_Fortran not working.")
  return()
endif()

endfunction(check_mpi)

check_mpi()
