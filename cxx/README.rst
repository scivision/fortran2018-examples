Example of C++ main program calling Fortran library.
Tested with both GCC and Intel compilers.

GCC
---
::
    
    cmake .
    make
    ./cxxfort

Intel
-----
::

    FC=ifort CC=icc CXX=icpc cmake ..
    make
    ./cxxfort
