.. image:: https://travis-ci.org/scienceopen/fortran2015-examples.svg?branch=master
    :target: https://travis-ci.org/scienceopen/fortran2015-examples

====================
fortran2015-examples
====================
Easy examples of scientific computing with modern, powerful, easy Fortran 2015 standard

.. contents::


Prereq
======
Runs anywhere, on Linux do::

    sudo apt-get install cmake gfortran libopenmpi-dev

Build
=====
::

    cd bin
    cmake ..
    make


OpenMPI
=======
To run the simplest sort of multi-threaded Fortran program using MPI-2, assuming you have a CPU with 8 virtual cores like an Intel Core i7::

    mpirun -np 8 hello

Quiet NaN
=========
We might choose to use NaN as a sentinal value, where instead of returning separate "OK" logical variable from a function or subroutine, if a failure happens, we return NaN in one of the important variables.
There was a classical way to do this that was type specific, by setting the NaN bit pattern for your data type. 
For example, for single-precision real you'd type::

    nan_bit = transfer(Z'7FF80000',1.)

For a standards-based way to handle all floating point types, you might consider::

    use, intrinsic :: ieee_arithmetic, only: ieee_value, ieee_quiet_nan
    nan_ieee = ieee_value(1.,ieee_quiet_nan)

