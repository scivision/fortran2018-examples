cmake_minimum_required (VERSION 3.2.2) # 3.2.2 required for HDF5
project(fortran2015hdf5 C Fortran) # C for HDF5
# https://support.hdfgroup.org/ftp/HDF5/current/src/unpacked/release_docs/USING_HDF5_CMake.txt

# if HDF5 library errors upon running executable and you have Anaconda/Miniconda Python installed, try
# PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin cmake 
#-------- HDF5 Fortran example --------------
find_package(HDF5)
if(HDF5_Fortran_COMPILER_EXECUTABLE)
    set(CMAKE_Fortran_COMPILER ${HDF5_Fortran_COMPILER_EXECUTABLE})

    add_executable(hdf5demo hdf5demo.f90)
endif()
