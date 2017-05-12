cmake_minimum_required (VERSION 2.8.12)
project(fortran2015demo Fortran)

# https://github.com/jedbrown/cmake-modules/blob/master/FindNetCDF.cmake
#
# apt install libnetcdff-dev     # note two "ff"

find_package(netCDF)
if(netCDF_DIR)
    list(APPEND CMAKE_MODULE_PATH ${netCDF_DIR})

    include_directories(${netCDF_INCLUDE_DIR})
    message(STATUS "netCDF_INCLUDE_DIR " ${netCDF_INCLUDE_DIR})

# note the second "ff"
    add_executable(writencdf simple_xy_wr.f90)
    target_link_libraries(writencdf netcdff)

    add_executable(readncdf simple_xy_rd.f90)
    target_link_libraries(readncdf netcdff)
endif()




