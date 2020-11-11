conf_data = configuration_data()
conf_data.set('real_prec', 'integer,parameter :: wp=real' + realbits)
configure_file(input : 'polymorphic.in.f90',
               output : 'polymorphic.f90',
               configuration : conf_data)

polymorph = executable('polymorph', meson.current_build_dir() / 'polymorphic.f90')
test('Polymorphic', polymorph, suite: 'real', timeout: 10)

coerce = executable('coerce', 'coerce.f90')
test('Coerce', coerce, suite: 'real', timeout: 10)

eps = executable('epsilon', 'epsilon.f90')
test('Epsilon1', eps, suite: 'real', timeout: 10)

if f08kind
  divprec = executable('divprec', 'div_precision.f90')
  test('DivisionPrecision', divprec, suite: 'real', timeout: 10)

  floatprec = executable('floatprec', 'floating_precision.f90')
  test('FloatPrecision', floatprec, suite: 'real', timeout: 10)

  hugeprec = executable('hugeprec', 'huge_precision.f90')
  test('HugePrecision', hugeprec, suite: 'real', timeout: 10)

  precprob = executable('precprob', 'precision_problems.f90')
  test('PrecisionProblems', precprob, suite: 'real', timeout: 15)
endif

if f18prop
  properties = executable('properties', 'properties.f90')
  test('Fortran2018 Properties', properties, suite: 'real', timeout: 10)
endif

assert_lib = library('assert', 'assert.f90')

if f08kind
  nan = executable('nan', 'nans.f90')
  test('NaN', nan, suite: 'real', timeout: 10)

  testassert_exe = executable('testassert', 'finite.f90',
    link_with: assert_lib)
  test('Assert', testassert_exe, suite: 'real', timeout: 10)
endif
