
timeprec = executable('timeprec', 'timeprec.f90', dependencies : openmp)
test('OpenMP:TimeMeasure', timeprec,
  is_parallel: false,
  timeout: 30)
