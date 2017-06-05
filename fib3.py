#!/usr/bin/env python
import fib3
from numpy.testing import assert_allclose

def test_fib(N):

    assert fib3.fib3.pi64.dtype == 'float64'
    assert_allclose(fib3.fib3.pi64,3.141592653589793)

    print(fib3.fib3.fib(N))

if __name__ == '__main__':
    from argparse import ArgumentParser
    p = ArgumentParser()
    p.add_argument('N',nargs='?',type=int,default=8)
    p = p.parse_args()

    test_fib(p.N)
