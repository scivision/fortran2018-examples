cmake_minimum_required (VERSION 3.2.2)
project(test_netcdf Fortran)

# https://github.com/jedbrown/cmake-modules/blob/master/FindNetCDF.cmake
#
# apt install libnetcdff-dev     # note two "ff"


find_package(netCDF COMPONENTS F90)
if(netCDF_FOUND)  
    message(STATUS "NetCDF found:" ${netCDF_INCLUDE_DIR})
    include_directories(${netCDF_INCLUDE_DIR})

# note the second "ff"
    add_executable(netcdf_rw simple_xy_wr.f90)
    target_link_libraries(netcdf_rw netcdff)
    
    enable_testing()
    add_test(NAME NetCDF COMMAND netcdf_rw)

else()
    message(STATUS "Skipped NetCDF " ${netCDF_DIR})
endif()




