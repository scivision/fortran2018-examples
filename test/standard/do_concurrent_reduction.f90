program do_concurrent_reduction
!! code from https://wg5-fortran.org/N2151-N2200/N2194.pdf

implicit none

integer, parameter :: n = 1000000

real :: a, b
real, allocatable :: x(:)
integer :: i

allocate(x(n))

do concurrent (i = 1: n) reduce(+:a) reduce(max:b)
  a = a + x(i)**2
  b = max(b,x(i))
end do


end program
