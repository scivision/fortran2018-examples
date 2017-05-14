cmake_minimum_required (VERSION 2.8.12)
project(fortran2015demo Fortran)

# https://github.com/jedbrown/cmake-modules/blob/master/FindNetCDF.cmake
#
# apt install libnetcdff-dev     # note two "ff"

find_package(netCDF)
if(netCDF_DIR)  # there isn't a NETCDF_FOUND variable yet in libnetcdff-dev
    include_directories(${netCDF_INCLUDE_DIR})
#    message(STATUS "netCDF_INCLUDE_DIR " ${netCDF_INCLUDE_DIR})

# note the second "ff"
    add_executable(writencdf simple_xy_wr.f90)
    target_link_libraries(writencdf netcdff)

    add_executable(readncdf simple_xy_rd.f90)
    target_link_libraries(readncdf netcdff)
else()
    message(STATUS "Skipped NetCDF " ${netCDF_DIR})
endif()




