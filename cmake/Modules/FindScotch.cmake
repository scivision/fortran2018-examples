###
#
# @copyright (c) 2009-2014 The University of Tennessee and The University
#                          of Tennessee Research Foundation.
#                          All rights reserved.
# @copyright (c) 2012-2014 Inria. All rights reserved.
# @copyright (c) 2012-2014 Bordeaux INP, CNRS (LaBRI UMR 5800), Inria, Univ. Bordeaux. All rights reserved.
#
###
#
# - Find Scotch include dirs and libraries
# Use this module by invoking find_package with the form:
#  find_package(Scotch
#               [REQUIRED]             # Fail with error if scotch is not found
#               [COMPONENTS <comp1> <comp2> ...] # dependencies
#              )
#
#  COMPONENTS can be some of the following:
#   - ESMUMPS: to activate detection of Scotch with the esmumps interface
#
# This module finds headers and scotch library.
# Results are reported in variables:
#  Scotch_FOUND           - True if headers and requested libraries were found
#  Scotch_INCLUDE_DIRS    - scotch include directories
#  Scotch_LIBRARY_DIRS    - Link directories for scotch libraries
#  Scotch_LIBRARIES       - scotch component libraries to be linked
#  Scotch_INTSIZE         - Number of octets occupied by a Scotch_Num
#
# The user can give specific paths where to find the libraries adding cmake
# options at configure (ex: cmake .. -DScotch_ROOT=path/to/scotch):
#  Scotch_ROOT             - Where to find the base directory of scotch
#  Scotch_LIBRARY_DIR          - Where to find the library files
# The module can also look for the following environment variables if paths
# are not given as cmake variable: Scotch_ROOT

#=============================================================================
# Copyright 2012-2013 Inria
# Copyright 2012-2013 Emmanuel Agullo
# Copyright 2012-2013 Mathieu Faverge
# Copyright 2012      Cedric Castagnede
# Copyright 2013      Florent Pruvost
# (C) 2018 Michael Hirsch, Ph.D.
#
# Distributed under the OSI-approved BSD License (the "License");
# see accompanying file MORSE-Copyright.txt for details.
#
# This software is distributed WITHOUT ANY WARRANTY; without even the
# implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
# See the License for more information.
#=============================================================================
# (To distribute this file outside of Morse, substitute the full
#  License text for the above reference.)


if(Scotch_FIND_COMPONENTS)
  foreach( component ${Scotch_FIND_COMPONENTS} )
    if (${component} STREQUAL ESMUMPS)
      # means we look for esmumps library
      set(Scotch_LOOK_FOR_ESMUMPS ON)
    endif()
  endforeach()
endif()


# Looking for include
# -------------------

find_path(Scotch_INCLUDE_DIR
          NAMES scotch.h
          PATH_SUFFIXES include include/scotch)

# Looking for lib
# ---------------

set(Scotch_libs_to_find scotch scotcherrexit)
if (Scotch_LOOK_FOR_ESMUMPS)
  list(INSERT Scotch_libs_to_find 0 esmumps)
endif()

# call cmake macro to find the lib path
foreach(scotch_lib ${Scotch_libs_to_find})
  find_library(Scotch_${scotch_lib}_LIBRARY
    NAMES ${scotch_lib}
    HINTS ${Scotch_LIBRARY_DIR} ${Scotch_ROOT}
    PATH_SUFFIXES lib lib32 lib64)
endforeach()

set(Scotch_LIBRARIES "")
set(Scotch_LIBRARY_DIRS "")
# If found, add path to cmake variable
# ------------------------------------
foreach(scotch_lib ${Scotch_libs_to_find})

  if(Scotch_${scotch_lib}_LIBRARY)
    get_filename_component(${scotch_lib}_lib_path ${Scotch_${scotch_lib}_LIBRARY} PATH)
    # set cmake variables
    list(APPEND Scotch_LIBRARIES ${Scotch_${scotch_lib}_LIBRARY})
    list(APPEND Scotch_LIBRARY_DIRS ${${scotch_lib}_lib_path})
  else()
    list(APPEND Scotch_LIBRARIES ${Scotch_${scotch_lib}_LIBRARY})
    if(NOT Scotch_FIND_QUIETLY)
      message(WARNING "Looking for scotch -- lib ${scotch_lib} not found")
    endif()
  endif()

  mark_as_advanced(Scotch_${scotch_lib}_LIBRARY)
endforeach()

list(APPEND Scotch_LIBRARY_DIRS ${CMAKE_THREAD_LIBS_INIT})
list(REMOVE_DUPLICATES Scotch_LIBRARY_DIRS)


# check that SCOTCH has been found
# ---------------------------------
include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(Scotch
          REQUIRED_VARS Scotch_LIBRARIES Scotch_INCLUDE_DIR)

set(Scotch_INCLUDE_DIRS ${Scotch_INCLUDE_DIR})

mark_as_advanced(Scotch_ROOT Scotch_INCLUDE_DIR)

