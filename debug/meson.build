bad_alloc = executable('bad_alloc', 'badalloc.f90')

boundsargs = fc.get_id() == 'gcc' ? '-fcheck=bounds' : []

badbounds = executable('badbounds', 'badbounds.f90',
  fortran_args : boundsargs)
# Too unreliable to test--that's the point.
