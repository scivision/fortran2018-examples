r128 = f08kind ? '-DREAL128' : ''

polymorph = executable('polymorph', 'polymorphic.F90',
  fortran_args: '-DREALBITS='+realbits)
test('Polymorphic', polymorph,
  suite: 'real',
  timeout: 10)

divprec = executable('divprec', 'div_precision.F90',
  fortran_args: r128)
test('DivisionPrecision', divprec,
  suite: 'real',
  timeout: 10)

floatprec = executable('floatprec', 'floating_precision.F90',
  fortran_args: r128)
test('FloatPrecision', floatprec,
  suite: 'real',
  timeout: 10)

hugeprec = executable('hugeprec', 'huge_precision.F90',
  fortran_args: r128)
test('HugePrecision', hugeprec,
  suite: 'real',
  timeout: 10)

if f08kind
  precprob = executable('precprob', 'precision_problems.f90')
  test('PrecisionProblems', precprob,
    suite: 'real',
    timeout: 15)
endif

if f18prop
  properties = executable('properties', 'properties.f90')
  test('Fortran2018 Properties', properties,
    suite: 'real',
    timeout: 10)
endif

nanargs = f08kind ? [r128, '-DIEEENAN'] : []
nan = executable('nan', 'nans.F90',
  fortran_args: nanargs)
test('NaN', nan,
  suite: 'real',
  timeout: 10)

assert_lib = library('assert', 'assert.F90',
  fortran_args: '-DREALBITS='+realbits)

if f08kind
  testassert_exe = executable('testassert', 'not-finite.f90', 'fib3.f90',
    link_with: assert_lib)
  test('Assert', testassert_exe,
    suite: 'real',
    timeout: 10)
endif
