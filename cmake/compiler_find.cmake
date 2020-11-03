# this must be include() before CMakeLists.txt project()

if(NOT CMAKE_BUILD_TYPE)
  set(CMAKE_BUILD_TYPE RelWithDebInfo CACHE STRING "Debug or Release")
endif()

set(CMAKE_CONFIGURATION_TYPES "Release;RelWithDebInfo;Debug" CACHE STRING "Build type selections" FORCE)

# Help CMake find matching compilers, especially needed for MacOS

if(NOT DEFINED ENV{FC})
  find_program(FC NAMES ifort gfortran gfortran-11 gfortran-10 gfortran-9 gfortran-8 gfortran-7)
  if(FC)
    set(ENV{FC} ${FC})
  endif()
endif()

if(NOT DEFINED ENV{FC} OR DEFINED ENV{CC})
  return()
endif()
# ensure FC exists as a executable program
find_program(FC NAMES $ENV{FC})

if(NOT FC)
  return()
endif()

# remember, Apple has "/usr/bin/gcc" which is really clang
# the technique below is NECESSARY to work on Mac and not find the wrong GCC
get_filename_component(_dir ${FC} DIRECTORY)

# use same compiler for C and Fortran, which CMake might not do itself
if(FC MATCHES ".*ifort")
  if(WIN32)
    set(_name icl)
  else()
    set(_name icc)
  endif()
elseif(FC MATCHES ".*gfortran")
  set(_name gcc gcc-11 gcc-10 gcc-9 gcc-8 gcc-7)
endif()

find_program(CC NAMES ${_name}
HINTS ${_dir}
NO_SYSTEM_ENVIRONMENT_PATH NO_CMAKE_SYSTEM_PATH)

if(CC)
  set(ENV{CC} ${CC})
endif()
