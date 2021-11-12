
src = f18random ? files('random_init_f2018.f90') : files('random_init.f90')

random = executable('random',
sources: ['random.f90', 'random_demo.f90', src]
)

test('RandomInit', random,
suite: 'random',
timeout: 10
)
