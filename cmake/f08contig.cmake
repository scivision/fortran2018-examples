# ifort-19 yes, Flang yes, NAG yes, gfortran-8 no, gfortran-9 yes
check_fortran_source_compiles(
"program test
print*, is_contiguous([0,0])
end program"
f08contig
SRC_EXT f90
)
