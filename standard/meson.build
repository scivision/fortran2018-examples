f08block = fc.links('block; end block; end', name : 'F2008 block')

if f08block
  block_exe = executable('block', 'block.f90')
endif

shortcircuit = executable('shortcircuit', 'short_circuit.f90')
test('Short Circuit', short_circuit)

bitpat= executable('bitpat', 'bitpat.f90')
test('Bit Pattern', bitpat)

justwait_exe = executable('justwait', 'pause.f90')

if fc=='intel'
  mkdir_src = files('isdir_intel.f90')
else
  mkdir_src = files('isdir.f90')
endif
mkdirstd = executable('mkdirstd', 'mkdir.f90', mkdir_src)
test('mkdir', mkdirstd, args: 'testdir/hello')

if os != 'windows'
sleepstd = executable('sleepstd', 'sleep.f90')
test('Micro sleep', sleepstd, timeout : 1)
endif

statement = executable('statement', 'statement_function.f90')
test('Statement', statement)
