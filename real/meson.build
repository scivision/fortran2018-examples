
#polymorph = executable('polymorph', 'polymorphic.F90')
# target_compile_definitions(['polymorph', 'PRIVATE', 'REALBITS=${realbits}'])
#test('Polymorphic', polymorph)

divprec = executable('divprec', 'div_precision.F90')
#if f08kind
  # target_compile_definitions(['divprec', 'PRIVATE', 'REAL128'])
#endif
test('DivisionPrecision', divprec)

floatprec = executable('floatprec', 'floating_precision.F90')
#if 'f08kind'
  # target_compile_definitions(['floatprec', 'PRIVATE', 'REAL128'])
#endif
test('FloatPrecision', floatprec)

hugeprec = executable('hugeprec', 'huge_precision.F90')
#if f08kind
  # target_compile_definitions(['hugeprec', 'PRIVATE', 'REAL128'])
#endif
test('HugePrecision', hugeprec)

#if f08kind
#  precprob = executable('precprob', 'precision_problems.f90')
#  test('PrecisionProblems', precprob)
#endif

#if 'f18prop'
#  properties = executable('properties', 'properties.f90')
  # target_compile_options(['properties', 'PRIVATE', fflags])
#  test('Fortran2018Properties', properties)
#endif

nan = executable('nan', 'nans.F90')
#  if 'f08kind'
    # target_compile_definitions(['nan', 'PRIVATE', 'REAL128', 'IEEENAN'])
#  endif
test('NaN', nan)

assert_lib = library('assert', 'assert.F90')
  # target_compile_options(['assert', 'PRIVATE', fflags])
  # target_link_libraries(['assert', 'PRIVATE', flibs])
  # target_compile_definitions(['assert', 'PRIVATE', 'REALBITS=${realbits}'])
  #if 'f08kind'
  #  testassert_exe = executable('testassert', 'not-finite.f90', 'fib3.f90')
    # target_link_libraries(['testassert', 'assert', flibs])
    # target_compile_options(['testassert', 'PRIVATE', fflags])
   # test('NAME', 'Assert', 'COMMAND', 'testassert')
  #endif
#endif
