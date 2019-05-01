check_fortran_source_compiles("
use, intrinsic:: ieee_arithmetic, only: ieee_is_nan, ieee_next_after
x=transfer(Z'7FC00000', 1.)
if(ieee_next_after(1., 0.) < 1.) print *, 'ok'
end"
f03ieee SRC_EXT f90)