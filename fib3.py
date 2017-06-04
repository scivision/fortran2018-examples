#!/usr/bin/env python
import fib3
from numpy.testing import assert_allclose

assert fib3.fib3.pi64.dtype == 'float64'
assert_allclose(fib3.fib3.pi64,3.141592653589793)
