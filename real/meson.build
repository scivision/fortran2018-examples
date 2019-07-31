f08kind = fc.links('''
use, intrinsic:: iso_fortran_env, only: real128
use, intrinsic:: ieee_arithmetic, only: ieee_is_nan

if (huge(0._real128) /= 1.18973149535723176508575932662800702E+4932_real128) stop 1

end program''', name: 'F2008 ieee kinds')

f18prop = fc.links('complex :: z; print *,z%re,z%im,z%kind; end',
  name: 'F2018 properties')

if f08kind
  r128 = '-DREAL128'
else
  r128 = ''
endif

polymorph = executable('polymorph', 'polymorphic.F90',
  fortran_args: '-DREALBITS='+realbits)
test('real:Polymorphic', polymorph)

divprec = executable('divprec', 'div_precision.F90',
  fortran_args: r128)
test('real:DivisionPrecision', divprec)

floatprec = executable('floatprec', 'floating_precision.F90',
  fortran_args: r128)
test('real:FloatPrecision', floatprec)

hugeprec = executable('hugeprec', 'huge_precision.F90',
  fortran_args: r128)
test('real:HugePrecision', hugeprec)

if f08kind
  precprob = executable('precprob', 'precision_problems.f90')
  test('real:PrecisionProblems', precprob)
endif

if f18prop
  properties = executable('properties', 'properties.f90')
  test('real:Fortran2018 Properties', properties)
endif

if f08kind
  nanargs = [r128, '-DIEEENAN']
else
  nanargs = []
endif
nan = executable('nan', 'nans.F90',
  fortran_args: nanargs)
test('NaN', nan)

assert_lib = library('assert', 'assert.F90',
  fortran_args: '-DREALBITS='+realbits)

if f08kind
  testassert_exe = executable('testassert', 'not-finite.f90', 'fib3.f90',
    link_with: assert_lib)
  test('real:Assert', testassert_exe)
endif
