# this must be include() before CMakeLists.txt project()

if(NOT CMAKE_BUILD_TYPE)
  set(CMAKE_BUILD_TYPE RelWithDebInfo CACHE STRING "Debug or Release")
endif()

set(CMAKE_CONFIGURATION_TYPES "Release;RelWithDebInfo;Debug" CACHE STRING "Build type selections" FORCE)

# Help CMake find matching compilers, especially needed for MacOS

if(APPLE)
  set(_paths /usr/local/bin /opt/homebrew/bin)
  # for Homebrew that's not on PATH (can be an issue on CI)
else()
  set(_paths)
endif()


function(find_fortran)

if(NOT DEFINED ENV{FC})
  # temporarily removed ifort, because Intel oneAPI release Dec 8, 2020 is broken for HDF5 and MPI in general.
  find_program(FC
    NAMES gfortran gfortran-11 gfortran-10 gfortran-9 gfortran-8 gfortran-7
    PATHS ${_paths})
  if(FC)
    set(ENV{FC} ${FC})
  endif()
endif()

if(NOT DEFINED ENV{FC})
  return()
endif()
# ensure FC exists as a executable program
find_program(FC
  NAMES $ENV{FC}
  PATHS ${_paths})

if(FC)
  set(FC ${FC} PARENT_SCOPE)
endif()

endfunction(find_fortran)


function(find_c)

if(NOT FC AND DEFINED ENV{FC})
  set(FC $ENV{FC})
endif()

message(VERBOSE " FC hint: ${FC}")

if(DEFINED ENV{CC})
  set(_name $ENV{CC})
  set(_dir)
else()
  # remember, Apple has "/usr/bin/gcc" which is really clang
  # the technique below is NECESSARY to work on Mac and not find the wrong GCC
  if(FC)
    get_filename_component(_dir ${FC} DIRECTORY)
  endif()
  # use same compiler for C and Fortran, which CMake might not do itself
  if(FC MATCHES ".*ifort")
    if(WIN32)
      set(_name icl)
    else()
      set(_name icc)
    endif()
  elseif(FC MATCHES ".*gfortran")
    set(_name gcc gcc-11 gcc-10 gcc-9 gcc-8 gcc-7)
  else()
    return()
  endif()
endif()

find_program(CC
  NAMES ${_name}
  HINTS ${_dir}
  NO_SYSTEM_ENVIRONMENT_PATH NO_CMAKE_SYSTEM_PATH)

if(CC)
  set(CC ${CC} PARENT_SCOPE)
  set(ENV{CC} ${CC})
  message(VERBOSE " CC hint: ${CC}")
endif()

endfunction(find_c)


function(find_c_fortran)
find_fortran()
find_c()
endfunction(find_c_fortran)
