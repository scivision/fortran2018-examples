project('Fortran2018examples', 'fortran', 'cpp', 'c',
  version : '1.0.0',
  default_options : ['default_library=static'])

add_global_arguments('-g', language : 'fortran')

fc = meson.get_compiler('fortran')
if fc.get_id() == 'gcc'
  add_global_arguments('-Wall', '-Wextra', '-Wpedantic', language : 'fortran')
endif


subdir('cxx')
subdir('mpi')
subdir('system')
