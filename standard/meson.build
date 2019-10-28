short_circuit = executable('shortcircuit', 'short_circuit.f90')
# test is too unreliable--sometimes pass sometimes fail, that's the point.

bitpat= executable('bitpat', 'bitpat.f90')
test('standard:Bit Pattern', bitpat,
  timeout: 10)

justwait_exe = executable('justwait', 'pause.f90')

mkdir_src = fc.get_id() == 'intel' or fc.get_id() == 'intel-cl' ? files('isdir_intel.f90') : files('isdir.f90')
mkdirstd = executable('mkdirstd',
  sources: ['mkdir.f90', mkdir_src])
test('standard:mkdir', mkdirstd, args: 'testdir/hello',
  timeout: 20)

if os != 'windows' or fc.get_id() == 'gcc'
  # gcc has unistd.h on Windows via MinGW
  sleepstd = executable('sleepstd', 'sleep.f90')
  test('standard:Micro sleep', sleepstd,
    timeout : 5)
endif

statement = executable('statement', 'statement_function.f90')
test('standard:Statement', statement,
  timeout: 10)
