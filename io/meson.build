logging_lib = library('logging', 'logging.f90')

termio = executable('termio', 'terminal_io.f90')

leading_zeros = executable('leading_zeros', 'leading_zeros.f90')
test('LeadingZeros', leading_zeros,
  timeout: 10, suite: 'io')

notermsize = executable('notermsize', 'noenv.f90')
test('NoTermSize', notermsize)

null = executable('null', 'devnull.f90')
test('Nullfile', null, timeout: 10, suite: 'io')


readonly = executable('readonly', 'fileopen-readonly.f90', 'unlink.f90')
test('ReadOnly', readonly, timeout: 10, suite: 'io')

append_exe = executable('test_logging', 'append_file.f90', 'unlink.f90',
  link_with : logging_lib)
