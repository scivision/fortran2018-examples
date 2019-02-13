
hdf5 = dependency('HDF5', language : 'fortran', required : false)

if fc.links('use h5lt; end', dependencies : hdf5)

h5mod= library('h5mod', 'h5mod.f90', dependencies : hdf5)

h5simple = executable('h5simple', 'hdf5simple.f90', link_with : h5mod)
test('HDF5mod', h5simple, args : '5')

stest = executable('stest', 'test.f90',
 fortran_args : '-w', dependencies : hdf5)
test('HDF5',  stest)

endif
