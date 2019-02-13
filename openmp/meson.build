openmp = dependency('openmp', language : 'fortran', required : false)

if fc.links('use omp_lib; rate = omp_get_wtick(); end', dependencies : openmp)
  timeprec = executable('timeprec', 'timeprec.f90', dependencies : openmp)
  test('OpenMP TimeMeasure', timeprec)
endif
