cmake_minimum_required(VERSION 3.3)
project(test_netcdf Fortran)
enable_testing()
#
# apt install libnetcdf-dev libnetcdff-dev     # need BOTH installed

get_directory_property(hasParent PARENT_DIRECTORY)
if(NOT hasParent)
  include(${CMAKE_CURRENT_SOURCE_DIR}/../cmake/compilers.cmake)
  list(APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/../cmake/Modules)
endif()

find_package(NetCDF)
if(NOT NetCDF_Fortran_FOUND)
  return()
endif()

set(CMAKE_REQUIRED_INCLUDES ${NetCDF_INCLUDE_DIRS})
set(CMAKE_REQUIRED_LIBRARIES ${NetCDF_LIBRARIES})
include(CheckFortranSourceCompiles)
check_fortran_source_compiles("use netcdf; end" hasNetCDF SRC_EXT f90)

if(hasNetCDF)

add_executable(netcdf_rw simple_xy_wr.f90)
target_compile_options(netcdf_rw PRIVATE ${FFLAGS})
target_link_libraries(netcdf_rw PRIVATE NetCDF::NetCDF_Fortran)
add_test(NAME NetCDF COMMAND netcdf_rw)

endif()