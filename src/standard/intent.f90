module demo

implicit none

contains

subroutine abc()

real, allocatable :: a(:)

allocate(a(1:4))
call out(a)

print *,a
if (.not. allocated(a)) error stop 'should have allocated'

end subroutine abc


subroutine out(a)

real, intent(out) :: a(0:4)


a=[2,3,4,5,6]


end subroutine out

end module demo

program intent
!! explore issues that can arrive over misusing argument intent
!! Fortran 2003 brought auto-allocation (see array/auto_allocate.f90)
!! https://wg5-fortran.org/N1351-N1400/N1379.pdf

use demo, only : abc

call abc()

end program
