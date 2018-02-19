.. image:: https://travis-ci.org/scivision/fortran2018-examples.svg?branch=master
    :target: https://travis-ci.org/scivision/fortran2018-examples

=====================
Fortran 2018 Examples
=====================

Easy examples of scientific computing with modern, powerful, easy Fortran 2018 standard.
Fortran 2018 began as the TS18508 extension, formerly known as Fortran 2015.

.. contents::


Prereq
======

* Linux/Windows/BSD::

    apt install cmake gfortran libhdf5-dev libopenmpi-dev libnetcdff-dev libcoarrays-dev open-coarrays-bin

  Yes that's two ``ff`` in ``libnetcdff-dev``
  
* Mac::

    brew install gcc cmake open-mpi opencoarrays


Build
=====
The CMake script automatically walks through the subdirectories:

.. code:: bash

    cd bin

    cmake ..
    make -k
    
If you have Anaconda Python or Intel Fortran installed, this can override system prereqs. Workaround:

.. code:: bash

    PATH=/usr/bin:/usr/include cmake ..
    make
    
    
ifort Intel
-----------
Be sure you have the `Intel Parallel Studio Cluster Edition <https://www.scivision.co/install-intel-compiler-icc-icpc-ifort/>`_ that has ``mpiifort``.

.. code:: bash

    FC=ifort CC=icc CXX=icpc cmake ..
    make
    
    
* the NetCDF and HDF5 libraries will need to be manually compiled with the Intel compiler.
* need to ``source compilervars.sh`` as usual with the Intel compiler or you will get ``*.so missing`` errors.
* for Intel compiler, build with

  .. code:: bash

    cd bin
    FC=ifort CC=icc CXX=icpc cmake ..
    make -k
    

Programs
========


Call Fortran from C++
---------------------
You can easily use Fortran subroutines and functions from C and C++::

    ./cxx/cxxfort

The key factors in calling a Fortran module from C or C++ include:

* use the standard C binding to define variable and bind functions/subroutines

  .. code:: fortran

    use,intrinsic:: iso_c_binding, only: c_int, c_float, c_double

    integer(c_int) :: N
    real(c_double) :: X

    subroutine cool(X,N) bind(c)
  
  the ``bind(c)`` makes the name ``cool`` available to C/C++.  

See ``cxx/cxxfort.f90`` and ``fun.f90`` for a simple exmaple.


NetCDF
------
This example writes then reads a NetCDF file from Fortran::

    ./netcdf/writencdf

    ./netcdf/readncdf

HDF5
----
This example writes then reads an HDF5 file from Fortran::

    ./hdf5/hdf5demo
    
Note
~~~~
DO NOT USE BOTH `H5FC` wrapper compiler and specify the Fortran HDF5 libraries (in the CMake file). 
This can cause version conflicts if you have multiple versions of HDF5 installed.
It causes non-obvious errors that can waste your time.

In my opinion NOT using the wrapper compiler may be "safer" so that's what the CMake file does.

Coarray
-------
Coarray support from Fortran 2008/2018 is native Fortran high-level abstractions that are supported by a range of libraries, including OpenMPI.
Coarray examples are under``coarray/``.
By using ``htop`` or other CPU monitor, you can see that multiple CPU cores are used.

Hello World
~~~~~~~~~~~

.. code:: bash

    cafrun coarray/coarray_hello
    
    
Pi
~~
Compute value of Pi iteratively:

.. code:: bash

    cafrun coarray/coarray_pi
    
You can optionally specify the resolution of Pi, say 1e-:

.. code:: bash

    cafrun coarray/coarray_pi 1e-8
    
    
Comparing ``gfortran`` and ``ifort`` coarray performance (computation time in seconds on i7-4650, 4 threads).
``-O3`` was used for both compilers.
Notice that ``ifort`` is over 5x faster than ``gfortran``.

