====================
fortran2015-examples
====================
Easy examples of scientific computing with modern, powerful, easy Fortran 2015 standard

.. contents::


Prereq
======
Runs anywhere, on Linux do::

    sudo apt-get install cmake gfotran libopenmpi-dev

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



