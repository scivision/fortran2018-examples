# MUMPS -- use cmake -DMUMPS_ROOT= for hint.
#
# Intel MKL-compiled MUMPS requires at the linker for the main executable:
# mkl_scalapack_lp64 mkl_blacs_intelmpi_lp64 mkl_intel_lp64 mkl_intel_thread mkl_core
#
# easily obtain MUMPS without compiling:
# CentOS 6/7 EPEL: yum install mumps-devel
# Ubuntu / Debian: apt install libmumps-dev

if(LIB_DIR OR USEMKL OR CMAKE_Fortran_COMPILER_ID STREQUAL Intel)
  #set(METIS_ROOT ${LIB_DIR}/metis)
  #set(Scotch_ROOT ${LIB_DIR}/scotch)

  #find_package(METIS)
  #find_package(Scotch COMPONENTS ESMUMPS)
  find_package(SCALAPACK REQUIRED COMPONENTS IntelPar)

  set(MUMPS_ROOT ${LIB_DIR}/MUMPS)
endif()


if(realbits EQUAL 64)
  set(mumpscomp d)
elseif(realbits EQUAL 32)
  set(mumpscomp s)
else()
  message(FATAL_ERROR "MUMPS has only real32, real64")
endif()

if(NOT SCALAPACK_FOUND)
  find_package(SCALAPACK REQUIRED)
  find_package(LAPACK REQUIRED)
endif()

find_package(MUMPS REQUIRED COMPONENTS ${mumpscomp})
if(LIB_DIR)
  list(APPEND MUMPS_LIBRARIES ${SCALAPACK_LIBRARIES} ${LAPACK_LIBRARIES})
endif()
