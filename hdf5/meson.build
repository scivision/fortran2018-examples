hdf5 = dependency('HDF5', language : 'fortran', required : false, disabler: true)

if hdf5.found() and not fc.links('use h5lt; end', name: 'HDF5', dependencies : hdf5)
hdf5 = disabler()
endif

h5mod = library('h5mod', 'h5mod.f90', dependencies : hdf5)

h5simple = executable('h5simple', 'hdf5simple.f90',
  link_with : h5mod)
test('HDF5mod', h5simple,
  args : '5',
  timeout: 15)

stest = executable('stest', 'test.f90',
 fortran_args : '-w',
 dependencies : hdf5)
test('HDF5',  stest,
  timeout: 15)
