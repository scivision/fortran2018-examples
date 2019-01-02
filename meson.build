project('Fortran2018examples', 'fortran',
  version : '1.0.0')

add_global_arguments('-g', language : 'fortran')

fc = meson.get_compiler('fortran')

if fc.get_id() == 'gcc'
  add_global_arguments('-Wall', '-Wextra', '-Wpedantic', language : 'fortran')
endif

#subdir('submodule')  # broken at least through meson 0.49 
# https://github.com/mesonbuild/meson/issues/4704

subdir('system')
