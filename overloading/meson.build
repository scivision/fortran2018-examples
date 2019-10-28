proc = executable('proc', 'pragma.f90')
test('Pragma', proc,
  timeout: 10)

if f18errorstop
  f18es_exe = executable('f18es', 'f2018errorstop.f90')
  test('F18errorstop', f18es_exe, should_fail: true)
endif
