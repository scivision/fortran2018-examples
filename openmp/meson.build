openmp = dependency('openmp', language : 'fortran', required : false)

if not openmp.found()
  subdir_done()
endif

if fc.links('use omp_lib; rate = omp_get_wtick(); end', name: 'OpenMP', dependencies : openmp)
  timeprec = executable('timeprec', 'timeprec.f90', dependencies : openmp)
  test('OpenMP:TimeMeasure', timeprec)
endif
