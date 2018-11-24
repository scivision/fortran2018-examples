# Coarrays

Coarrays from Fortran 2008/2018 are native Fortran high-level abstractions that are supported by a range of libraries, including OpenMPI. 
By using `htop` or other CPU monitor, you can see that multiple CPU cores are used.

## Pi

Compute value of Pi iteratively:

```bash
cafrun coarray/coarray_pi
```

You can optionally specify the resolution of Pi, say 1e-8:

```bash
cafrun coarray/coarray_pi 1e-8
```

Comparing `gfortran` and `ifort` coarray performance (computation time in seconds on i7-4650, 4 threads). `-O3` was used for both compilers.
Notice that `ifort` is over 5x faster than `gfortran`.

YES this was using pi2008.f90 for both, to ensure that Fortran 2018 `co_sum()` didn't have a disadvantage over the explicit Fortran 2008 loop. 
The performance of `co_sum` was essentially the same in `pi.f90` as in `pi2008.f90`.

  dx    |gfortran 7.2.0  | ifort 18.1
--------|----------------|------------
  1e-7  | 0.254          | 0.049
  1e-8  | 2.72           | 0.489
  1e-9  | 26.0           | 4.88
