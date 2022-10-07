program finiteness

use, intrinsic:: ieee_arithmetic
use, intrinsic:: iso_fortran_env, only: stderr=>error_unit, sp=>real32, dp=>real64, qp=>real128

use assert, only: isclose, assert_isclose

implicit none

real, parameter :: pi = 4*atan(1.)

real :: nan, inf
real :: A(10)

! NOTE: this triggers nuisance exceptions IEEE_INVALID_FLAG, IEEE_OVERFLOW_FLAG
nan = ieee_value(1.,ieee_quiet_nan)
inf = ieee_value(1.,ieee_positive_inf)
!--------------------------------------------

!------ Assert

if (isclose(-pi, pi)) error stop
call assert_isclose(ieee_next_after(pi,0.), pi, err_msg='very close fail')
call assert_isclose(pi+0.001, pi, rtol=0.001, atol=0.0001, err_msg='tolerance fail')

call assert_isclose(nan, nan,equal_nan=.true., err_msg='NaN request equality fail')
call assert_isclose(nan, -nan,equal_nan=.true., err_msg='+NaN -Nan request equality fail')
if (isclose(nan,nan)) error stop 'non-equal NaN failure'

if (isclose(-inf, inf)) error stop 'assert -inf  +inf inequality fail'

if (isclose(nan,inf)) error stop
if (isclose(inf,nan)) error stop

! denormal
! ifort needs special options to handle these denormal
if (isclose(1e-38, 0., atol=0.)) write(stderr,*) 'single precision denormal'

! if (wp==dp.and.isclose(1e-308, 0., atol=0.)) write(stderr,*) 'double precision denormal'
! if (wp==qp.and.isclose(1e-4932, 0., atol=0.)) write(stderr,*) 'quad precision denormal'

! tiny: 32, 64, 128 bits:
! 1.17549435E-38   2.2250738585072014E-308   3.36210314311209350626267781732175260E-4932

!print*,nan,inf
!-------

!--- test array of values

call fib(size(A), A)
call assert_isclose(A,[0.,1.,1.,2.,3.,5.,8.,13.,21.,34.],err_msg='array fail')

print *, 'Finite precision: test OK'


contains


pure subroutine fib(n, a)
!! CALCULATE FIRST N FIBONACCI NUMBERS
integer, intent(in) :: n
real, intent(out) :: a(n)

integer :: i

a(:2) = [0, 1]

do i = 3,n
  a(i) = a(i-1) + a(i-2)
enddo

end subroutine fib

end program
