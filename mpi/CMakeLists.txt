cmake_minimum_required (VERSION 3.3)
project(mpidemo Fortran C)
enable_testing()

# for Gfortran + OpenMPI: 
#    cmake -DMPI_Fortran_COMPILER=/usr/bin/mpif90.openmpi ..

# ------- MPI Fortran examples ----------------
find_package(MPI COMPONENTS Fortran)
if(MPI_Fortran_FOUND)  
  # DON'T USE WRAPPER COMPILER AND FLAGS -- one or the other!
  #set(CMAKE_Fortran_COMPILER ${MPI_Fortran_COMPILER}) #wrapper compiler mpif90
  # consider mpif90 --showme
  # https://www.open-mpi.org/faq/?category=mpi-apps
  
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
  target_compile_options(mpi_hello PRIVATE ${FFLAGS} ${MPI_Fortran_COMPILE_OPTIONS})
  target_include_directories(mpi_hello PRIVATE ${MPI_Fortran_INCLUDE_DIRS})
  target_link_libraries(mpi_hello ${MPI_Fortran_LIBRARIES} ${CMAKE_THREAD_LIBS_INIT})
  add_test(NAME MPIhello COMMAND mpirun mpi_hello)    

  add_executable(mpi_pass thread_pass.f90)
  target_compile_options(mpi_pass PRIVATE ${FFLAGS} ${MPI_Fortran_COMPILE_OPTIONS})
  target_include_directories(mpi_pass PRIVATE ${MPI_Fortran_INCLUDE_DIRS})
  target_link_libraries(mpi_pass ${MPI_Fortran_LIBRARIES} ${CMAKE_THREAD_LIBS_INIT})
  add_test(NAME MPIpass COMMAND mpirun mpi_pass)
endif()


# mpifort --showme
#
# gfortran -I/usr/lib/openmpi/include -pthread -I/usr/lib/openmpi/lib -Wl,-rpath -Wl,/usr/lib/openmpi/lib -Wl,--enable-new-dtags -L/usr/lib/openmpi/lib -lmpi_usempif08 -lmpi_usempi_ignore_tkr -lmpi_mpifh -lmpi

# make VERBOSE=1
#
#/usr/bin/f95  -I/usr/lib/openmpi/include -I/usr/lib/openmpi/lib  -Wl,-rpath,/usr/lib/openmpi/lib /usr/lib/openmpi/lib/libmpi_usempif08.so /usr/lib/openmpi/lib/libmpi_usempi_ignore_tkr.so /usr/lib/openmpi/lib/libmpi_mpifh.so /usr/lib/openmpi/lib/libmpi.so

