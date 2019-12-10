
if not add_languages('cpp', required: false)
  subdir_done()
endif

if os == 'darwin'
  message('SKIP: cxx on Mac')
  subdir_done()
endif

call_f = library('call_f', 'c_call_f.f90')
c_call_f = executable('c_call_f', 'cxx_call_f.cxx', link_with: call_f)
test('C++ calling Fortran', c_call_f, timeout: 10, suite: 'cxx')

c_lib = library('call_c', 'call_c.c')
f_call_c = executable('f_call_c', 'f_call_c.f90',
  link_with: c_lib,
  link_language: 'fortran')
test('Fortran calling C', f_call_c, timeout: 10, suite: 'cxx')

cxx_lib = library('call_cxx', 'call_cxx.cxx')
f_call_cxx = executable('f_call_cxx', 'f_call_cxx.f90',
  link_with: cxx_lib,
  link_language: 'fortran')
test('Fortran calling C++', f_call_cxx, timeout: 10, suite: 'cxx')
