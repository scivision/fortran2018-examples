
f18random = fc.links('call random_init(.false., .false.); end', name:'F2018 random_init')

if f18random
  src = files('random_init_f2018.f90')
else
  src = files('random_init.f90')
endif

random = executable('random', 'random.f90', 'random_demo.f90', src)
test('RandomInit', random)
