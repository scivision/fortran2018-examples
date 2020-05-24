# Distributed under the OSI-approved BSD 3-Clause License.  See accompanying
# file Copyright.txt or https://cmake.org/licensing for details.

#[=======================================================================[.rst:
FindCoarray
----------

Finds compiler flags or library necessary to support Fortran 2008/2018 coarrays.

This packages primary purposes are:

* for compilers natively supporting Fortran coarrays without needing compiler options, simply indicating Coarray_FOUND  (example: Cray)
* for compilers with built-in Fortran coarray support, enable compiler option (example: Intel Fortran)
* for compilers needing a library such as OpenCoarrays, presenting library (example: GNU)


Result Variables
^^^^^^^^^^^^^^^^

``Coarray_FOUND``
  indicates coarray support found (whether built-in or library)

``Coarray_LIBRARIES``
  coarray library path
``Coarray_COMPILE_OPTIONS``
  coarray compiler options
``Coarray_EXECUTABLE``
  coarray executable e.g. ``cafrun``
``Coarray_MAX_NUMPROCS``
  maximum number of parallel processes
``Coarray_NUMPROC_FLAG``
  use for executing in parallel: ${Coarray_EXECUTABLE} ${Coarray_NUMPROC_FLAG} ${Coarray_MAX_NUMPROCS} ${CMAKE_CURRENT_BINARY_DIR}/myprogram

Cache Variables
^^^^^^^^^^^^^^^^

The following cache variables may also be set:

``Coarray_LIBRARY``
  The coarray libraries, if needed and found
#]=======================================================================]

set(options_coarray Intel NAG)  # flags needed
set(opencoarray_supported GNU)

unset(Coarray_COMPILE_OPTIONS)
unset(Coarray_LIBRARY)
unset(Coarray_REQUIRED_VARS)

if(CMAKE_Fortran_COMPILER_ID IN_LIST options_coarray)

  if(CMAKE_Fortran_COMPILER_ID STREQUAL Intel)
    if(WIN32)
      set(Coarray_COMPILE_OPTIONS /Qcoarray:shared)
      set(Coarray_REQUIRED_VARS ${Coarray_COMPILE_OPTIONS})
    elseif(UNIX AND NOT APPLE)
      set(Coarray_COMPILE_OPTIONS -coarray=shared)
      set(Coarray_LIBRARY -coarray=shared)  # ifort requires it at build AND link
      set(Coarray_REQUIRED_VARS ${Coarray_LIBRARY})
    endif()
  elseif(CMAKE_Fortran_COMPILER_ID STREQUAL NAG)
    set(Coarray_COMPILE_OPTIONS -coarray)
    set(Coarray_REQUIRED_VARS ${Coarray_COMPILE_OPTIONS})
  endif()

elseif(CMAKE_Fortran_COMPILER_ID IN_LIST opencoarray_supported)

  find_package(OpenCoarrays QUIET)
  if(OpenCoarrays_FOUND)
    set(Coarray_LIBRARY OpenCoarrays::caf_mpi)
  endif()

  if(NOT Coarray_LIBRARY)
    find_package(PkgConfig)
    pkg_check_modules(pc_caf caf)
    if(NOT pc_caf_FOUND)
      pkg_check_modules(pc_caf caf-openmpi)
    endif()

    find_library(Coarray_LIBRARY
      NAMES ${pc_caf_LIBRARIES}
      HINTS ${pc_caf_LIBRARY_DIRS})

    find_path(Coarray_INCLUDE_DIR
      NAMES opencoarrays.mod
      HINTS ${pc_caf_INCLUDE_DIRS})

    if(CMAKE_Fortran_COMPILER_ID STREQUAL GNU)
      set(Coarray_COMPILE_OPTIONS -fcoarray=lib)
    endif()

    set(Coarray_REQUIRED_VARS ${Coarray_LIBRARY})
  endif(NOT Coarray_LIBRARY)

endif()

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(Coarray
  REQUIRED_VARS Coarray_REQUIRED_VARS)

if(Coarray_FOUND)
  set(Coarray_LIBRARIES ${Coarray_LIBRARY})
  set(Coarray_INCLUDE_DIRS ${Coarray_INCLUDE_DIR})

  if(NOT DEFINED Coarray::Coarray)

    if(Coarray_LIBRARY)
      add_library(Coarray::Coarray IMPORTED UNKNOWN)
      set_target_properties(Coarray::Coarray PROPERTIES IMPORTED_LOCATION ${Coarray_LIBRARY})
    else()  # flags only
      add_library(Coarray::Coarray INTERFACE IMPORTED)
    endif()

    if(Coarray_INCLUDE_DIR)
      set_target_properties(Coarray::Coarray PROPERTIES INTERFACE_INCLUDE_DIRECTORIES ${Coarray_INCLUDE_DIR})
    endif()
    if(Coarray_COMPILE_OPTIONS)
      set_target_properties(Coarray::Coarray PROPERTIES INTERFACE_COMPILE_OPTIONS ${Coarray_COMPILE_OPTIONS})
    endif()
  endif()
endif()

mark_as_advanced(
  Coarray_LIBRARY
  Coarray_INCLUDE_DIR
  Coarray_REQUIRED_VARS
)
