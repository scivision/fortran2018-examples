if fc.get_id() == 'intel-cl'
  message('Intel Fortran on Windows has a continuous bug')
  subdir_done()
endif

if fc.links('contig = is_contiguous([1,2,3]); end', name: 'F2008 contiguous')
  f08contig='-DISCONTIG'
else
  f08contig=''
endif

if fc.get_id() != 'gcc'
  contig_exe = executable('contig', 'contiguous.F90',
    fortran_args : f08contig)
  test('Contiguous', contig_exe)
else
  message('contiguous: Meson bug with gfortran')
endif