
args = f08contig ? '-DISCONTIG' : []

contig_exe = executable('contig', 'contiguous.F90',
  fortran_args : args)

test('Contiguous', contig_exe,
  suite: 'contiguous',
  timeout: 10)
