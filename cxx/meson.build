#c = library('cf', 'c_call_f.f90')
#call_f = executable('c_call_f', 'cxx_call_f.cxx', link_with: c)

call_f = executable('c_call_f', 'c_call_f.f90', 'cxx_call_f.cxx')
test('C++ calling Fortran', call_f)

call_c = executable('f_call_c', 'call_c.c', 'f_call_c.f90')
test('Fortran calling C', call_c)

