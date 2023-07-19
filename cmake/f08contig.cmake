# ifort-19 yes, Flang yes, NAG yes, gfortran-8 no, gfortran-9 yes
check_source_compiles(Fortran
"program test
print*, is_contiguous([0,0])
end program"
f08contig
)
