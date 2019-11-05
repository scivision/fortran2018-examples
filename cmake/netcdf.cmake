# apt install libnetcdf-dev libnetcdff-dev     # need BOTH installed

find_package(NetCDF COMPONENTS Fortran)

set(CMAKE_REQUIRED_INCLUDES ${NetCDF_INCLUDE_DIRS})
set(CMAKE_REQUIRED_LIBRARIES ${NetCDF_LIBRARIES})

include(CheckFortranSourceCompiles)
check_fortran_source_compiles("use netcdf; end" NCDFOK SRC_EXT f90)

set(NCDFOK ${NCDFOK} CACHE BOOL "NetCDF4 library working?")
