project('Fortran2018examples', 'fortran', 'cpp', 'c',
  version : '1.0.0',
  default_options : ['default_library=static', 'buildtype=release', 'cpp_std=c++17'])

add_global_arguments('-g', language : 'fortran')

fc = meson.get_compiler('fortran')
if fc.get_id() == 'gcc'
  add_global_arguments('-Wextra', '-Wpedantic', language : 'fortran')
endif

f18errorstop = fc.links('character :: b; error stop b; end', name: 'F2018 error stop')

subdir('array')
subdir('benchmarks')
subdir('character')
subdir('coarray')
subdir('contiguous')
subdir('cxx')
subdir('debug')
subdir('hdf5')
subdir('io')
subdir('mpi')
subdir('netcdf')
subdir('openmp')
subdir('standard')
subdir('system')
