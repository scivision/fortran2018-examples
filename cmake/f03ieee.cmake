
check_source_compiles(Fortran
"program test
use, intrinsic:: ieee_arithmetic, only: ieee_is_nan, ieee_next_after
if(ieee_is_nan(0.)) print *, 'oops'
if(ieee_next_after(1., 0.) < 1.) print *, 'ok'
end program"
f03ieee)
