
# Fortran 2008 contiguous arrays

Fortran 2018 `contiguous` arrays are discussed in pp.139-145 of "Modern Fortran Explained: Incorporating Fortran 2018".
In general, operating on contiguous arrays is faster than non-contiguous arrays.
However, if copy-in, copy-out is needed from non-contiguous arrays, the speed benefit is not guaranteed.
For the basic case, a non-contigous array will have a temporary array copy made for the operation.

It seems that GNU Fortran may have a bug across several Gfortran versions (including Gfortran 4.8 through 8.2) where a non-contiguous array actual argument into a `contiguous` subroutine dummy argument leads to SIGSEGV or SIGABRT, except for very small arrays.
This did not seem to be affected by system `ulimit` size or by `-fmax-stack-var-size`.
Other compilers such as `ifort`, `flang`, and `pgf90` had no problem with the same test program.

This example uses preprocessing to handle the additional annoyance that Gfortran through at least version 8 did not support Fortran 2008 intrinsic `is_contiguous()`.


