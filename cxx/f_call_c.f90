program call_c
!! Demonstrate Fortran calling C.
!!
!! Normally BIND(C) should be used after the function name in the interface block,
!! rather than postpending underscore(s).

use, intrinsic :: iso_c_binding, only: dp=>c_double, c_int
implicit none (type, external)


interface

subroutine timestwo(x, x2, N)  bind (c)
import c_int, dp
integer(c_int), value :: N
real(dp) :: x(N), x2(N)
end subroutine timestwo

end interface

integer(c_int) :: N, i
real(dp), allocatable :: x(:), x2(:)

N = 3

allocate(x(N), x2(N))

!! dummy data
do i=1,N
  x(i) = i
enddo

call timestwo(x, x2, N)

if (any(2*x /= x2)) error stop 'x2 /= 2*x'

end program
