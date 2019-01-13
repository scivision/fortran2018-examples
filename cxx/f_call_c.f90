!! Demonstrate Fortran calling C.
!! 
!! Normally BIND(C) should be used after the function name in the interface block.
!!
!! There are various de facto compiler implementations, using no, one, or double underscores pre- or post-pended 
!! to the C function name.
!! New code should use `BIND (C)` after the procedure name instead!

use, intrinsic :: iso_c_binding, only: dp=>c_double, c_int
implicit none

interface

  subroutine timestwo(x, x2, N)  bind (c) 
  !! bind (c) is omitted for legacy code; requires manually adding underscore to C function name

  import
  integer(c_int), value :: N
  real(dp) :: x(N), x2(N)
  end subroutine timestwo

end interface

integer(c_int) :: N, i
real(dp), allocatable :: x(:), x2(:)

N = 3

allocate(x(N), x2(N))

do i=1,N
  x(i) = i
enddo

print '(A,100F7.3)','in: ',x

call timestwo(x, x2, N)

print '(A,100F7.3)','out: ',x2

end program
