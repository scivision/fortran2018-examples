project('Fortran2018examples', 'fortran', 'cpp', 'c',
  version : '1.0.0',
  default_options : ['default_library=static', 'buildtype=release', 'cpp_std=c++14'])

realbits = get_option('realbits')

fc = meson.get_compiler('fortran')
if fc.get_id() == 'gcc'
  add_global_arguments('-fimplicit-none', '-Wextra', '-Wpedantic', language : 'fortran')
  if fc.version().version_compare('>=8.0')
    add_global_arguments('-std=f2018', language: 'fortran')
  endif
  oldargs = ['-std=legacy', '-w']
elif fc.get_id() == 'intel'
  add_global_arguments('-stand', 'f18', '-warn declarations', language: 'fortran')
  oldargs = '-nowarn'
elif fc.get_id() == 'intel-cl'
  # /fpp allows #include etc preprocessor lines
   add_global_arguments('/stand:f18', '/warn:declarations', '/fpp', language: 'fortran')
   oldargs = '/nowarn'
elif fc.get_id() == 'pgi'
   add_global_arguments('-C', '-Mdclchk', language: 'fortran')
   oldargs = '-w'
elif fc.get_id() == 'flang'
  add_global_arguments('-W', language: 'fortran')
  oldargs = '-w'
endif

os = host_machine.system()

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
# subdir('lapack95')
subdir('mpi')
subdir('mumps')
subdir('netcdf')
subdir('openmp')
subdir('overloading')
subdir('random')
subdir('real')
subdir('standard')
subdir('system')
