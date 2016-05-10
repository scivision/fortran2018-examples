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

Hello World MPI
---------------
To run the simplest sort of multi-threaded Fortran program using MPI-2, assuming you have a CPU with 8 virtual cores like an Intel Core i7::

    mpirun -np 8 hello

Message Passing MPI
-------------------
Pass data between two MPI threads::

    mpirun -np 2 pass

Quiet NaN
=========
We might choose to use NaN as a sentinal value, where instead of returning separate "OK" logical variable from a function or subroutine, if a failure happens, we return NaN in one of the important variables.
There was a classical way to do this that was type specific, by setting the NaN bit pattern for your data type. 
For example, for single-precision real you'd type::

    nan_bit = transfer(Z'7FF80000',1.)

For a standards-based way to handle all floating point types, you might consider::

    use, intrinsic :: ieee_arithmetic, only: ieee_value, ieee_quiet_nan
    nan_ieee = ieee_value(1.,ieee_quiet_nan)

This is in program::

    ./nan

Writing to /dev/null
====================
Sometimes when modifying an old Fortran subroutine to load as a module in a new Fortran program, the old submodule writes a lot of unnecessary data to disk, that can be the primary compute time consumption of the submodule.
You can simply repoint the "open" statements to /dev/null or as backup, a scratch file on systems that don't support /dev/null in::

    ./null

Strings
=======

Split strings about delimiter
-----------------------------
This splits a string once around a delimiter::

    ./split

And notes that it is probably best to use fixed length CHARACTER longer than you'll need.
If you're trying to load and parse a complicated text file, it is perhaps better to load that
file first in Python, parse it, then pass it to Fortran via f2py (load Fortran code as a Python module).
