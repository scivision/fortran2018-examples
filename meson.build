project('Fortran2018examples', 'fortran', 'c',
  version : '1.3.4',
  meson_version: '>= 0.52.0',
  default_options : ['default_library=static', 'buildtype=release'])

realbits = get_option('realbits')

subdir('meson') # must be before other subdirs to get compiler capabilities and libraries

subdir('standard') # modules used by other programs

subdir('array')
subdir('benchmarks')
subdir('block')
subdir('character')
subdir('coarray')
subdir('contiguous')
subdir('debug')
subdir('io')
subdir('lapack95')
subdir('maximum')
subdir('mpi')
subdir('namelist')
subdir('openmp')
subdir('overloading')
subdir('random')
subdir('real')
subdir('submodule')
subdir('system')