YES this was using pi2008.f90 for both, to ensure that Fortran 2018 ``co_sum()`` didn't have a disadvantage over the explicit Fortran 2008 loop.
The performance of ``co_sum`` was essentially the same in ``pi.f90`` as in ``pi2008.f90``.

=====  ==============  ==========
dx     gfortran 7.2.0  ifort 18.1
=====  ==============  ==========
1e-7   0.254           0.049
1e-8   2.72            0.489
1e-9   26.0            4.88
=====  ==============  ==========




OpenMPI
-------
Under the ``mpi/`` directory:

Hello World
~~~~~~~~~~~~~~~
To run the simplest sort of multi-threaded Fortran program using MPI-2, assuming you have a CPU with 8 virtual cores like an Intel Core i7

.. code:: bash

    mpirun -np 4 mpi/mpi_hello

Message Passing MPI
~~~~~~~~~~~~~~~~~~~
Pass data between two MPI threads

.. code:: bash

    mpirun -np 2 mpi/mpi_pass

Quiet NaN
---------
We might choose to use NaN as a sentinal value, where instead of returning separate "OK" logical variable from a function or subroutine, if a failure happens, we return NaN in one of the important variables.
There was a classical way to do this that was type specific, by setting the NaN bit pattern for your data type.
For example, for single-precision real you'd type

.. code:: fortran

    nan_bit = transfer(Z'7FF80000',1.)

For a standards-based way to handle all floating point types, you might consider

.. code:: fortran

    use, intrinsic :: ieee_arithmetic, only: ieee_value, ieee_quiet_nan
    nan_ieee = ieee_value(1.,ieee_quiet_nan)

This is in program::

    ./nan

In Fortran 2003, ``real(z'abcd0000')`` is equivalent to ``transfer(z'abcd0000',1.)`` by Fortran 2003.
However, where you are deliberately setting NaN you will get 

> Error: Result of FLOAT is NaN 

so use ``transfer()`` for the case where you're deliberately setting ``NaN``.

NOTE: you must NOT use ``-Ofast`` or ``-ffast-math`` because IEEE standards are broken by them and NaN detection will intermittently fail!

File Handling in Fortran
------------------------
Despite its half-century year old roots, Fortran 


Writing to /dev/null
~~~~~~~~~~~~~~~~~~~~~
Sometimes when modifying an old Fortran subroutine to load as a module in a new Fortran program, the old submodule writes a lot of unnecessary data to disk, that can be the primary compute time consumption of the submodule.
You can simply repoint the "open" statements to ``/dev/null``.
Benchmarks of NUL vs. scratch vs. file in::

    ./null

Read-only files and deletion in Fortran
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
The ``readonly`` program shows that even operation system read-only files can be deleted by Fortran, like ``rm -f`` with the ``close(u,status='delete')`` option::

    ./readonly

String handling in Fortran
--------------------------

Split strings about delimiter
-----------------------------
This splits a string once around a delimiter::

    ./split

And notes that it is probably best to use fixed length CHARACTER longer than you'll need.
If you're trying to load and parse a complicated text file, it is perhaps better to load that file first in Python, parse it, then pass it to Fortran via f2py (load Fortran code as a Python module).

f2py
----
simple f2py demo

.. code:: bash


    f2py -c fib3.f90 -m fib3

This creates a `fib3*.so` (Linux/Mac)  or `fib3*.pyd` (Windows), which is used by

.. code:: bash

    python -c "import fib3; print(fib3.fib(8))"

> [0. 1. 1. 2. 3. 5. 8. 13.]

or

.. code:: bash

    python -c "import fib3; print(fib3.fib3.fib(1478))"

> [  0.  1.  1. ...,
>   8.07763763e+307   1.30698922e+308    inf]

Note the file `.f2py_f2cmap`, which is vital to proper assigning of real and complex data types, particularly double precision.

.. code:: python

    dict(real= dict(sp='float', dp='double'),
    complex = dict(sp='complex_float',dp="complex_double"))


