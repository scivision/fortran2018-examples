program testall

use, intrinsic:: ieee_arithmetic
use, intrinsic:: iso_fortran_env, only: stderr=>error_unit, sp=>real32, dp=>real64, qp=>real128
use fib3, only: fib
use assert, only: wp, isclose, assert_isclose

implicit none

real(wp), parameter :: pi = 4.*atan(1._wp)

real(wp) :: nan, inf

! NOTE: this triggers nuisance exceptions IEEE_INVALID_FLAG, IEEE_OVERFLOW_FLAG
nan = ieee_value(1._wp,ieee_quiet_nan)
inf = ieee_value(1._wp,ieee_positive_inf)
!--------------------------------------------

!------ Assert

if (isclose(-pi, pi)) error stop
call assert_isclose(ieee_next_after(pi,0.), pi, err_msg='very close fail')
call assert_isclose(pi+0.001, pi, rtol=0.001_wp, atol=0.0001_wp, err_msg='tolerance fail')

call assert_isclose(nan, nan,equal_nan=.true., err_msg='NaN request equality fail')
call assert_isclose(nan, -nan,equal_nan=.true., err_msg='+NaN -Nan request equality fail')
if (isclose(nan,nan)) error stop 'non-equal NaN failure'

call assert_isclose(inf, inf, err_msg='assert +inf equality fail')
if (isclose(-inf, inf)) error stop 'assert -inf  +inf inequality fail'
call assert_isclose(-inf, -inf, err_msg='assert -inf equality fail')

if (isclose(nan,inf)) error stop
if (isclose(inf,nan)) error stop

! denormal
! ifort needs special options to handle these denormal
if (wp==sp.and.isclose(1e-38_wp, 0._wp, atol=0._wp)) error stop 'single precision denormal' 
if (wp==dp.and.isclose(1e-308_wp, 0._wp, atol=0._wp)) error stop 'double precision denormal' 
if (wp==qp.and.isclose(1e-4932_wp, 0._wp, atol=0._wp)) error stop 'quad precision denormal' 
! tiny: 32, 64, 128 bits:
! 1.17549435E-38   2.2250738585072014E-308   3.36210314311209350626267781732175260E-4932

!print*,nan,inf
!-------

!--------- Fibonacci

call assert_isclose(fib(10),[0._wp,1._wp,1._wp,2._wp,3._wp,5._wp,8._wp,13._wp,21._wp,34._wp],err_msg='fibonacci fail')


print *, 'Finite precision: test OK'
end program
