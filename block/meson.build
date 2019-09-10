f08block = fc.links('block; end block; end', name : 'F2008 block')

if f08block
  block_exe = executable('block', 'block.f90')
  test('block', block_exe, timeout: 10)
endif