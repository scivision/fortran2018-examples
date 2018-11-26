cmake_minimum_required (VERSION 3.10) # 3.10 required for HDF5 1.10
project(fortranHDF5 Fortran)
enable_testing()

get_directory_property(hasParent PARENT_DIRECTORY)
if(NOT hasParent)
  include(../cmake/compilers.cmake)
endif()
# INTEL COMPILER: https://software.intel.com/en-us/articles/performance-tools-for-software-developers-building-hdf5-with-intel-compilers

# https://support.hdfgroup.org/ftp/HDF5/current/src/unpacked/release_docs/USING_HDF5_CMake.txt
# https://github.com/Kitware/CMake/blob/master/Modules/FindHDF5.cmake

#-------- HDF5 Fortran example --------------
# find_package(HDF5 COMPONENTS Fortran)  IS THE CRITICAL LINE TO ENABLE FORTRAN
# not just find_package(HDF5) since that defaults to C ONLY.
find_package(HDF5 COMPONENTS Fortran Fortran_HL)
if(NOT HDF5_FOUND)
  return()
endif()
# this line enables (optional) wrapper compiler h5fc).
# USE **EITHER** this compiler OR link libraries.
# DOING BOTH CAUSES SUBTLE ERROR MESSAGES!! DON'T DO BOTH!!
#set(CMAKE_Fortran_COMPILER ${HDF5_Fortran_COMPILER_EXECUTABLE})

# message(STATUS "HDF5_INCLUDE_DIR: " ${HDF5_Fortran_INCLUDE_DIRS})
# message(STATUS "HDF5_Fortran_HL_LIBRARIES "  ${HDF5_Fortran_HL_LIBRARIES})
#------------------------
set(CMAKE_REQUIRED_INCLUDES ${HDF5_Fortran_INCLUDE_DIRS})
set(CMAKE_REQUIRED_LIBRARIES ${HDF5_Fortran_LIBRARIES} ${HDF5_Fortran_HL_LIBRARIES})
include(CheckFortranSourceCompiles)
check_fortran_source_compiles("program nc; use h5lt; end" hasHDF5
                              SRC_EXT f90)
if(NOT hasHDF5)
  return()
endif()

add_library(h5mod h5mod.f90)
target_compile_options(h5mod PRIVATE ${FFLAGS})
target_include_directories(h5mod PRIVATE ${HDF5_Fortran_INCLUDE_DIRS})
target_link_libraries(h5mod PRIVATE ${HDF5_Fortran_LIBRARIES} ${HDF5_Fortran_HL_LIBRARIES})

add_executable(h5simple hdf5simple.f90)
target_link_libraries(h5simple PRIVATE h5mod)
target_compile_options(h5simple PRIVATE ${FFLAGS})
add_test(NAME HDF5mod COMMAND h5simple 5)

#add_executable(hdf5demo hdf5demo.f90)

#add_executable(hdf5array hdf5array.f90)

add_executable(stest test.f90)
target_compile_options(stest PRIVATE ${FFLAGS} -w)
target_include_directories(stest PRIVATE ${HDF5_Fortran_INCLUDE_DIRS})
target_link_libraries(stest PRIVATE ${HDF5_Fortran_LIBRARIES} ${HDF5_Fortran_HL_LIBRARIES})
add_test(NAME HDF5 COMMAND stest)

