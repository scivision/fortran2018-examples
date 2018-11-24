# HDF5

A true modern Fortan polymorphic, simple HDF5 read/write interface, is
[my object-oriented HDF5 Fortran interface](https://github.com/scivision/oo_hdf5_fortran/).

These examples write then read an HDF5 file from Fortran.

* HDF5 Fortran [Manual](https://support.hdfgroup.org/HDF5/doc/fortran/index.html)

DO NOT USE BOTH H5FC wrapper compiler and specify the Fortran HDF5 libraries (in the CMake file). 
This can cause version conflicts if you have multiple versions of HDF5 installed. 
It causes non-obvious errors.
NOT using the wrapper compiler may be "safer" so that's what the CMake file does.

