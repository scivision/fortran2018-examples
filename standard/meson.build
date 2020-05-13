short_circuit = executable('shortcircuit', 'short_circuit.f90')
# test is too unreliable--sometimes pass sometimes fail, that's the point.

bitpat= executable('bitpat', 'bitpat.f90')
test('Bit Pattern', bitpat, suite: 'standard', timeout: 10)

big_integer = executable('big_integer', 'big_integer.f90')
test('BigInteger', big_integer, suite: 'standard', timeout: 5)

justwait_exe = executable('justwait', 'pause.f90')

sleep_std = library('sleep_std', 'sleep_std.F90')

sleep_demo = executable('sleep_demo', 'sleep_demo.f90',
  link_with: sleep_std)
test('sleep', sleep_demo, suite: 'standard', timeout : 5)


statement = executable('statement', 'statement_function.f90')
test('Statement', statement, suite: 'standard', timeout: 10)
