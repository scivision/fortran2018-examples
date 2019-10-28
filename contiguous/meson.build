
args = f08contig ? '-DISCONTIG' : ''

if fc.get_id() != 'gcc'
  contig_exe = executable('contig', 'contiguous.F90',
    fortran_args : args)
  test('Contiguous', contig_exe)
else
  message('contiguous: Meson bug with gfortran')
endif