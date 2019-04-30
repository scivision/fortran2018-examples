
if fc.links('contig = is_contiguous(x); end')
  f08contig='-DISCONTIG'
else
  f08contig=''
endif

contig_exe = executable('contig', 'contiguous.F90', fortran_args : f08contig)
