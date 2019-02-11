
if fc.links('contig = is_contiguous(x); end')
  f08contig='1'
else
  f08contig='0'
endif

contig_exe = executable('contig', 'contiguous.F90', fortran_args : '-DISCONTIG'+f08contig)
