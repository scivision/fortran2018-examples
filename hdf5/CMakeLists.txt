cmake_minimum_required (VERSION 3.2.2) # 3.2.2 required for HDF5
project(fortran2015demo Fortran)
# https://support.hdfgroup.org/ftp/HDF5/current/src/unpacked/release_docs/USING_HDF5_CMake.txt
# https://github.com/Kitware/CMake/blob/master/Modules/FindHDF5.cmake

add_compile_options(-Warray-bounds -fexceptions -g)

#-------- HDF5 Fortran example --------------
# find_package(HDF5 COMPONENTS Fortran)  IS THE CRITICAL LINE TO ENABLE FORTRAN
# not just find_package(HDF5) since that defaults to C ONLY.
find_package(HDF5 COMPONENTS Fortran HL) 
if(HDF5_FOUND)
    # this line enables (optional) wrapper compiler h5fc).
    set(CMAKE_Fortran_COMPILER ${HDF5_Fortran_COMPILER_EXECUTABLE})

    message(STATUS "Compiling your HDF5 using program with " ${CMAKE_Fortran_COMPILER})

    INCLUDE_DIRECTORIES (${HDF5_INCLUDE_DIR})
    message(STATUS "HDF5_INCLUDE_DIR: " ${HDF5_Fortran_INCLUDE_DIRS})
    
    # 
    link_libraries(${HDF5_Fortran_LIBRARIES} ${HDF5_Fortran_HL_LIBRARIES})
    message(STATUS "HDF5_Fortran_HL_LIBRARIES "  ${HDF5_Fortran_HL_LIBRARIES})

    
    add_executable(hdf5demo hdf5demo.f90)
   
    add_executable(hdf5array hdf5array.f90)
    
    add_executable(h5simple hdf5simple.f90)

endif()
