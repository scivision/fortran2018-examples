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
