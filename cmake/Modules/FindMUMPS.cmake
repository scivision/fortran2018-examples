# Distributed under the OSI-approved BSD 3-Clause License.  See accompanying
# file Copyright.txt or https://cmake.org/licensing for details.

#[=======================================================================[.rst:
FindMUMPS
---------

Finds the MUMPS library.
Note that MUMPS generally requires SCALAPACK and LAPACK as well.

COMPONENTS
  s d c z   list one or more. Defaults to ``d``.

Result Variables
^^^^^^^^^^^^^^^^

MUMPS_LIBRARIES
  libraries to be linked

MUMPS_INCLUDE_DIRS
  dirs to be included

#]=======================================================================]

function(mumps_libs)

FOREACH(comp ${MUMPS_FIND_COMPONENTS})
  find_library(MUMPS_${comp}_lib
              NAMES ${comp}mumps)

  if(NOT MUMPS_${comp}_lib)
    message(WARNING "MUMPS ${comp} not found")
    return()
  endif()

  list(APPEND MUMPS_LIBRARY ${MUMPS_${comp}_lib})
ENDFOREACH()

set(MUMPS_LIBRARY ${MUMPS_LIBRARY} PARENT_SCOPE)

endfunction()

if(NOT MUMPS_FIND_COMPONENTS)
  set(MUMPS_FIND_COMPONENTS d)
endif()

find_path(MUMPS_INCLUDE_DIR
          NAMES mumps_compat.h
          DOC "MUMPS common header")

find_library(MUMPS_COMMON
             NAMES mumps_common
             DOC "MUMPS common libraries")

find_library(PORD
             NAMES pord
             DOC "simplest MUMPS ordering library")


mumps_libs()


if(MUMPS_LIBRARY)
  set(MUMPS_OK true)
  include(CheckFortranFunctionExists)
  set(CMAKE_REQUIRED_INCLUDES ${MUMPS_INCLUDE_DIR})
  set(CMAKE_REQUIRED_LIBRARIES ${MUMPS_LIBRARY})
  foreach(c ${MUMPS_FIND_COMPONENTS})
    check_fortran_function_exists(${c}mumps _${c}_ok)
    if(NOT _${c}_ok)
      set(MUMPS_OK false)
      break()
    endif()
  endforeach()
endif()

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(MUMPS
  REQUIRED_VARS MUMPS_LIBRARY MUMPS_COMMON PORD MUMPS_INCLUDE_DIR MUMPS_OK)

# in this order!
if(MUMPS_FOUND)
  set(MUMPS_LIBRARIES ${MUMPS_LIBRARY} ${MUMPS_COMMON} ${PORD})
  set(MUMPS_INCLUDE_DIRS ${MUMPS_INCLUDE_DIR})
endif()

mark_as_advanced(MUMPS_INCLUDE_DIR MUMPS_LIBRARY)

