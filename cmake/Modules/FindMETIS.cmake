# Distributed under the OSI-approved BSD 3-Clause License.  See accompanying
# file Copyright.txt or https://cmake.org/licensing for details.

#[=======================================================================[.rst:
FindMETIS
-------
Michael Hirsch, Ph.D.

Finds the METIS library

Result Variables
^^^^^^^^^^^^^^^^

METIS_LIBRARIES
  libraries to be linked

METIS_INCLUDE_DIRS
  dirs to be included

#]=======================================================================]


find_library(METIS_LIBRARY
             NAMES metis
             PATH_SUFFIXES METIS lib libmetis build/Linux-x86_64/libmetis)

find_path(METIS_INCLUDE_DIR
          NAMES metis.h
          PATH_SUFFIXES METIS include)


include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(METIS
    REQUIRED_VARS METIS_LIBRARY METIS_INCLUDE_DIR)

set(METIS_LIBRARIES ${METIS_LIBRARY})
set(METIS_INCLUDE_DIRS ${METIS_INCLUDE_DIR})

mark_as_advanced(METIS_INCLUDE_DIR METIS_LIBRARY)

