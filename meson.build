project('Fortran2018examples', 'fortran', 'c',
  version : '1.0.0',
  default_options : ['default_library=static', 'buildtype=release', 'cpp_std=c++14', 'fortran_std=f2018'])

realbits = get_option('realbits')

subdir('meson') # must be before other subdirs to get compiler capabilities and libraries

subdir('array')
subdir('benchmarks')
subdir('block')
subdir('character')
subdir('coarray')
subdir('contiguous')
subdir('cxx')
subdir('debug')
subdir('hdf5')
subdir('io')
# subdir('lapack95')
subdir('mpi')
subdir('mumps')
subdir('namelist')
subdir('netcdf')
subdir('openmp')
subdir('overloading')
subdir('random')
subdir('real')
subdir('standard')
subdir('submodule')
subdir('system')
