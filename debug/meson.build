
if fc.get_id() == 'gcc'
  boundsargs = '-fcheck=bounds'
  xfail = true
else
  boundsargs = []
  xfail = false
endif

badbounds = executable('badbounds', 'badbounds.f90', fortran_args : boundsargs)
test('BoundsFail', badbounds, should_fail : xfail)

nanmaxmin_exe = executable('nanmaxmin', 'maxmin_nan.f90')
typecast_exe = executable('typecast', 'typecast.f90')
