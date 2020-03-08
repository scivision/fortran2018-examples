# for Gfortran + OpenMPI:
#    cmake -DMPI_Fortran_COMPILER=/usr/bin/mpif90.openmpi ..

  # DON'T USE WRAPPER COMPILER AND FLAGS -- one or the other!
  #set(CMAKE_Fortran_COMPILER ${MPI_Fortran_COMPILER}) #wrapper compiler mpif90
  # consider mpif90 --showme
  # https://www.open-mpi.org/faq/?category=mpi-apps

# --- determine MPI library versions (distinct from MPI version)
# can cause MPI to falsely fail
# didn't work (blank output) with MPI 4.0.0 and GNU

#set(MPI_DETERMINE_LIBRARY_VERSION true)
#message(STATUS "MPI Library version: " ${MPI_Fortran_LIBRARY_VERSION})

# --- verify MPI actually works
find_package(MPI COMPONENTS Fortran)
find_package(Threads)

if(NOT MPI_Fortran_FOUND)
  return()
endif()

set(CMAKE_REQUIRED_FLAGS ${MPI_Fortran_COMPILE_OPTIONS})
set(CMAKE_REQUIRED_INCLUDES ${MPI_Fortran_INCLUDE_DIRS})
set(CMAKE_REQUIRED_LIBRARIES ${MPI_Fortran_LIBRARIES} Threads::Threads)
include(CheckFortranSourceCompiles)

# Windows Intel 2019 MPI doesn't yet have mpi_f08
# MS-MPI 2.0 only have mpif.h not mpi.mod
check_fortran_source_compiles("include 'mpif.h'
end program" hasMPI SRC_EXT F90)

message(STATUS "
Libs: ${MPI_Fortran_LIBRARIES} ${CMAKE_THREAD_LIBS_INIT}
Include: ${MPI_Fortran_INCLUDE_DIRS}
Opts: ${MPI_Fortran_COMPILE_OPTIONS} ${MPI_Fortran_LINK_FLAGS}
MPIexec: ${MPIEXEC_EXECUTABLE}"
)

if(NOT hasMPI)
  message(STATUS "MPI library mpif.h not functioning with ${CMAKE_Fortran_COMPILER_ID} ${CMAKE_Fortran_COMPILER_VERSION}")
endif()

# --- end verify MPI
