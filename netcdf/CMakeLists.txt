cmake_minimum_required (VERSION 2.8.12)
project(fortran2015demo Fortran)

find_package(netCDF)
if(netCDF_DIR)
    list(APPEND CMAKE_MODULE_PATH ${netCDF_DIR})

#    add_definitions(${netCDF_C_COMPILER_FLAGS})

    include_directories(${netCDF_INCLUDE_DIR})

# note the second "ff"
    add_executable(writencdf simple_xy_wr.f90)
    target_link_libraries(writencdf netcdff)

    add_executable(readncdf simple_xy_rd.f90)
    target_link_libraries(readncdf netcdff)
endif()




