
if not f08contig
  message('SKIP: contiguous arrays')
  subdir_done()
endif

contig_exe = executable('contig', 'contiguous.f90')

test('Contiguous', contig_exe, suite: 'contiguous', timeout: 10)
