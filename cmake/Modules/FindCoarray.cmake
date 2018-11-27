# Distributed under the OSI-approved BSD 3-Clause License.  See accompanying
# file Copyright.txt or https://cmake.org/licensing for details.

#[=======================================================================[.rst:
FindCoarray
----------

Finds compiler flags or library necessary to support Fortran 2008/2018 coarrays.

This packages primary purposes are:

* for compilers natively supporting Fortran coarrays without needing compiler options, simply indicating Coarray_FOUND  (example: Cray)
* for compilers with built-in Fortran coarray support, present compiler options to enable (example: Intel Fortran)
* for compilers needing a library such as OpenCoarrays, presenting library (example: GNU)


Module Input Variables
^^^^^^^^^^^^^^^^^^^^^^

Users or projects may set the following variables to configure the module behaviour:

:variable:`Coarray_ROOT`
  the root of the coarray library installation.

Variables defined by the module
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Result variables
""""""""""""""""

``Coarray_FOUND``
  ``TRUE`` if coarray support is found (whether built-in or library), ``FALSE`` otherwise.


``Coarray_LIBRARIES``
  coarray library path
``Coarray_COMPILE_OPTIONS``
  coarray compiler options
``Coarray_EXECUTABLE``
  coarray executable e.g. ``cafrun``
``Coarray_MAX_NUMPROCS``
  maximum number of parallel processes 
``Coarray_NUMPROC_FLAG``
  use as ${Coarray_EXECUTABLE} ${Coarray_NUMPROC_FLAG} ${Coarray_MAX_NUMPROCS}
#]=======================================================================]

cmake_policy(VERSION 3.3)

set(options_coarray Intel)  # flags needed
set(opencoarray_supported GNU)  # future: Flang, etc.

unset(Coarray_COMPILE_OPTIONS)
unset(Coarray_LIBRARY)

if(CMAKE_Fortran_COMPILER_ID IN_LIST options_coarray)

  if(CMAKE_Fortran_COMPILER_ID STREQUAL Intel)
    set(Coarray_COMPILE_OPTIONS -coarray=shared)
    set(Coarray_LIBRARY -coarray=shared)
  endif()

elseif(CMAKE_Fortran_COMPILER_ID IN_LIST opencoarray_supported)

  find_package(OpenCoarrays)

  if(OpenCoarrays_FOUND)
    set(Coarray_LIBRARY OpenCoarrays::caf_mpi)

    set(Coarray_EXECUTABLE cafrun)

    include(ProcessorCount)
    ProcessorCount(Nproc)
    set(Coarray_MAX_NUMPROCS ${Nproc})
    set(Coarray_NUMPROC_FLAG -np)
  elseif(CMAKE_Fortran_COMPILER_ID STREQUAL GNU)
    set(Coarray_LIBRARY -fcoarray=single)
  endif()

endif()


set(CMAKE_REQUIRED_FLAGS ${Coarray_COMPILE_OPTIONS})
set(CMAKE_REQUIRED_LIBRARIES ${Coarray_LIBRARY})
include(CheckFortranSourceCompiles)
check_fortran_source_compiles("program cs; real :: x[*]; end" f08coarray SRC_EXT f90)
unset(CMAKE_REQUIRED_FLAGS)
unset(CMAKE_REQUIRED_LIBRARIES)

if(f08coarray)
  set(Coarray_LIBRARIES ${Coarray_LIBRARY})
endif()

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(Coarray
  REQUIRED_VARS Coarray_LIBRARIES)

mark_as_advanced(
  Coarray_LIBRARY
  Coarray_LIBRARIES
  Coarray_COMPILE_OPTIONS
)
