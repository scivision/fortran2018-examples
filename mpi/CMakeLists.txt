cmake_minimum_required (VERSION 2.8.12)
project(fortran2015demo Fortran) 

# ------- MPI Fortran examples ----------------
find_package(MPI)
if(MPI_Fortran_COMPILER)   # MPI_FOUND is not used
    # DON'T USE WRAPPER COMPILER AND FLAGS -- one or the other!
    #set(CMAKE_Fortran_COMPILER ${MPI_Fortran_COMPILER}) #wrapper compiler mpif90
    # consider mpif90 --showme
    # https://www.open-mpi.org/faq/?category=mpi-apps
    
    add_definitions(${MPI_Fortran_COMPILE_FLAGS})
    include_directories(${MPI_Fortran_INCLUDE_PATH})
    add_compile_options(${MPI_Fortran_LINK_FLAGS} -pthread)
    
#    message(STATUS "MPI_Fortran_LIBRARIES " ${MPI_Fortran_LIBRARIES})

    add_executable(hello mpi_helloworld.f90)
    target_link_libraries(hello ${MPI_Fortran_LIBRARIES})

    add_executable(pass mpi_pass.f90)
    target_link_libraries(pass ${MPI_Fortran_LIBRARIES})
else()
    message(WARNING "MPI not setup" ${MPI_Fortran_COMPILE_FLAGS})
endif()


# mpif90 --showme
#
# gfortran -I/usr/lib/openmpi/include -pthread -I/usr/lib/openmpi/lib -Wl,-rpath -Wl,/usr/lib/openmpi/lib -Wl,--enable-new-dtags -L/usr/lib/openmpi/lib -lmpi_usempif08 -lmpi_usempi_ignore_tkr -lmpi_mpifh -lmp
