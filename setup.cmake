# run by:
# ctest -S setup.cmake

# --- Project-specific -Doptions
# these will be used if the project isn't already configured.

# --- boilerplate follows
# site is OS name
if(NOT DEFINED CTEST_SITE)
  set(CTEST_SITE ${CMAKE_SYSTEM_NAME})
endif()

# if compiler specified, deduce its ID
if(DEFINED ENV{FC})
  set(FC $ENV{FC})
endif()
if(DEFINED CMAKE_Fortran_COMPILER)
  set(FC ${CMAKE_Fortran_COMPILER})
endif()
if(DEFINED FC)
  foreach(c gfortran ifort flang pgfortran nagfor xlf ftn)
    string(FIND ${FC} ${c} i)
    if(i GREATER_EQUAL 0)
      if(c STREQUAL gfortran)
        execute_process(COMMAND gfortran -dumpversion
          RESULT_VARIABLE _ret
          OUTPUT_VARIABLE _vers OUTPUT_STRIP_TRAILING_WHITESPACE)
        if(_ret EQUAL 0)
          string(APPEND c "-${_vers}")
        endif()
      endif()
      set(CTEST_BUILD_NAME ${c})
      break()
    endif()
  endforeach()
endif()

if(NOT DEFINED CTEST_BUILD_CONFIGURATION)
  set(CTEST_BUILD_CONFIGURATION "Release")
endif()

set(CTEST_SOURCE_DIRECTORY ${CMAKE_CURRENT_LIST_DIR})
if(NOT DEFINED CTEST_BINARY_DIRECTORY)
  set(CTEST_BINARY_DIRECTORY ${CMAKE_CURRENT_LIST_DIR}/build)
endif()

if(NOT DEFINED CTEST_CMAKE_GENERATOR)
  find_program(_gen NAMES ninja ninja-build samu)
  if(_gen)
    set(CTEST_CMAKE_GENERATOR "Ninja")
  elseif(WIN32)
    set(CTEST_CMAKE_GENERATOR "MinGW Makefiles")
    set(CTEST_BUILD_FLAGS -j)
  else()
    set(CTEST_CMAKE_GENERATOR "Unix Makefiles")
    set(CTEST_BUILD_FLAGS -j)
  endif()
endif()

ctest_start("Experimental" ${CTEST_SOURCE_DIRECTORY} ${CTEST_BINARY_DIRECTORY})
if(NOT EXISTS ${CTEST_BINARY_DIRECTORY}/CMakeCache.txt)
  ctest_configure(BUILD ${CTEST_BINARY_DIRECTORY} SOURCE ${CTEST_SOURCE_DIRECTORY} OPTIONS "${_opts}")
endif()
ctest_build(BUILD ${CTEST_BINARY_DIRECTORY} CONFIGURATION ${CTEST_BUILD_CONFIGURATION})
ctest_test(BUILD ${CTEST_BINARY_DIRECTORY})
# ctest_submit()
