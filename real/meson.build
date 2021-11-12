conf_data = configuration_data()
conf_data.set('real_prec', 'integer,parameter :: wp=real' + realbits)
configure_file(input : 'polymorphic.in.f90',
               output : 'polymorphic.f90',
               configuration : conf_data)

assert_lib = library('assert', 'assert.f90')
testassert_exe = executable('testassert', 'finite.f90',
  link_with: assert_lib)
test('Assert', testassert_exe, suite: 'real')

cast = executable('cast_int2real', 'cast_int2real.f90')
test('CastInt2Real', cast, suite: 'real')

polymorph = executable('polymorph', meson.current_build_dir() / 'polymorphic.f90')
test('Polymorphic', polymorph, suite: 'real')

eps = executable('epsilon',
sources: 'epsilon.f90',
fortran_args: '-Dr128'
)
test('Epsilon1', eps, suite: 'real')

coerce = executable('coerce',
sources: 'coerce.F90',
fortran_args: '-Dr128'
)
test('Coerce', coerce, suite: 'real')

divprec = executable('divprec',
sources: 'div_precision.F90',
fortran_args: '-Dr128'
)
test('DivisionPrecision', divprec, suite: 'real')

floatprec = executable('floatprec',
sources: 'floating_precision.F90',
fortran_args: '-Dr128'
)
test('FloatPrecision', floatprec, suite: 'real')

hugeprec = executable('hugeprec',
sources: 'huge_precision.F90',
fortran_args: '-Dr128'
)
test('HugePrecision', hugeprec, suite: 'real')

precprob = executable('precprob', 'precision_problems.f90')
test('PrecisionProblems', precprob, suite: 'real')

nan = executable('nan',
sources: 'nans.F90',
fortran_args: '-Dr128'
)
test('NaN', nan, suite: 'real')

if f18prop
  properties = executable('properties', 'properties.f90')
  test('Fortran2018 Properties', properties, suite: 'real')
endif
