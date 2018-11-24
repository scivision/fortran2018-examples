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

### NaN Notes

* must NOT use `-Ofast` or `-ffast-math` because IEEE standards are broken by these options--NaN detection will intermittently fail!
* `gfortran` &ge; 6 needed for `ieee_arithmetic: ieee_is_nan`

## f2py

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
