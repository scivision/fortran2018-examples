check_source_compiles(Fortran
"
program a
use, intrinsic :: ieee_arithmetic, only : ieee_next_after
implicit none
print *, ieee_next_after(0.,0.)
end program
"
f03ieee
)
