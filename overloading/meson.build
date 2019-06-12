
proc = executable('proc', 'pragma.f90')

test('Pragma', proc)

if f18errorstop
  if os == 'windows' and fc.get_id() == 'pgi'
    message('PGI bug on Windows')
    subdir_done()
  else
    f18es_exe = executable('f18es', 'f2018errorstop.f90')
    test('F18errorstop', f18es, should_fail: true)
  endif
endif
