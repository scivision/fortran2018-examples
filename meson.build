project('Fortran2018examples', 'fortran', 'c',
  version : '1.0.0',
  default_options : ['default_library=static', 'buildtype=release', 'cpp_std=c++14'])

realbits = get_option('realbits')

fc = meson.get_compiler('fortran')
f18flag = fc.first_supported_argument(['-std=f2018', '-stand f18', '/stand:f18'])
impnone = fc.first_supported_argument(['-fimplicit-none', '-warn declarations', '/warn:declarations', '-Mdclchk'])
oldargs = fc.first_supported_argument(['-w', '-nowarn', '/nowarn'])
if fc.get_id() == 'gcc'
  add_global_arguments('-Wextra', '-Wpedantic', f18flag, impnone, language : 'fortran')
  oldargs += '-std=legacy'
elif fc.get_id() == 'intel'
  add_global_arguments(f18flag, impnone, language: 'fortran')
elif fc.get_id() == 'intel-cl'
  # /fpp allows #include etc preprocessor lines
   add_global_arguments(f18flag, impnone, '/fpp', language: 'fortran')
elif fc.get_id() == 'pgi'
   add_global_arguments('-C', impnone, language: 'fortran')
elif fc.get_id() == 'flang'
  add_global_arguments('-W', language: 'fortran')
endif

os = host_machine.system()

f18errorstop = fc.links('character :: b; error stop b; end', name: 'F2018 error stop')

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
subdir('system')

submodule_proj = subproject('submodule')
