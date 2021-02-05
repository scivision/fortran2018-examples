
timeprec = executable('timeprec', 'timeprec.f90', dependencies : openmp)
test('TimeMeasure', timeprec, is_parallel: false, suite: 'OpenMP', timeout: 30)
