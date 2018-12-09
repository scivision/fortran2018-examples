# Distributed under the OSI-approved BSD 3-Clause License.  See accompanying
# file Copyright.txt or https://cmake.org/licensing for details.

#[=======================================================================[.rst:
FindMUMPS
---------

Finds the MUMPS library

COMPONENTS
  s d c z   list one or more. Defaults to ``d``.

Result Variables
^^^^^^^^^^^^^^^^

MUMPS_LIBRARIES
  libraries to be linked

MUMPS_INCLUDE_DIRS
  dirs to be included

#]=======================================================================]

set(CMAKE_INSTALL_DEFAULT_COMPONENT_NAME d)

find_path(MUMPS_INCLUDE_DIR
          NAMES mumps_compat.h
          PATH_SUFFIXES MUMPS include)

find_library(MUMPS_COMMON
             NAMES mumps_common
             PATH_SUFFIXES MUMPS lib)

find_library(PORD
             NAMES pord
             PATH_SUFFIXES MUMPS lib)


FOREACH(comp ${MUMPS_FIND_COMPONENTS})
  find_library(MUMPS_${comp}_lib
              NAMES ${comp}mumps
              PATH_SUFFIXES MUMPS lib)

  list(APPEND MUMPS_LIBRARY ${MUMPS_${comp}_lib})
  mark_as_advanced(MUMPS_${comp}_lib)
ENDFOREACH()


include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(
MUMPS
REQUIRED_VARS MUMPS_LIBRARY MUMPS_COMMON PORD MUMPS_INCLUDE_DIR
VERSION_VAR MUMPS_VERSION)

# in this order!
list(APPEND MUMPS_LIBRARIES ${MUMPS_LIBRARY} ${MUMPS_COMMON} ${PORD})
set(MUMPS_INCLUDE_DIRS ${MUMPS_INCLUDE_DIR})

#if(NOT TARGET MUMPS::MUMPS)
#  add_library(MUMPS::MUMPS UNKNOWN IMPORTED)
#  set_target_properties(MUMPS::MUMPS PROPERTIES
#                        INTERFACE_LINK_LIBRARIES ${MUMPS_LIBRARIES}
#                        INTERFACE_INCLUDE_DIRECTORIES ${MUMPS_INCLUDE_DIRS}
#                       )
#endif()

mark_as_advanced(
MUMPS_INCLUDE_DIR
MUMPS_LIBRARY)

