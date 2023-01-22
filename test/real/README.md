# Real floating point numbers

## Quiet NaN

We might choose to use NaN as a sentinal value, where instead of
returning separate "OK" logical variable from a function or subroutine,
if a failure happens, we return NaN in one of the important variables.
There was a classical way to do this that was type specific, by setting
the NaN bit pattern for your data type. For example, for
single-precision real you'd type

```fortran
nan_bit = transfer(Z'7FF80000',1.)
```

For a standards-based way to handle all floating point types, consider:

```fortran
use, intrinsic :: ieee_arithmetic, only: ieee_value, ieee_quiet_nan

nan = ieee_value(1.,ieee_quiet_nan)
```

This is in program [real/nans.f90](./real/nans.f90)

NaN must NOT use Gfortran `-Ofast` or `-ffast-math` because IEEE standards are broken by these options--NaN detection will intermittently fail.
