
r128 = f08kind ? '-DREAL128' : ''

polymorph = executable('polymorph', 'polymorphic.F90',
  fortran_args: '-DREALBITS='+realbits)
test('real:Polymorphic', polymorph,
  timeout: 10)

divprec = executable('divprec', 'div_precision.F90',
  fortran_args: r128)
test('real:DivisionPrecision', divprec,
  timeout: 10)

floatprec = executable('floatprec', 'floating_precision.F90',
  fortran_args: r128)
test('real:FloatPrecision', floatprec,
  timeout: 10)

hugeprec = executable('hugeprec', 'huge_precision.F90',
  fortran_args: r128)
test('real:HugePrecision', hugeprec,
  timeout: 10)

if f08kind
  precprob = executable('precprob', 'precision_problems.f90')
  test('real:PrecisionProblems', precprob,
    timeout: 15)
endif

if f18prop
  properties = executable('properties', 'properties.f90')
  test('real:Fortran2018 Properties', properties,
    timeout: 10)
endif

nanargs = f08kind ? [r128, '-DIEEENAN'] : []
nan = executable('nan', 'nans.F90',
  fortran_args: nanargs)
test('NaN', nan,
  timeout: 10)

assert_lib = library('assert', 'assert.F90',
  fortran_args: '-DREALBITS='+realbits)

if f08kind
  testassert_exe = executable('testassert', 'not-finite.f90', 'fib3.f90',
    link_with: assert_lib)
  test('real:Assert', testassert_exe,
    timeout: 10)
endif
