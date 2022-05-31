program poly
! Polymorphic-like real kind at compile time
!
! Output:
! cmake -Drealbits=32      2pi   6.28318548
! cmake -Drealbits=64      2pi   6.2831853071795862
! cmake -Drealbits=128     2pi   6.28318530717958647692528676655900559

use, intrinsic:: iso_fortran_env
implicit none (type, external)

@real_prec@

real(wp), parameter :: pi = 4._wp * atan(1._wp)

print *,'2pi',timestwo(pi)

contains

elemental real(wp) function timestwo(a) result(a2)

real(wp), intent(in) :: a

a2 = 2*a

end function timestwo

end program
