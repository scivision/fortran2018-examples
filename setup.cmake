# run by:
# ctest -S setup.cmake

# --- Project-specific -Doptions
# these will be used if the project isn't already configured.
set(_opts)

# --- boilerplate follows
message(STATUS "CMake ${CMAKE_VERSION}")
if(CMAKE_VERSION VERSION_LESS 3.15)
  message(FATAL_ERROR "Please update CMake >= 3.15")
endif()

# site is OS name
if(NOT DEFINED CTEST_SITE)
  set(CTEST_SITE ${CMAKE_SYSTEM_NAME})
endif()

# test name is Fortran compiler in FC
# Note: ctest scripts cannot read cache variables like CMAKE_Fortran_COMPILER
if(DEFINED ENV{FC})
  set(CTEST_BUILD_NAME $ENV{FC})
endif()

if(NOT DEFINED CTEST_BUILD_CONFIGURATION)
  set(CTEST_BUILD_CONFIGURATION "Release")
endif()

set(CTEST_SOURCE_DIRECTORY ${CMAKE_CURRENT_LIST_DIR})
if(NOT DEFINED CTEST_BINARY_DIRECTORY)
  set(CTEST_BINARY_DIRECTORY ${CMAKE_CURRENT_LIST_DIR}/build)
endif()

# CTEST_CMAKE_GENERATOR must be defined in any case here.
if(NOT DEFINED CTEST_CMAKE_GENERATOR)
  find_program(_gen NAMES ninja ninja-build samu)
  if(_gen)
    set(CTEST_CMAKE_GENERATOR "Ninja")
  elseif(WIN32)
    set(CTEST_CMAKE_GENERATOR "MinGW Makefiles")
    set(CTEST_BUILD_FLAGS -j)  # not --parallel as this goes to generator directly
  else()
    set(CTEST_CMAKE_GENERATOR "Unix Makefiles")
    set(CTEST_BUILD_FLAGS -j)  # not --parallel as this goes to generator directly
  endif()
endif()

ctest_start("Experimental" ${CTEST_SOURCE_DIRECTORY} ${CTEST_BINARY_DIRECTORY})
if(NOT EXISTS ${CTEST_BINARY_DIRECTORY}/CMakeCache.txt)
  ctest_configure(BUILD ${CTEST_BINARY_DIRECTORY} SOURCE ${CTEST_SOURCE_DIRECTORY} OPTIONS "${_opts}")
endif()
ctest_build(BUILD ${CTEST_BINARY_DIRECTORY} CONFIGURATION ${CTEST_BUILD_CONFIGURATION})
ctest_test(BUILD ${CTEST_BINARY_DIRECTORY})

# using ctest_submit makes error code 0 even if test(s) failed!
if(DEFINED ENV{CI})
  set(CI $ENV{CI})
endif()

if(NOT CI)
  # ctest_submit()
endif()
