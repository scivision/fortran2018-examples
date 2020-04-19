module fib3
use assert, only: wp
implicit none (type, external)

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
