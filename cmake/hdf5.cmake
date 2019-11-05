# don't enclose this all in "if(NOT DEFINED HDF5OK)" because CMake intermittantly doesn't cache needed HDF5 variables.

find_package(HDF5 REQUIRED COMPONENTS Fortran Fortran_HL)

if(WIN32)
  # Needed for MSYS2, this directory wasn't in CMake 3.15.2 FindHDF5
  if(BUILD_SHARED_LIBS)
    list(APPEND HDF5_INCLUDE_DIRS ${HDF5_INCLUDE_DIRS}/shared)
  else()
    list(APPEND HDF5_INCLUDE_DIRS ${HDF5_INCLUDE_DIRS}/static)
  endif()
endif()

if(NOT DEFINED HDF5OK)

message(STATUS "HDF5 include: ${HDF5_INCLUDE_DIRS} ${HDF5_Fortran_INCLUDE_DIRS}")
message(STATUS "HDF5 library: ${HDF5_Fortran_LIBRARIES}")
message(STATUS "HDF5 H5LT library: ${HDF5_Fortran_HL_LIBRARIES}")
if(HDF5_Fortran_COMPILER_EXECUTABLE)
  message(STATUS "HDF5 Fortran compiler: ${HDF5_Fortran_COMPILER_EXECUTABLE}")
endif()
if(HDF5_Fortran_DEFINITIONS)
  message(STATUS "HDF5 compiler defs: ${HDF5_Fortran_DEFINITIONS}")
endif()
endif()

set(CMAKE_REQUIRED_INCLUDES ${HDF5_INCLUDE_DIRS} ${HDF5_Fortran_INCLUDE_DIRS})
set(CMAKE_REQUIRED_LIBRARIES ${HDF5_Fortran_HL_LIBRARIES} ${HDF5_Fortran_LIBRARIES})

include(CheckFortranSourceCompiles)
check_fortran_source_compiles("use h5lt; end" HDF5OK SRC_EXT f90)

set(HDF5OK ${HDF5OK} CACHE BOOL "HDF5 library working?")

if(NOT HDF5OK)
  message(WARNING "HDF5 library may not be working with ${CMAKE_Fortran_COMPILER_ID} ${CMAKE_Fortran_COMPILER_VERSION}")
endif()
