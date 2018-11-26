cmake_minimum_required (VERSION 3.2.2)
project(test_netcdf Fortran)
enable_testing()
# https://github.com/jedbrown/cmake-modules/blob/master/FindNetCDF.cmake
#
# apt install libnetcdf-dev libnetcdff-dev     # need both installed

get_directory_property(hasParent PARENT_DIRECTORY)
if(NOT hasParent)
  include(../cmake/compilers.cmake)
endif()

find_package(netCDF)
if(NOT netCDF_FOUND)
  return()
endif()

set(CMAKE_REQUIRED_INCLUDES ${netCDF_INCLUDE_DIR})
set(CMAKE_REQUIRED_LIBRARIES ${netCDF_LIBRARIES})
include(CheckFortranSourceCompiles)
check_fortran_source_compiles("program nc; use netcdf; end" hasNetCDF
                              SRC_EXT f90)
if(NOT hasNetCDF)
  return()
endif()

  # note the second "ff"
list(APPEND netCDF_LIBRARIES netcdff)
message(STATUS "NetCDF found:" ${netCDF_INCLUDE_DIR} " " ${netCDF_LIBRARIES})

add_executable(netcdf_rw simple_xy_wr.f90)
target_compile_options(netcdf_rw PRIVATE ${FFLAGS})
target_include_directories(netcdf_rw PRIVATE ${netCDF_INCLUDE_DIR})
target_link_libraries(netcdf_rw PRIVATE ${FLIBS} ${netCDF_LIBRARIES})
add_test(NAME NetCDF COMMAND netcdf_rw)

