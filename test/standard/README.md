# Fortran standard coding

Examples of standard and non-standard coding

* statement_function.f90: making statement function into regular function
* pause.f90: replace pause with standard statements.
* mkdir.f90: mkdir() is standard Fortran using C

## Fortran 2008 contiguous arrays

Fortran 2018 `contiguous` arrays are discussed in pp.139-145 of "Modern Fortran Explained: Incorporating Fortran 2018".
In general, operating on contiguous arrays is faster than non-contiguous arrays.
A non-contiguous array actual argument into a `contiguous` subroutine dummy argument is made contiguous by copy-in, copy-out.
This copy-in copy-out as needed is part of the
[Fortran 2008](https://j3-fortran.org/doc/year/11/11-199r2.txt)
and
[Fortran 2018](https://groups.google.com/g/comp.lang.fortran/c/QiFkx8b48uw/m/ztIzsJ7sFwAJ)
standard.
[GCC &ge; 9](https://gcc.gnu.org/gcc-9/changes.html),
[Intel oneAPI](https://www.intel.com/content/www/us/en/developer/articles/technical/fortran-array-data-and-arguments-and-vectorization.html),
[IBM Open XL Fortran](https://www.ibm.com/docs/en/openxl-fortran-aix/17.1.1?topic=attributes-contiguous-fortran-2008),
etc. work to Fortran 2008+ standard for `contiguous` dummy argument copy-in, copy-out for non-contiguous actual argument.

References: [Fortran 2008 Contiguity](https://www.ibm.com/docs/en/openxl-fortran-aix/17.1.0?topic=concepts-contiguity-fortran-2008)
