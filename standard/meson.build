f08block = fc.links('block; end block; end', name : 'F2008 block')

if f08block
  block_exe = executable('block', 'block.f90')
endif

short_circuit = executable('shortcircuit', 'short_circuit.f90')
# test is too unreliable--sometimes pass sometimes fail, that's the point.

bitpat= executable('bitpat', 'bitpat.f90')
test('standard:Bit Pattern', bitpat)

justwait_exe = executable('justwait', 'pause.f90')

if fc.get_id()=='intel'
  mkdir_src = files('isdir_intel.f90')
else
  mkdir_src = files('isdir.f90')
endif
mkdirstd = executable('mkdirstd', 'mkdir.f90', mkdir_src)
test('standard:mkdir', mkdirstd, args: 'testdir/hello')

if os != 'windows'
  sleepstd = executable('sleepstd', 'sleep.f90')
  test('standard:Micro sleep', sleepstd, timeout : 1)
endif

statement = executable('statement', 'statement_function.f90')
test('standard:Statement', statement)
