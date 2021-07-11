project('Fortran2018examples', 'fortran', 'c',
  version : files('VERSION'),
  meson_version: '>= 0.57.0',
  default_options : ['default_library=static', 'buildtype=release', 'warning_level=0'])

realbits = get_option('realbits')

subdir('meson') # must be before other subdirs to get compiler capabilities and libraries

subdir('standard') # modules used by other programs

subdir('array')
subdir('benchmarks')
subdir('block')
subdir('character')
subdir('contiguous')
subdir('debug')
subdir('io')
subdir('maximum')
subdir('namelist')
subdir('openmp')
subdir('overloading')
subdir('random')
subdir('real')
subdir('submodule')
subdir('system')
