module fib3
! https://gcc.gnu.org/onlinedocs/gfortran/ISO_005fC_005fBINDING.html
use, intrinsic :: iso_c_binding, only: real32=>C_FLOAT, real64=>C_DOUBLE, qp=>c_long_double
use assert, only: wp
implicit none

contains

pure function FIB(n)

!     CALCULATE FIRST N FIBONACCI NUMBERS
integer, intent(in) :: n
real(wp), dimension(n) :: fib

integer i

fib(:2) = [0, 1]

do I=3,N
  fib(I) = fib(I-1) + fib(I-2)
enddo

end function fib

end module
