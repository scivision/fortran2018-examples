program testall

use, intrinsic:: ieee_arithmetic
use, intrinsic:: iso_fortran_env, only: stderr=>error_unit, sp=>real32, dp=>real64, qp=>real128
use assert

implicit none

real(wp), parameter :: pi = 4.*atan(1._wp)

real(wp) :: nan, inf

! NOTE: this triggers nuisance exceptions IEEE_INVALID_FLAG, IEEE_OVERFLOW_FLAG
nan = ieee_value(1._wp,ieee_quiet_nan)
inf = ieee_value(1._wp,ieee_positive_inf)
!--------------------------------------------

!------ Assert

if (isclose(-pi, pi)) error stop
call assert_isclose(ieee_next_after(pi,0.), pi)
call assert_isclose(pi+0.001, pi, rtol=0.001_wp, atol=0.0001_wp)

call assert_isclose(nan, nan,equal_nan=.true.)
call assert_isclose(nan, -nan,equal_nan=.true.)
if (isclose(nan,nan)) error stop

call assert_isclose(inf, inf)
if (isclose(-inf, inf)) error stop 
call assert_isclose(-inf, -inf)

if (isclose(nan,inf)) error stop
if (isclose(inf,nan)) error stop

! denormal
if (wp==sp.and.isclose(1e-44_wp, 0._wp, atol=0._wp)) error stop 'single precision denormal' 
if (wp==dp.and.isclose(1e-323_wp, 0._wp, atol=0._wp)) error stop 'double precision denormal' 
if (wp==qp.and.isclose(1e-4965_wp, 0._wp, atol=0._wp)) error stop 'quad precision denormal' 

!print*,nan,inf
!-------




print *, 'Test OK'
end program
