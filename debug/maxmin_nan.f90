!! how does Fortran handle NaN vis-a-vis max and min
!! https://groups.google.com/forum/#!topic/comp.lang.fortran/MwVfrvUowHU

use, intrinsic :: ieee_arithmetic
use, intrinsic :: iso_fortran_env, stderr=>error_unit
implicit none

real :: A(4), x, y, nan, inf

nan = ieee_value(0., ieee_quiet_nan)
inf = ieee_value(0., ieee_positive_inf)

if(.not.ieee_is_nan(nan)) then
  write(stderr,*) 'NaN: ',nan
  error stop 'NaN not working correctly'
endif

A = [0., 1., 2., nan]
print *, 'maximum of ',A, 'is', maxval(A)
if(maxval(A) /= 2) error stop 'maxval() not working with NaN'

x = nan
y = 1.

print *, 'maximum of',x,'and',y,'is',max(x,y)
if (max(x,y) /= 1) error stop 'max() not working with NaN'

! Gfortran, Flang 7 say inf; PGI, Intel say NaN
print *,'max of inf() and NaN is', max(inf, nan)


end program
