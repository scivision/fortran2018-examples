minimal = executable('minimal', 'minimal.f90')
test('Minimal same-file submodule', minimal)

basic = executable('basic', ['basic.f90', 'basic_sub.f90'])
test('Basic Submodule 2 files', basic)

points = executable('points', ['points.f90', 'geo.f90'])
test('another 2 file example', points)
