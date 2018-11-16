cmake_minimum_required (VERSION 3.3)
project(fortran2018array Fortran C)  # C is NECESSARY for MKL detection!
enable_testing()

get_directory_property(hasParent PARENT_DIRECTORY)
if(NOT hasParent)
  set(f2008 Cray GNU Intel NAG)
  include(../cmake/compilers.cmake)
endif()
#=== Lapack95 MKL Example with Intel OR Gfortran compilers ===
set(BLA_F95 ON)

if(MKL)
  # be sure you have from terminal:
  # . $MKLROOT/mklvars.sh"
  
  if(NOT ${CMAKE_Fortran_COMPILER_ID} STREQUAL Intel)
    # be sure Lapack95 is build for your compiler
    if(FC)
      # no "-j" make option ...=.
      execute_process(COMMAND make libintel64 INSTALL_DIR=${CMAKE_CURRENT_BINARY_DIR} interface=lp64 FC=${FC}
                    WORKING_DIRECTORY $ENV{MKLROOT}/interfaces/lapack95
                    )
    else()
      message(FATAL_ERROR "specify compiler, e.g.: FC=gfortran cmake -DMKL=on ..")
    endif()
  endif()
  
  
  set(BLA_VENDOR Intel10_64lp_seq)
  find_package(LAPACK)
  
  # make sure include_dirs "lp64" or "ilp64" matches BLA_VENDOR
  if(${CMAKE_Fortran_COMPILER_ID} STREQUAL Intel)
    set(LAPACK95_INCLUDE_DIRS $ENV{MKLROOT}/include/intel64/lp64)
    
    list(INSERT LAPACK95_LIBRARIES 0 $ENV{MKLROOT}/lib/intel64_lin/libmkl_lapack95_lp64.a)
  else()
    set(LAPACK95_INCLUDE_DIRS ${CMAKE_CURRENT_BINARY_DIR}/include/intel64/lp64)
    
    list(INSERT LAPACK95_LIBRARIES 0 ${CMAKE_CURRENT_BINARY_DIR}/lib/intel64/libmkl_lapack95_lp64.a)
  endif()

endif()


if(LAPACK95_FOUND)
  add_executable(svd intel_gesvd.f90)
  target_link_libraries(svd PRIVATE ${LAPACK95_LIBRARIES} ${FLIBS})
  target_include_directories(svd PRIVATE ${LAPACK95_INCLUDE_DIRS})
  target_compile_options(svd PRIVATE ${FFLAGS} ${LAPACK_LINKER_FLAGS})
  add_test(NAME FortranSVD COMMAND svd)
endif()

#=== LAPACK MKL example with Intel OR Gfortran compilers ===
set(BLA_F95 OFF)
find_package(LAPACK)

if(LAPACK_FOUND)
  add_executable(dsvd intel_dgesvd.f90)
  target_link_libraries(dsvd PRIVATE ${LAPACK_LIBRARIES} ${FLIBS})
  target_include_directories(dsvd PRIVATE ${LAPACK_INCLUDE_DIRS})
  add_test(NAME FortranDsvd COMMAND dsvd)
endif()

if(CMAKE_Fortran_COMPILER_ID IN_LIST f2008)

  # ------- rot90, flip --------
  add_library(rotflip rot90.f90)
  target_compile_options(rotflip PRIVATE ${FFLAGS})
  target_link_libraries(rotflip PRIVATE ${FLIBS})

  add_executable(rotflip_test test_rot90.f90)
  target_link_libraries(rotflip_test rotflip ${FLIBS})
  target_compile_options(rotflip_test PRIVATE ${FFLAGS})
  add_test(NAME RotFlip COMMAND rotflip_test)
  #---
endif()
