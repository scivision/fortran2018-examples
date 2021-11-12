program maxmin
!! Fortran standard does NOT specify how to handle NaN vis-a-vis max and min
!! https://gcc.gnu.org/onlinedocs/gfortran/MAX-and-MIN-intrinsics-with-REAL-NaN-arguments.html

use, intrinsic :: ieee_arithmetic
use, intrinsic :: iso_fortran_env, stderr=>error_unit
implicit none (type, external)


real :: A(4), x, y, nan, inf

nan = ieee_value(0., ieee_quiet_nan)
inf = ieee_value(0., ieee_positive_inf)

if(.not.ieee_is_nan(nan)) then
  write(stderr,*) 'NaN: ',nan
endif

A = [0., 1., 2., nan]
print '(4F10.7,A,F10.7)', A, ' maximum is', maxval(A)

x = nan
y = 1.

print '(F10.7,F10.7,A,F10.7)', x,y, ' maximum is ',max(x,y)

! Gfortran, Flang 7 say inf; Intel says NaN
print *,'max of inf() and NaN is', max(inf, nan)

end program
