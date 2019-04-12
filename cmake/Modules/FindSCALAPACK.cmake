# https://github.com/certik/hermes/blob/master/hermes_common/cmake/FindSCALAPACK.cmake
# ScaLAPACK and BLACS

# USEMKL: Using MKL with GNU or other compiler

cmake_policy(VERSION 3.3)

unset(SCALAPACK_LIBRARY)
unset(SCALAPACK_OpenMPI_FOUND)
unset(SCALAPACK_MPICH_FOUND)

if(NOT SCALAPACK_FIND_COMPONENTS)
  set(SCALAPACK_FIND_COMPONENTS OpenMPI)
endif()

function(mkl_scala)
# https://software.intel.com/en-us/articles/intel-mkl-link-line-advisor

set(_mkl_libs ${ARGV})
if(NOT WIN32 AND CMAKE_Fortran_COMPILER_ID STREQUAL GNU AND Fortran IN_LIST project_languages)
  list(INSERT _mkl_libs 0 mkl_gf_lp64)
endif()

foreach(s ${_mkl_libs})
  find_library(SCALAPACK_${s}_LIBRARY
           NAMES ${s}
           PATHS ENV MKLROOT
           PATH_SUFFIXES
             lib lib/intel64 lib/intel64_win
             ../compiler/lib ../compiler/lib/intel64 ../compiler/lib/intel64_win
             ../mpi/intel64/lib ../mpi/intel64/lib/release ../mpi/intel64/lib/release_mt
           HINTS ${MKL_LIBRARY_DIRS}
           NO_DEFAULT_PATH)
  if(NOT SCALAPACK_${s}_LIBRARY)
    message(FATAL_ERROR "NOT FOUND: " ${s})
  endif()

  list(APPEND SCALAPACK_LIB ${SCALAPACK_${s}_LIBRARY})
endforeach()

if(NOT WIN32)
  list(APPEND SCALAPACK_LIB ${CMAKE_THREAD_LIBS_INIT} ${CMAKE_DL_LIBS} m)
endif()
set(SCALAPACK_LIBRARY ${SCALAPACK_LIB} PARENT_SCOPE)
set(SCALAPACK_INCLUDE_DIR $ENV{MKLROOT}/include ${MKL_INCLUDE_DIRS} PARENT_SCOPE)

endfunction()

#===================================================================

get_property(project_languages GLOBAL PROPERTY ENABLED_LANGUAGES)

find_package(PkgConfig QUIET)
if(NOT WIN32)
  find_package(Threads)  # not required--for example Flang
endif()

if(BUILD_SHARED_LIBS)
  set(_mkltype dynamic)
else()
  set(_mkltype static)
endif()

if(WIN32)
  set(_impi impi)
  set(_mp libiomp5md)  # "lib" is indeed necessary, verified by multiple people on CMake 3.14.0
else()
  unset(_impi)
  set(_mp iomp5)
endif()

if(IntelPar IN_LIST SCALAPACK_FIND_COMPONENTS)

  pkg_check_modules(MKL mkl-${_mkltype}-lp64-iomp)

  mkl_scala(mkl_scalapack_lp64 mkl_intel_lp64 mkl_intel_thread mkl_core mkl_blacs_intelmpi_lp64 ${_impi} ${_mp})

  if(SCALAPACK_LIBRARY)
    set(SCALAPACK_IntelPar_FOUND true)
  endif()

elseif(IntelSeq IN_LIST SCALAPACK_FIND_COMPONENTS)

  pkg_check_modules(MKL mkl-${_mkltype}-lp64-seq)

  mkl_scala(mkl_scalapack_lp64 mkl_intel_lp64 mkl_sequential mkl_core mkl_blacs_intelmpi_lp64 ${_impi})

  if(SCALAPACK_LIBRARY)
    set(SCALAPACK_IntelSeq_FOUND true)
  endif()

elseif(OpenMPI IN_LIST SCALAPACK_FIND_COMPONENTS)

  pkg_check_modules(SCALAPACK scalapack-openmpi)

  find_library(SCALAPACK_LIBRARY
               NAMES scalapack scalapack-openmpi
               PATH_SUFFIXES lib
               HINTS ${SCALAPACK_LIBRARY_DIRS})

  if(SCALAPACK_LIBRARY)
    set(SCALAPACK_OpenMPI_FOUND true)
  endif()

elseif(MPICH IN_LIST SCALAPACK_FIND_COMPONENTS)
  find_library(SCALAPACK_LIBRARY
               NAMES scalapack-mpich scalapack-mpich2
               PATH_SUFFIXES lib)

  if(SCALAPACK_LIBRARY)
    set(SCALAPACK_MPICH_FOUND true)
  endif()

endif()
#=================================================

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(
  SCALAPACK
  REQUIRED_VARS SCALAPACK_LIBRARY
  HANDLE_COMPONENTS)

if(SCALAPACK_FOUND)
  set(SCALAPACK_LIBRARIES ${SCALAPACK_LIBRARY})
  set(SCALAPACK_INCLUDE_DIRS ${SCALAPACK_INCLUDE_DIR})
endif()

mark_as_advanced(SCALAPACK_LIBRARY SCALAPACK_INCLUDE_DIR)

