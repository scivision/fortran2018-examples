abstract_interface = executable('abstract_interface', 'abstract.f90')

short_circuit = executable('shortcircuit', 'short_circuit.f90')
# test is too unreliable--sometimes pass sometimes fail, that's the point.

bitpat = executable('bitpat', 'bitpat.f90')
test('Bit Pattern', bitpat, suite: 'standard', timeout: 10)

cycler = executable('do_cycle', 'do_cycle.f90')
test('doCycle', cycler, suite: 'standard', timeout: 5)

boolean_c = executable('boolean_c', 'logical_kind.c')
test('boolean_c', boolean_c, suite : 'standard')

logical_f = executable('logical_f', 'logical_kind.f90')
test('logical_kind', logical_f, suite : 'standard')

big_integer = executable('big_integer', 'big_integer.f90')
test('BigInteger', big_integer, suite: 'standard', timeout: 5)

justwait_exe = executable('justwait', 'pause.f90')

sleep_src = os == 'windows' ? files('sleep_win.f90') : files('sleep_unix.f90')
sleep_std = library('sleep_std', sleep_src)

sleep_demo = executable('sleep_demo', 'sleep_demo.f90',
  link_with: sleep_std)
test('sleep', sleep_demo, suite: 'standard', timeout : 5)


statement = executable('statement', 'statement_function.f90')
test('Statement', statement, suite: 'standard', timeout: 10)

nanmaxmin_exe = executable('nanmaxmin', 'maxmin_nan.f90')
test('NaNminmax', nanmaxmin_exe,
  suite: 'debug',
  timeout: 10)
