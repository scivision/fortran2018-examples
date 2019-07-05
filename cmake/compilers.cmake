if(NOT CMAKE_Fortran_COMPILER)
  message(FATAL_ERROR "Must have invoked Fortran before including compilers.cmake")
endif()

message(STATUS "CMake Build Type: ${CMAKE_BUILD_TYPE}")

include(CheckFortranSourceCompiles)

if(CMAKE_Fortran_COMPILER_ID STREQUAL Intel)
  if(NOT WIN32)
    set(FFLAGS -stand f18 -implicitnone -traceback -warn -heap-arrays)
  else()
    set(FFLAGS /stand:f18 /4Yd /traceback /warn /heap-arrays)
    # Note: -g is /debug:full for ifort Windows
  endif()

  if(CMAKE_BUILD_TYPE STREQUAL Debug)
    if(WIN32)
      list(APPEND FFLAGS /check:all)
    else()
      list(APPEND FFLAGS -debug extended -check all)
    endif()
  endif()
elseif(CMAKE_Fortran_COMPILER_ID STREQUAL GNU)
  if(CMAKE_Fortran_COMPILER_VERSION VERSION_GREATER_EQUAL 8)
    set(FFLAGS -std=f2018)
  endif()
  list(APPEND FFLAGS -march=native -Wall -Wextra -Wpedantic -fimplicit-none)

  if(CMAKE_BUILD_TYPE STREQUAL Debug)
    list(APPEND FFLAGS -Werror=array-bounds -fcheck=all)
  endif()
elseif(CMAKE_Fortran_COMPILER_ID STREQUAL PGI)
  set(FFLAGS -C -Mdclchk)
elseif(CMAKE_Fortran_COMPILER_ID STREQUAL Flang)
  set(CFLAGS -W)
  list(APPEND FLIBS -static-flang-libs)
elseif(CMAKE_Fortran_COMPILER_ID STREQUAL NAG)
  # https://www.nag.co.uk/nagware/np/r62_doc/manual/compiler_2_4.html#OPTIONS
  list(APPEND FFLAGS -f2008 -C -colour -gline -nan -info -u)
endif()

