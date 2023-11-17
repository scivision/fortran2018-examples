check_source_compiles(Fortran
"program r
real, rank(2) :: a
!! Equivalent to real :: a(:,:)
end program
"
f2023rank_integer)
