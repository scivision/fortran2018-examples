project('Fortran2018examples', 'fortran', 'c',
  version : '1.2.3',
  meson_version: '>= 0.52.0',
  default_options : ['default_library=static', 'buildtype=release', 'warning_level=3',
                     'cpp_std=c++11'])

realbits = get_option('realbits')

subdir('meson') # must be before other subdirs to get compiler capabilities and libraries

subdir('standard') # modules used by other programs

subdir('array')
subdir('benchmarks')
subdir('block')
subdir('character')
subdir('coarray')
subdir('contiguous')
subdir('cxx')
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
