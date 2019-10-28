
boundsargs = fc.get_id() == 'gcc' ? '-fcheck=bounds' : []

badbounds = executable('badbounds', 'badbounds.f90',
  fortran_args : boundsargs)
# Too unreliable to test--that's the point.

nanmaxmin_exe = executable('nanmaxmin', 'maxmin_nan.f90')
test('debug: NaN min, max', nanmaxmin_exe,
  timeout: 10)

typecast_exe = executable('typecast', 'typecast.f90',
  fortran_args: oldargs)
test('debug: typecase', typecast_exe,
  timeout: 10)