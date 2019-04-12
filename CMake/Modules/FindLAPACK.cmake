# Distributed under the OSI-approved BSD 3-Clause License.  See accompanying
# file Copyright.txt or https://cmake.org/licensing for details.

#[=======================================================================[.rst:

FindLapack
----------

* Michael Hirsch, Ph.D. www.scivision.dev
* David Eklund

Let Michael know if there are more MKL / Lapack / compiler combination you want.
Refer to https://software.intel.com/en-us/articles/intel-mkl-link-line-advisor

Finds LAPACK libraries for C / C++ / Fortran.
Works with Netlib Lapack / LapackE, Atlas and Intel MKL.
Intel MKL relies on having environment variable MKLROOT set, typically by sourcing
mklvars.sh beforehand.

Why not the FindLapack.cmake built into CMake? It has a lot of old code for
infrequently used Lapack libraries and is unreliable for me.

Tested on Linux, MacOS and Windows with:
* GCC / Gfortran
* Clang / Flang
* PGI (pgcc, pgfortran)
* Intel (icc, ifort)


Parameters
^^^^^^^^^^

COMPONENTS default to Netlib LAPACK / LapackE, otherwise:

``IntelPar``
  Intel MKL with Intel OpenMP for ICC, GCC and PGCC
``IntelPar95``
  Intel MKL Lapack95 with intel OpenMP
``IntelSeq``
  Intel MKL without threading for ICC, GCC, and PGCC
``MKL64``
  MKL only: 64-bit integers  (default is 32-bit integers)

``LAPACKE``
  Netlib LapackE for C / C++

``LAPACK95``
  Netlib Lapack95


Result Variables
^^^^^^^^^^^^^^^^

``LAPACK_FOUND``
  Lapack libraries were found
``LAPACK_<component>_FOUND``
  LAPACK <component> specified was found
