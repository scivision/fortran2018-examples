cmake_minimum_required (VERSION 2.8.12)
project(fortran2018demo Fortran)

# ------- Fortran 2018 coarray examples -------
# Coarrays are easier to use than MPI and more general as an intrinsic part of Fortran 2008.
# this requires libcoarrays-dev, which is in Ubuntu 17.04 and newer.
# or use Intel mpif90
#add_executable(hello coarray_helloworld.f90)

# ------- MPI Fortran examples ----------------
find_package(MPI)
if(MPI_Fortran_COMPILER)   # MPI_FOUND is not used
    # DON'T USE WRAPPER COMPILER AND FLAGS -- one or the other!
    #set(CMAKE_Fortran_COMPILER ${MPI_Fortran_COMPILER}) #wrapper compiler mpif90
    # consider mpif90 --showme
    # https://www.open-mpi.org/faq/?category=mpi-apps

    add_definitions(${MPI_Fortran_COMPILE_FLAGS})
    include_directories(${MPI_Fortran_INCLUDE_PATH})
  #  add_compile_options(${MPI_Fortran_LINK_FLAGS} -pthread)
    add_compile_options(-pthread)

#    message(STATUS "MPI_Fortran_LIBRARIES " ${MPI_Fortran_LIBRARIES})

    add_executable(mpi_hello mpi_helloworld.f90)
    target_link_libraries(mpi_hello ${MPI_Fortran_LIBRARIES})

    add_executable(pass mpi_pass.f90)
    target_link_libraries(pass ${MPI_Fortran_LIBRARIES})
else()
    message(WARNING "MPI not setup" ${MPI_Fortran_COMPILE_FLAGS})
endif()


# mpifort --showme
#
# gfortran -I/usr/lib/openmpi/include -pthread -I/usr/lib/openmpi/lib -Wl,-rpath -Wl,/usr/lib/openmpi/lib -Wl,--enable-new-dtags -L/usr/lib/openmpi/lib -lmpi_usempif08 -lmpi_usempi_ignore_tkr -lmpi_mpifh -lmpi

# make VERBOSE=1
#
#/usr/bin/f95  -I/usr/lib/openmpi/include -I/usr/lib/openmpi/lib  -Wl,-rpath,/usr/lib/openmpi/lib /usr/lib/openmpi/lib/libmpi_usempif08.so /usr/lib/openmpi/lib/libmpi_usempi_ignore_tkr.so /usr/lib/openmpi/lib/libmpi_mpifh.so /usr/lib/openmpi/lib/libmpi.so

