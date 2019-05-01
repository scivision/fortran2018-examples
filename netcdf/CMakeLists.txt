cmake_minimum_required(VERSION 3.3)
if(NOT CMAKE_BUILD_TYPE)
  set(CMAKE_BUILD_TYPE Release CACHE STRING "Debug or Release")
endif()
project(test_netcdf C Fortran)  # Need C for NetCDF
enable_testing()
#
# apt install libnetcdf-dev libnetcdff-dev     # need BOTH installed

get_directory_property(hasParent PARENT_DIRECTORY)
if(NOT hasParent)
  include(${CMAKE_CURRENT_SOURCE_DIR}/../cmake/compilers.cmake)
  list(APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/../cmake/Modules)
endif()

find_package(NetCDF COMPONENTS Fortran)
if(NOT NetCDF_FOUND)
  return()
endif()

add_executable(netcdf_rw simple_xy_wr.f90)
target_compile_options(netcdf_rw PRIVATE ${FFLAGS})
target_include_directories(netcdf_rw PRIVATE ${NetCDF_INCLUDE_DIRS})
target_link_libraries(netcdf_rw PRIVATE ${NetCDF_LIBRARIES})
add_test(NAME NetCDF COMMAND netcdf_rw)
