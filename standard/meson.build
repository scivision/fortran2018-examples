f08block = fc.links('block; end block; end', name : 'F2008 block')

if f08block
  block_exe = executable('block', 'block.f90')
endif

shortcircuit_exe = executable('shortcircuit', 'short_circuit.f90')

bitpat= executable('bitpat', 'bitpat.f90')
test('Bit Pattern', bitpat)

justwait_exe = executable('justwait', 'pause.f90')

mkdirstd = executable('mkdirstd', 'mkdir.f90')
test('mkdir', mkdirstd, args: 'testdir/hello')

sleepstd = executable('sleepstd', 'sleep.f90')
test('Micro sleep', sleepstd, timeout : 1)

statement = executable('statement', 'statement_function.f90')
test('Statement', statement)
