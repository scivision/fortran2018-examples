openmp = dependency('openmp', language : 'fortran', required : false)

if not fc.links('use omp_lib; rate = omp_get_wtick(); end', name: 'OpenMP', dependencies : openmp)
openmp = disabler()
endif

timeprec = executable('timeprec', 'timeprec.f90', dependencies : openmp)
test('OpenMP:TimeMeasure', timeprec)