``LAPACK_LIBRARIES``
  Lapack library files (including BLAS
``LAPACK_INCLUDE_DIRS``
  Lapack include directories (for C/C++)


References
^^^^^^^^^^

* Pkg-Config and MKL:  https://software.intel.com/en-us/articles/intel-math-kernel-library-intel-mkl-and-pkg-config-tool
* MKL for Windows: https://software.intel.com/en-us/mkl-windows-developer-guide-static-libraries-in-the-lib-intel64-win-directory
* MKL Windows directories: https://software.intel.com/en-us/mkl-windows-developer-guide-high-level-directory-structure
* Atlas http://math-atlas.sourceforge.net/errata.html#LINK
#]=======================================================================]


cmake_policy(VERSION 3.3)

function(mkl_libs)
# https://software.intel.com/en-us/articles/intel-mkl-link-line-advisor

set(_mkl_libs ${ARGV})
if(NOT WIN32 AND CMAKE_Fortran_COMPILER_ID STREQUAL GNU AND Fortran IN_LIST project_languages)
  list(INSERT _mkl_libs 0 mkl_gf_${_mkl_bitflag}lp64)
endif()

foreach(s ${_mkl_libs})
  find_library(LAPACK_${s}_LIBRARY
           NAMES ${s}
           PATHS ENV MKLROOT
           PATH_SUFFIXES
             lib lib/intel64 lib/intel64_win
             ../compiler/lib ../compiler/lib/intel64 ../compiler/lib/intel64_win
           HINTS ${MKL_LIBRARY_DIRS}
           NO_DEFAULT_PATH)
  if(NOT LAPACK_${s}_LIBRARY)
    message(FATAL_ERROR "MKL component not found: " ${s})
  endif()

  list(APPEND LAPACK_LIB ${LAPACK_${s}_LIBRARY})
endforeach()

if(NOT BUILD_SHARED_LIBS AND (UNIX AND NOT APPLE))
  set(LAPACK_LIB -Wl,--start-group ${LAPACK_LIB} -Wl,--end-group)
endif()

if(NOT WIN32)
  list(APPEND LAPACK_LIB ${CMAKE_THREAD_LIBS_INIT} ${CMAKE_DL_LIBS} m)
endif()

set(LAPACK_LIBRARY ${LAPACK_LIB} PARENT_SCOPE)
set(LAPACK_INCLUDE_DIR
  $ENV{MKLROOT}/include
  $ENV{MKLROOT}/include/intel64/${_mkl_bitflag}lp64
  ${MKL_INCLUDE_DIRS}
  PARENT_SCOPE)

endfunction()

#===============================================================================

get_property(project_languages GLOBAL PROPERTY ENABLED_LANGUAGES)

find_package(PkgConfig QUIET)
if(NOT WIN32)
  find_package(Threads)  # not required--for example Flang
endif()
# ==== generic MKL variables ====
if(BUILD_SHARED_LIBS)
  set(_mkltype dynamic)
else()
  set(_mkltype static)
endif()


set(_mkl_bitflag)
if(MKL64 IN_LIST LAPACK_FIND_COMPONENTS)
  set(_mkl_bitflag i)
endif()

if(WIN32)
  set(_mp libiomp5md)  # "lib" is indeed necessary, verified by multiple people on CMake 3.14.0
else()
  set(_mp iomp5)
endif()

#====================================

if(IntelPar IN_LIST LAPACK_FIND_COMPONENTS)
  pkg_check_modules(MKL mkl-${_mkltype}-${_mkl_bitflag}lp64-iomp)

  mkl_libs(mkl_intel_${_mkl_bitflag}lp64 mkl_intel_thread mkl_core ${_mp})

  if(LAPACK_LIBRARY)
    set(LAPACK_IntelPar_FOUND true)
    if(MKL64 IN_LIST LAPACK_FIND_COMPONENTS)
      set(LAPACK_MKL64_FOUND true)
    endif()
  endif()
elseif(IntelPar95 IN_LIST LAPACK_FIND_COMPONENTS)

  mkl_libs(mkl_blas95_${_mkl_bitflag}lp64 mkl_lapack95_${_mkl_bitflag}lp64
    mkl_intel_${_mkl_bitflag}lp64 mkl_intel_thread mkl_core ${_mp})

  if(LAPACK_LIBRARY)
    set(LAPACK_IntelPar95_FOUND true)
    if(MKL64 IN_LIST LAPACK_FIND_COMPONENTS)
      set(LAPACK_MKL64_FOUND true)
    endif()
  endif()

elseif(IntelSeq IN_LIST LAPACK_FIND_COMPONENTS)
  pkg_check_modules(MKL mkl-${_mkltype}-${_mkl_bitflag}lp64-seq)

  mkl_libs(mkl_intel_${_mkl_bitflag}lp64 mkl_sequential mkl_core)

  if(LAPACK_LIBRARY)
    set(LAPACK_IntelSeq_FOUND true)
    if(MKL64 IN_LIST LAPACK_FIND_COMPONENTS)
      set(LAPACK_MKL64_FOUND true)
    endif()
  endif()
elseif(Atlas IN_LIST LAPACK_FIND_COMPONENTS)

  find_library(ATLAS_LIB
    NAMES atlas)

  pkg_check_modules(LAPACK_ATLAS lapack-atlas)
  find_library(LAPACK_ATLAS
    NAMES ptlapack lapack_atlas lapack
    HINTS ${LAPACK_ATLAS_LIBRARY_DIRS})

  pkg_check_modules(LAPACK_BLAS blas-atlas)
  find_library(BLAS_ATLAS
    NAMES ptf77blas f77blas blas
    HINTS ${LAPACK_BLAS_LIBRARY_DIRS})
 # === C ===
  find_library(BLAS_C_ATLAS
    NAMES ptcblas cblas
    HINTS ${LAPACK_BLAS_LIBRARY_DIRS})

  find_path(LAPACK_INCLUDE_DIR
    NAMES cblas.h clapack.h
    HINTS ${LAPACK_BLAS_INCLUDE_DIRS})

#===========
  if(LAPACK_ATLAS AND BLAS_C_ATLAS AND BLAS_ATLAS AND ATLAS_LIB)
    set(LAPACK_Atlas_FOUND true)
  else()
    set(LAPACK_Atlas_FOUND false)
  endif()

  set(LAPACK_LIBRARY ${LAPACK_ATLAS} ${BLAS_C_ATLAS} ${BLAS_ATLAS} ${ATLAS_LIB})
  if(NOT WIN32)
    list(APPEND LAPACK_LIBRARY ${CMAKE_THREAD_LIBS_INIT})
  endif()

else()  # find base LAPACK and BLAS, typically Netlib

  if(LAPACK95 IN_LIST LAPACK_FIND_COMPONENTS)
    find_path(LAPACK95_INCLUDE_DIR
                NAMES f95_lapack.mod
                PATHS ${LAPACK95_ROOT}
                PATH_SUFFIXES include)

    find_library(LAPACK95_LIBRARY
                   NAMES lapack95
                   PATHS ${LAPACK95_ROOT}
                   PATH_SUFFIXES lib)

    if(LAPACK95_LIBRARY)
      set(LAPACK_INCLUDE_DIR ${LAPACK95_INCLUDE_DIR})
      set(LAPACK_LAPACK95_FOUND true)
      set(LAPACK_LIBRARY ${LAPACK95_LIBRARY})
    endif()
  else()
    unset(LAPACK_LIBRARY)
  endif()

  pkg_check_modules(LAPACK lapack-netlib)
  find_library(LAPACK_LIB
    NAMES lapack
    HINTS ${LAPACK_LIBRARY_DIRS})

  if(LAPACKE IN_LIST LAPACK_FIND_COMPONENTS)
    pkg_check_modules(LAPACKE lapacke)
    find_library(LAPACKE_LIBRARY
      NAMES lapacke # lapack  # FIXME: PGI lapack.lib has lapackE
      HINTS ${LAPACKE_LIBRARY_DIRS})

    find_path(LAPACKE_INCLUDE_DIR
      NAMES lapacke.h
      HINTS ${LAPACKE_INCLUDE_DIRS})

    if(LAPACKE_LIBRARY)
      set(LAPACK_LAPACKE_FOUND true)
      list(APPEND LAPACK_INCLUDE_DIR ${LAPACKE_INCLUDE_DIR})
      list(APPEND LAPACK_LIBRARY ${LAPACKE_LIBRARY})
    else()
      set(LAPACK_LAPACKE_FOUND false)
    endif()
  endif()

  pkg_check_modules(BLAS openblas)
  find_library(BLAS_LIBRARY
    NAMES refblas blas
    HINTS ${BLAS_LIBRARY_DIRS})

  mark_as_advanced(BLAS_LIBRARY)

  list(APPEND LAPACK_LIBRARY ${LAPACK_LIB} ${BLAS_LIBRARY})
  if(NOT WIN32)
    list(APPEND LAPACK_LIBRARY ${CMAKE_THREAD_LIBS_INIT})
  endif()
endif()

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(
  LAPACK
  REQUIRED_VARS LAPACK_LIBRARY
  HANDLE_COMPONENTS)

if(LAPACK_FOUND)
  set(LAPACK_LIBRARIES ${LAPACK_LIBRARY})
  set(LAPACK_INCLUDE_DIRS ${LAPACK_INCLUDE_DIR})

#  if(LAPACK_LAPACKE_FOUND AND NOT TARGET LAPACK::LAPACKE)
#    add_library(LAPACK::LAPACKE UNKNOWN IMPORTED)
#    set_target_properties(LAPACK::LAPACKE PROPERTIES
#      IMPORTED_LOCATION ${LAPACKE_LIBRARY}
#      INTERFACE_INCLUDE_DIRECTORIES ${LAPACK_INCLUDE_DIR})
#  endif()

#  if(NOT TARGET LAPACK::LAPACK)
#    add_library(LAPACK::LAPACK UNKNOWN IMPORTED)
#    set_target_properties(LAPACK::LAPACK PROPERTIES
#      IMPORTED_LOCATION ${LAPACK_LIB})
#  endif()

#  if(NOT TARGET LAPACK::BLAS)
#    add_library(LAPACK::BLAS UNKNOWN IMPORTED)
#    set_target_properties(LAPACK::BLAS PROPERTIES
#      IMPORTED_LOCATION ${BLAS_LIBRARY})
#  endif()
endif()

mark_as_advanced(LAPACK_LIBRARY LAPACK_INCLUDE_DIR)
