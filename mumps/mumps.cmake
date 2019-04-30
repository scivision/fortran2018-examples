# MUMPS -- use cmake -DMUMPS_ROOT= for hint.
#
# Intel MKL-compiled MUMPS requires at the linker for the main executable:
# mkl_scalapack_lp64 mkl_blacs_intelmpi_lp64 mkl_intel_lp64 mkl_intel_thread mkl_core
#
# easily obtain MUMPS without compiling:
# CentOS 6/7 EPEL: yum install mumps-devel
# Ubuntu / Debian: apt install libmumps-dev

if(LIB_DIR)
  set(MUMPS_ROOT ${LIB_DIR}/MUMPS)
endif()

if(BLACS_ROOT)
  find_package(BLACS)
  if(BLACS_FOUND)
    list(APPEND SCALAPACK_LIBRARIES ${BLACS_LIBRARIES})
  endif()
endif()


# Mumps
if(realbits EQUAL 64)
  set(mumpscomp d)
elseif(realbits EQUAL 32)
  set(mumpscomp s)
endif()

find_package(MUMPS COMPONENTS ${mumpscomp})
if(NOT MUMPS_FOUND)
  return()
endif()

list(APPEND MUMPS_LIBRARIES ${SCALAPACK_LIBRARIES} ${LAPACK_LIBRARIES})

#-- optional--normally we use PORD instead.
if(Scotch_ROOT)
  find_package(Scotch COMPONENTS ESMUMPS)
  if(Scotch_FOUND)
    list(APPEND MUMPS_LIBRARIES ${Scotch_LIBRARIES})
  endif()
endif()

if(METIS_ROOT)
  find_package(METIS)
  if(METIS_FOUND)
    list(APPEND MUMPS_LIBRARIES ${METIS_LIBRARIES})
  endif()
endif()
