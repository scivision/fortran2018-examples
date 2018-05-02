cmake_minimum_required (VERSION 3.2.2)
project(test_netcdf Fortran)
enable_testing()
# https://github.com/jedbrown/cmake-modules/blob/master/FindNetCDF.cmake
#
# apt install libnetcdff-dev     # note two "ff"

# unfortunately netCDF for Fortran isn't explicitly supported, even in Ubuntu 18.04 repos libnetcdff-dev since
# findNetcdf comes from libnetcdf-dev
find_package(netCDF)
if(netCDF_FOUND)  
    list(APPEND netCDF_LIBRARIES netcdff)
    message(STATUS "NetCDF found:" ${netCDF_INCLUDE_DIR} " " ${netCDF_LIBRARIES})

# note the second "ff"
    add_executable(netcdf_rw simple_xy_wr.f90)
    target_compile_options(netcdf_rw PRIVATE ${FFLAGS})
    target_include_directories(netcdf_rw PRIVATE ${netCDF_INCLUDE_DIR})
    target_link_libraries(netcdf_rw PRIVATE ${netCDF_LIBRARIES})
    add_test(NAME NetCDF COMMAND netcdf_rw)
endif()




