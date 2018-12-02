 # for Gfortran + OpenMPI: 
#    cmake -DMPI_Fortran_COMPILER=/usr/bin/mpif90.openmpi ..

  # DON'T USE WRAPPER COMPILER AND FLAGS -- one or the other!
  #set(CMAKE_Fortran_COMPILER ${MPI_Fortran_COMPILER}) #wrapper compiler mpif90
  # consider mpif90 --showme
  # https://www.open-mpi.org/faq/?category=mpi-apps

# --- verify MPI actually works
set(CMAKE_REQUIRED_FLAGS ${MPI_Fortran_COMPILE_OPTIONS})
set(CMAKE_REQUIRED_INCLUDES ${MPI_Fortran_INCLUDE_DIRS})
set(CMAKE_REQUIRED_LIBRARIES ${MPI_Fortran_LIBRARIES} ${CMAKE_THREAD_LIBS_INIT})
include(CheckFortranSourceCompiles)
check_fortran_source_compiles("program a; use mpi; end" hasMPI
                              SRC_EXT f90)
if(NOT hasMPI)
  message(STATUS "MPI library not functioning with " 
          ${CMAKE_Fortran_COMPILER_ID} " " ${CMAKE_Fortran_COMPILER_VERSION})
  return()
endif()  

# --- end verify MPI
