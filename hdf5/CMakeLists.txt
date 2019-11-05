# INTEL COMPILER: https://software.intel.com/en-us/articles/performance-tools-for-software-developers-building-hdf5-with-intel-compilers
# https://support.hdfgroup.org/ftp/HDF5/current/src/unpacked/release_docs/USING_HDF5_CMake.txt
# https://github.com/Kitware/CMake/blob/master/Modules/FindHDF5.cmake

include(${CMAKE_SOURCE_DIR}/cmake/hdf5.cmake)

if(NOT HDF5OK)
  return()
endif()


add_library(h5mod h5mod.f90)
target_compile_options(h5mod PRIVATE ${FFLAGS})
target_include_directories(h5mod PRIVATE ${HDF5_INCLUDE_DIRS} ${HDF5_Fortran_INCLUDE_DIRS})
target_link_libraries(h5mod PRIVATE ${HDF5_Fortran_HL_LIBRARIES} ${HDF5_Fortran_LIBRARIES})

add_executable(h5simple hdf5simple.f90)
target_link_libraries(h5simple PRIVATE h5mod)
target_compile_options(h5simple PRIVATE ${FFLAGS})
add_test(NAME HDF5mod COMMAND h5simple 5)

#add_executable(hdf5demo hdf5demo.f90)

#add_executable(hdf5array hdf5array.f90)

add_executable(stest test.f90)
target_compile_options(stest PRIVATE ${FFLAGS} -w)
target_include_directories(stest PRIVATE ${HDF5_INCLUDE_DIRS} ${HDF5_Fortran_INCLUDE_DIRS})
target_link_libraries(stest PRIVATE ${HDF5_Fortran_HL_LIBRARIES} ${HDF5_Fortran_LIBRARIES})
add_test(NAME HDF5 COMMAND stest)

