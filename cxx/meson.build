
if fc.get_id() == 'pgi'
  message('Meson bug with PGI')
  subdir_done()
endif


call_f = library('call_f', 'c_call_f.f90')
c_call_f = executable('c_call_f', 'cxx_call_f.cxx', link_with: call_f)
test('C++ calling Fortran', c_call_f)

#call_c = library('call_c', 'call_c.c')
#f_call_c = executable('f_call_c', 'f_call_c.f90',
#  link_with: call_c,
#  link_language: 'fortran')
#test('Fortran calling C', f_call_c)

