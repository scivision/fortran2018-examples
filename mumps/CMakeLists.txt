cmake_minimum_required (VERSION 3.11)  # 3.9: MPI::MPI_Fortran, 3.11: Lapack
project(test_gem Fortran C)  # need C for scalapack findThreads with MKL/Intel
enable_testing()

# GNU with MKL (first compile https://github.com/scivision/fortran-libs with MKL)
# cmake -DLIB_DIR=~/flibs-gnu-mkl -DUSEMKL=yes ..

# LIB_DIR: top-level path for self-compiled libraries e.g. ~/flibs-gnu-MKL

option(USEMKL "Use Intel MKL libraries")

if($ENV{MKLROOT})
  set(USEMKL ON)
endif()

if(NOT realbits)
  set(realbits 64)
endif()

if(${CMAKE_VERSION} VERSION_GREATER_EQUAL "3.12.0")  # quotes are needed!
  cmake_policy(SET CMP0074 NEW)
endif()

get_directory_property(hasParent PARENT_DIRECTORY)
if(NOT hasParent)
  include(../cmake/compilers.cmake)
  list(APPEND CMAKE_MODULE_PATH ${PROJECT_SOURCE_DIR}/../cmake/Modules/)
endif()

#------------

include(${PROJECT_SOURCE_DIR}/../cmake/mumps.cmake)

if(CMAKE_Fortran_COMPILER_ID STREQUAL GNU)
  set(MPI_Fortran_COMPILER /usr/bin/mpif90)
endif()
find_package(MPI REQUIRED COMPONENTS Fortran)

add_executable(testmumps test_mumps.f90)
target_include_directories(testmumps PRIVATE ${MUMPS_INCLUDE_DIRS})
target_link_libraries(testmumps PRIVATE
                     ${MUMPS_LIBRARIES}
                     MPI::MPI_Fortran)
add_test(NAME MUMPS
  COMMAND ${MPIEXEC_EXECUTABLE} ${MPIEXEC_NUMPROC_FLAG} ${MPIEXEC_MAX_NUMPROCS} ${CMAKE_CURRENT_BINARY_DIR}/testmumps
  WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR})
  
  
  # manual:
# mpif90 -m64 ../test_mumps.f90 -I$HOME/flibs-gnu-mkl/MUMPS/include/ -L$HOME/flibs-gnu-mkl/MUMPS/lib -ldmumps -lmumps_common -lpord -L${MKLROOT}/lib/intel64 -Wl,--no-as-needed -lmkl_scalapack_lp64 -lmkl_intel_lp64 -lmkl_sequential -lmkl_core -lmkl_blacs_openmpi_lp64 -lpthread -lm -ldl -L$HOME/flibs-gnu-mkl/scotch/libs -lscotch -lesmumps -L$HOME/flibs-gnu-mkl/metis/build/Linux-x86_64/libmetis/ -lmetis

# CMake
# /usr/bin/f95    -m64 -I${MKLROOT}/include -I$HOME/flibs-gnu-mkl/MUMPS/include -I/usr/lib/x86_64-linux-gnu/openmpi/include -I/usr/lib/x86_64-linux-gnu/openmpi/lib ../test_mumps.f90  -o testmumps -Wl,-rpath,/usr/lib/x86_64-linux-gnu/openmpi/lib /home/thin/flibs-gnu-mkl/MUMPS/lib/libdmumps.a /home/thin/flibs-gnu-mkl/MUMPS/lib/libmumps_common.a /home/thin/flibs-gnu-mkl/MUMPS/lib/libpord.a -lmkl_scalapack_lp64 -lmkl_intel_lp64 -lmkl_sequential -lmkl_core -lmkl_blacs_intelmpi_lp64 -lpthread -ldl -lm /home/thin/flibs-gnu-mkl/scotch/lib/libesmumps.a /home/thin/flibs-gnu-mkl/scotch/lib/libscotch.a /home/thin/flibs-gnu-mkl/scotch/lib/libscotcherrexit.a /home/thin/flibs-gnu-mkl/metis/build/Linux-x86_64/libmetis/libmetis.a /usr/lib/x86_64-linux-gnu/libopenblas.so -lmkl_intel_lp64 -lmkl_intel_thread -lmkl_core /usr/lib/x86_64-linux-gnu/libiomp5.so -L/usr/lib -pthread /usr/lib/x86_64-linux-gnu/openmpi/lib/libmpi_usempif08.so /usr/lib/x86_64-linux-gnu/openmpi/lib/libmpi_usempi_ignore_tkr.so /usr/lib/x86_64-linux-gnu/openmpi/lib/libmpi_mpifh.so /usr/lib/x86_64-linux-gnu/openmpi/lib/libmpi.so 

