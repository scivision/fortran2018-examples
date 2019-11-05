include(${CMAKE_SOURCE_DIR}/cmake/netcdf.cmake)

if(NOT NetCDF_FOUND)
  return()
endif()

add_executable(netcdf_rw simple_xy_wr.f90)
target_compile_options(netcdf_rw PRIVATE ${FFLAGS})
target_include_directories(netcdf_rw PRIVATE ${NetCDF_INCLUDE_DIRS})
target_link_libraries(netcdf_rw PRIVATE ${NetCDF_LIBRARIES})
add_test(NAME NetCDF COMMAND netcdf_rw)
