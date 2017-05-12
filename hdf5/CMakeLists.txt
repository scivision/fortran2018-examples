cmake_minimum_required (VERSION 3.2.2) # 3.2.2 required for HDF5
project(fortran2015demo C Fortran) # C for HDF5
# https://support.hdfgroup.org/ftp/HDF5/current/src/unpacked/release_docs/USING_HDF5_CMake.txt

# if h5fc not found and you have Anaconda/Miniconda Python installed, try
# PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin cmake .
#-------- HDF5 Fortran example --------------
find_package(HDF5)
if(HDF5_Fortran_COMPILER_EXECUTABLE)
    set(CMAKE_Fortran_COMPILER ${HDF5_Fortran_COMPILER_EXECUTABLE})
    message(STATUS "H5FC " ${CMAKE_Fortran_COMPILER})

    add_executable(hdf5demo hdf5demo.f90)
elseif(HDF5_C_COMPILER_EXECUTABLE)
# when calling this CMakeLists.txt from a master file using add_subdirectory,
# the fortran compiler isn't found but the C compiler is, so monkey patch.
    get_filename_component(H5FCPATH ${HDF5_C_COMPILER_EXECUTABLE} DIRECTORY)
    set(CMAKE_Fortran_COMPILER ${H5FCPATH}/h5fc)
    message(STATUS "fallback H5FC " ${CMAKE_Fortran_COMPILER})

    add_executable(hdf5demo hdf5demo.f90)
endif()
