[![image](https://travis-ci.org/scivision/fortran2018-examples.svg?branch=master)](https://travis-ci.org/scivision/fortran2018-examples)

[![image](https://ci.appveyor.com/api/projects/status/kk2gcmlw1l3pjxy5?svg=true)](https://ci.appveyor.com/project/scivision/fortran2018-examples)


# Fortran 2018 Examples

Easy examples of scientific computing with modern, powerful, easy
Fortran 2018 standard. Fortran 2018 began as the TS18508 extension,
formerly known as Fortran 2015.

## Prereq

* Linux / Windows: `apt install cmake gfortran libhdf5-dev libopenmpi-dev libnetcdff-dev libcoarrays-dev open-coarrays-bin`
* Mac: `brew install gcc cmake open-mpi opencoarrays`

## Build

The CMake script automatically walks through the subdirectories:

```bash
cd bin

cmake ..
make

make test
```

If you have Anaconda Python or Intel Fortran installed, this can
override system prereqs. Workaround:

```bash
PATH=/usr/bin:/usr/include cmake ..
make

make test
```

### ifort Intel

Be sure you have the 
[Intel Parallel Studio Cluster Edition](https://www.scivision.co/install-intel-compiler-icc-icpc-ifort/)
that has `mpiifort`.

```bash
FC=ifort CC=icc CXX=icpc cmake ..
make
```

-   the NetCDF and HDF5 libraries will need to be manually compiled with the Intel compiler.
-   need to `source compilervars.sh` as usual with the Intel compiler or you will get `*.so missing` errors.
-   for Intel compiler, build with

    ```bash
    cd bin
    FC=ifort CC=icc CXX=icpc cmake ..
    make

    make test
    ```

### Intel MKL

To mitigate the case where MKL is installed, but not yet 
[compiled forGfortran](https://www.scivision.co/intel-mkl-lapack95-gfortran/), 
the examples requiring LAPACK95 or other MKL-specific modules are enabled
with the `cmake -Dusemkl ..` option.

### Flang / Clang

Not every program runs yet with
[Flang](https://www.scivision.co/flang-compiler-build-tips/) since Flang
lacks a lot of Fortran 2008 standard stuff--like `error stop`

```bash
FC=flang CC=clang CXX=clang++ cmake ..
make

make test 
```

### PGI

Not every program runs yet with [PGI
compilers](https://www.pgroup.com/products/community.htm) since PGI
lacks a lot of Fortran 2008 standard stuff--like `error stop`

```bash
FC=pgf90 CC=pgcc CXX=pgc++ cmake ..
make

make test
```

## Programs

### Call Fortran from C++

You can easily use Fortran subroutines and functions from C and C++:

    ./cxx/cxxfort

The key factors in calling a Fortran module from C or C++ include:

-   use the standard C binding to define variable and bind
    functions/subroutines

    ```fortran
    use,intrinsic:: iso_c_binding, only: c_int, c_float, c_double

    integer(c_int) :: N
    real(c_double) :: X

    subroutine cool(X,N) bind(c)
    ```

    the `bind(c)` makes the name `cool` available to C/C++.

See `cxx/cxxfort.f90` and `fun.f90` for a simple exmaple.

### NetCDF

This example writes then reads a NetCDF file from Fortran:

    ./netcdf/writencdf

    ./netcdf/readncdf

### HDF5

A true modern Fortan polymorphic, simple HDF5 read/write interface, is
[my package](https://github.com/scivision/oo_hdf5_fortran/).

This example writes then reads an HDF5 file from Fortran:

    ./hdf5/hdf5demo

-   HDF5 Fortran [Manual](https://support.hdfgroup.org/HDF5/doc/fortran/index.html)

#### Note

DO NOT USE BOTH H5FC wrapper compiler and specify the Fortran HDF5
libraries (in the CMake file). This can cause version conflicts if you
have multiple versions of HDF5 installed. It causes non-obvious errors
that can waste your time.

In my opinion NOT using the wrapper compiler may be "safer" so that's
what the CMake file does.

### Coarray

Coarray support from Fortran 2008/2018 is native Fortran high-level
abstractions that are supported by a range of libraries, including
OpenMPI. Coarray examples are under`coarray/`. By using `htop` or other
CPU monitor, you can see that multiple CPU cores are used.

#### Hello World

```bash
cafrun coarray/coarray_hello
```

#### Pi

Compute value of Pi iteratively:

```bash
cafrun coarray/coarray_pi
```

You can optionally specify the resolution of Pi, say 1e-:

```bash
cafrun coarray/coarray_pi 1e-8
```

Comparing `gfortran` and `ifort` coarray performance (computation time
in seconds on i7-4650, 4 threads). `-O3` was used for both compilers.
Notice that `ifort` is over 5x faster than `gfortran`.

YES this was using pi2008.f90 for both, to ensure that Fortran 2018
`co_sum()` didn't have a disadvantage over the explicit Fortran 2008
loop. The performance of `co_sum` was essentially the same in `pi.f90`
as in `pi2008.f90`.

  dx    |gfortran 7.2.0  | ifort 18.1
--------|----------------|------------
  1e-7  | 0.254          | 0.049
  1e-8  | 2.72           | 0.489
  1e-9  | 26.0           | 4.88

### OpenMPI

Under the `mpi/` directory:

#### Hello World

To run the simplest sort of multi-threaded Fortran program using MPI-2,
assuming you have a CPU with 8 virtual cores like an Intel Core i7

```bash
mpirun -np 4 mpi/mpi_hello
```

#### Message Passing MPI

Pass data between two MPI threads

```bash
mpirun -np 2 mpi/mpi_pass
```

### Quiet NaN

We might choose to use NaN as a sentinal value, where instead of
returning separate "OK" logical variable from a function or subroutine,
if a failure happens, we return NaN in one of the important variables.
There was a classical way to do this that was type specific, by setting
the NaN bit pattern for your data type. For example, for
single-precision real you'd type

```fortran
nan_bit = transfer(Z'7FF80000',1.)
```

For a standards-based way to handle all floating point types, you might
consider

```fortran
use, intrinsic :: ieee_arithmetic, only: ieee_value, ieee_quiet_nan
nan_ieee = ieee_value(1.,ieee_quiet_nan)
```

This is in program:

    ./nan

In Fortran 2003, `real(z'abcd0000')` is equivalent to
`transfer(z'abcd0000',1.)` by Fortran 2003. However, where you are
deliberately setting NaN you will get

&gt; Error: Result of FLOAT is NaN

so use `transfer()` for the case where you're deliberately setting
`NaN`.

#### Notes

-   must NOT use `-Ofast` or `-ffast-math` because IEEE standards are
    broken by them and NaN detection will intermittently fail!
-   `gfortran` &gt;= 6 needed for `ieee_arithmetic: ieee_is_nan`

### File Handling in Fortran

Despite its half-century year old roots, Fortran

#### Writing to /dev/null

Sometimes when modifying an old Fortran subroutine to load as a module
in a new Fortran program, the old submodule writes a lot of unnecessary
data to disk, that can be the primary compute time consumption of the
submodule. You can simply repoint the "open" statements to `/dev/null`.
Benchmarks of NUL vs. scratch vs. file in:

    ./null

#### Read-only files and deletion in Fortran

The `readonly` program shows that even operation system read-only files
can be deleted by Fortran, like `rm -f` with the
`close(u,status='delete')` option:

    ./readonly

### String handling in Fortran

### Split strings about delimiter

This splits a string once around a delimiter:

    ./split

And notes that it is probably best to use fixed length CHARACTER longer
than you'll need. If you're trying to load and parse a complicated text
file, it is perhaps better to load that file first in Python, parse it,
then pass it to Fortran via f2py (load Fortran code as a Python module).

### f2py

simple f2py demo

```bash
f2py -c fib3.f90 -m fib3
```

This creates a fib3*.so (Linux/Mac) or fib3*.pyd (Windows), which is
used by

```bash
python -c "import fib3; print(fib3.fib(8))"
```

> [0. 1. 1. 2. 3. 5. 8. 13.]

or

```bash
python -c "import fib3; print(fib3.fib3.fib(1478))"
```

> [ 0. 1. 1. ..., &gt; 8.07763763e+307 1.30698922e+308 inf]

Note the file `.f2py_f2cmap`, which is vital to proper assigning of real
and complex data types, particularly double precision.

```python
dict(real= dict(sp='float', dp='double'),
complex = dict(sp='complex_float',dp="complex_double"))
```
