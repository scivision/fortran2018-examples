# Distributed under the OSI-approved BSD 3-Clause License.  See accompanying
# file Copyright.txt or https://cmake.org/licensing for details.

#[=======================================================================[.rst:
FindMUMPS
---------

Finds the MUMPS library.
Note that MUMPS generally requires SCALAPACK and LAPACK as well.
PORD is always used, in addition to the optional METIS or SCOTCH, which would be found externally.

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

find_path(MUMPS_INCLUDE_DIR
          NAMES mumps_compat.h
          DOC "MUMPS common header")
if(NOT MUMPS_INCLUDE_DIR)
  return()
endif()

find_library(MUMPS_COMMON
             NAMES mumps_common
             DOC "MUMPS common libraries")
if(NOT MUMPS_COMMON)
  return()
endif()

find_library(PORD
             NAMES pord
             DOC "simplest MUMPS ordering library")
if(NOT PORD)
  return()
endif()

foreach(comp ${MUMPS_FIND_COMPONENTS})
  find_library(MUMPS_${comp}_lib
               NAMES ${comp}mumps)

  if(NOT MUMPS_${comp}_lib)
    message(WARNING "MUMPS ${comp} not found")
    return()
  endif()

  set(MUMPS_${comp}_FOUND true PARENT_SCOPE)
  list(APPEND MUMPS_LIBRARY ${MUMPS_${comp}_lib})
endforeach()

if(MUMPS_LIBRARY)
set(MUMPS_LIBRARY ${MUMPS_LIBRARY} ${MUMPS_COMMON} ${PORD} PARENT_SCOPE)
set(MUMPS_INCLUDE_DIR ${MUMPS_INCLUDE_DIR} PARENT_SCOPE)
endif()

endfunction(mumps_libs)


cmake_policy(VERSION 3.3)

if(CMAKE_VERSION VERSION_GREATER_EQUAL 3.12)
  cmake_policy(SET CMP0074 NEW)
endif()

if(NOT MUMPS_FIND_COMPONENTS)
  list(APPEND MUMPS_FIND_COMPONENTS d)
endif()

mumps_libs()

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(MUMPS
  REQUIRED_VARS MUMPS_LIBRARY MUMPS_INCLUDE_DIR
  HANDLE_COMPONENTS)

if(MUMPS_FOUND)
  set(MUMPS_LIBRARIES ${MUMPS_LIBRARY})
  set(MUMPS_INCLUDE_DIRS ${MUMPS_INCLUDE_DIR})
endif()

mark_as_advanced(MUMPS_INCLUDE_DIR MUMPS_LIBRARY)
