short_circuit = executable('shortcircuit', 'short_circuit.f90')
# test is too unreliable--sometimes pass sometimes fail, that's the point.

bitpat= executable('bitpat', 'bitpat.f90')
test('standard:Bit Pattern', bitpat,
  suite: 'standard',
  timeout: 10)

justwait_exe = executable('justwait', 'pause.f90')

mkdir_src = ['intel', 'intel-cl'].contains(fc.get_id()) ? files('isdir_intel.f90') : files('isdir.f90')

mkdirstd = executable('mkdirstd',
  sources: ['mkdir.f90', mkdir_src])
test('standard:mkdir', mkdirstd,
  args: 'testdir/hello',
  suite: 'standard',
  timeout: 20)

sleep_std = library('sleep_std', 'sleep_std.F90')

sleep_demo = executable('sleep_demo', 'sleep_demo.f90',
  link_with: sleep_std)
test('standardSleep', sleep_demo,
  suite: 'standard',
  timeout : 5)


statement = executable('statement', 'statement_function.f90')
test('standard:Statement', statement,
  suite: 'standard',
  timeout: 10)
