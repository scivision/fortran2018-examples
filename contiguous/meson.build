if fc.links('contig = is_contiguous(x); end', name: 'F2008 contiguous')
  f08contig='-DISCONTIG'
else
  f08contig=''
endif

if not(os == 'windows' and fc.get_id() == 'gcc')
  contig_exe = executable('contig', 'contiguous.F90',
    fortran_args : f08contig)
  test('Contiguous', contig_exe)
else
  message('contiguous: bug with gfortran on Windows?')
endif